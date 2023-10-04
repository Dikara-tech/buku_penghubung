import 'dart:async';
import 'dart:math' as math;

import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:dio/dio.dart';

/// A dio interceptor that attempts to retry the request with exponential
/// backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    this.delayFactor = const Duration(milliseconds: 200),
    this.randomizationFactor = 0.25,
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 3,
    this.retryableHttpStatus = const {
      408,
      429,
      500,
      502,
      503,
      504,
      520,
      521,
      522,
      523,
      524,
      527,
    },
    this.logPrint = print,
  });

  /// Delay factor to double after every attempt.
  ///
  /// Defaults to 200 ms, which results in the following delays:
  ///
  ///  1. 400 ms
  ///  2. 800 ms
  ///  3. 1600 ms
  ///
  /// Before application of [randomizationFactor].
  final Duration delayFactor;

  /// Percentage the delay should be randomized, given as fraction between
  /// 0 and 1.
  ///
  /// If [randomizationFactor] is `0.25` (default) this indicates 25 % of the
  /// delay should be increased or decreased by 25 %.
  final double randomizationFactor;

  /// Maximum delay between retries, defaults to 30 seconds.
  final Duration maxDelay;

  /// HTTP status code that are allowed to be retried.
  final Set<int> retryableHttpStatus;

  /// Maximum number of attempts before giving up, defaults to 3.
  final int maxAttempts;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(Object object) logPrint;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.disableRetry) return super.onError(err, handler);
    final attempt = err.requestOptions._attempt + 1;
    final shouldRetry = attempt <= maxAttempts && _retryEvaluator(err, attempt);

    if (!shouldRetry) return super.onError(err, handler);

    err.requestOptions._attempt = attempt;
    final delay = _getDelay(attempt);

    logPrint.call(
      '[${err.requestOptions.uri}] An error occurred during request, '
      'trying again...\n'
      'attempt: $attempt/$maxAttempts\n'
      'delay: ${delay.inMilliseconds} ms\n'
      'error: ${err.error}',
    );

    if (delay != Duration.zero) await Future<void>.delayed(delay);

    try {
      await inject<Dio>()
          .fetch<void>(err.requestOptions)
          .then((value) => handler.resolve(value));
    } on DioException catch (e) {
      super.onError(e, handler);
    }
  }

  final _rand = math.Random();

  Duration _getDelay(int attempt) {
    assert(attempt >= 0, 'attempt cannot be negative');
    if (attempt <= 0) {
      return Duration.zero;
    }
    final rf = randomizationFactor * (_rand.nextDouble() * 2 - 1) + 1;
    final exp = math.min(attempt, 31); // prevent overflows.
    final delay = delayFactor * math.pow(2.0, exp) * rf;
    return delay < maxDelay ? delay : maxDelay;
  }

  bool _retryEvaluator(DioException error, int attempt) {
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      return statusCode != null && retryableHttpStatus.contains(statusCode);
    } else {
      return error.type != DioExceptionType.cancel;
    }
  }
}

extension RequestOptionsX on RequestOptions {
  static const _kAttemptKey = 'ro_attempt';
  static const _kDisableRetryKey = 'ro_disable_retry';

  int get _attempt => (extra[_kAttemptKey] as int?) ?? 0;

  set _attempt(int value) => extra[_kAttemptKey] = value;

  bool get disableRetry => (extra[_kDisableRetryKey] as bool?) ?? false;

  set disableRetry(bool value) => extra[_kDisableRetryKey] = value;
}
