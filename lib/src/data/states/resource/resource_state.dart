import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_state.freezed.dart';

/// A tagged union type / sealed class representing the state of resource data
/// being manipulated and/or fetched.
///
/// Properties:
///
/// [ResourceState.loading]
///
/// [ResourceState.success]
///
/// [ResourceState.error]
@freezed
class ResourceState<T> with _$ResourceState<T> {
  const factory ResourceState.loading([T? data]) = ResourceLoading<T>;

  const factory ResourceState.success({
    String? code,
    String? message,
    required T data,
  }) = ResourceSuccess<T>;

  const factory ResourceState.error({
    String? code,
    String? message,
    String? stacktrace,
    T? data,
  }) = ResourceError<T>;

  const factory ResourceState.initial() = ResourceInitial<T>;
}
