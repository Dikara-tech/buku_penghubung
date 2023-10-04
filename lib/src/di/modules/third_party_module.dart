import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModule {
  Dio get dio {
    final dio = Dio();
    dio
      ..options.headers.addAll(<String, dynamic>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      })
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
        DioCacheInterceptor(
          options: CacheOptions(
            store: MemCacheStore(
              maxSize: 20971520,
              maxEntrySize: 1572864,
            ),
            allowPostMethod: true,
          ),
        ),
      ]);

    return dio;
  }

  @android
  @lazySingleton
  @preResolve
  Future<AndroidDeviceInfo> get androidDeviceInfo =>
      DeviceInfoPlugin().androidInfo;

  @ios
  @lazySingleton
  @preResolve
  Future<IosDeviceInfo> get iosDeviceInfo => DeviceInfoPlugin().iosInfo;

  @lazySingleton
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @lazySingleton
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  Logger get logger => Logger();
}
