/// [StorageResponse] is the response of the storage.
/// This class is used to create a storage response.
///
/// [T] is the type of the response data.
class StorageResponse<T> {
  /// Creates a [StorageResponse].
  const StorageResponse({
    required this.success,
    this.data,
    this.message,
  }) : assert(
          success && data != null && message == null ||
              !success && data == null && message != null,
          'Storage response is invalid',
        );

  /// Creates a [StorageResponse] with a successful response.
  const StorageResponse.success({
    this.data,
  })  : success = true,
        message = null;

  /// Creates a [StorageResponse] with a failed response.
  const StorageResponse.failure({
    required this.message,
  })  : success = false,
        data = null;

  /// Creates a [StorageResponse] with an unknown response
  /// cause by an unknown error with [action].
  const StorageResponse.unknown({
    required String action,
  })  : success = false,
        data = null,
        message = 'Unknown error occurred while $action';

  /// [data] is the response data of the storage.
  /// If the response is failed, this should be null.
  final T? data;

  /// [success] is the response success status of the storage.
  final bool success;

  /// [message] is the response message of the storage. If the response is
  /// successful, this should be null.
  final String? message;
}
