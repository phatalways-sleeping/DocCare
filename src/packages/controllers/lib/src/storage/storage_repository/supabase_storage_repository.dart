import 'dart:io' show File;

import 'package:controllers/src/storage/storage_repository_service.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseStorageRepository] is an implementation of
/// [StorageRepositoryService] for Supabase storage.
class SupabaseStorageRepository
    implements StorageRepositoryService {
  /// Creates a [SupabaseStorageRepository].
  SupabaseStorageRepository();
  
  // We have to declare the SupabaseStorageApiService here
  // because we need to pass the TransformOptions and FileOptions
  // This is a special case for Supabase.
  final SupabaseStorageApiService _storageApiService =
      SupabaseStorageApiService(Supabase.instance.client.storage);

  // Existing buckets in Supabase storage.
  final String _imageBucket = 'images';
  final String _videoBucket = 'videos';
  final String _fileBucket = 'files';

  String _getBucketFromPath(String path) {
    final type = path.split('.').last;
    switch (type) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return _imageBucket;
      case 'mp4':
      case 'mov':
        return _videoBucket;
      default:
        return _fileBucket;
    }
  }

  @override
  Future<Response<void>> deleteFile(
    String path,
  ) {
    // We need to get the bucket name from the path.
    // Depending on the file type, the bucket name can be different.
    final bucket = _getBucketFromPath(path);
    return _storageApiService.deleteFile(bucket, path);
  }

  @override
  Future<Response<void>> deleteFiles(
    List<String> paths,
  ) async {
    final buckets = <String, List<String>>{};
    // Group the paths by the bucket name.
    for (final path in paths) {
      final bucket = _getBucketFromPath(path);
      if (buckets.containsKey(bucket)) {
        buckets[bucket]!.add(path);
      } else {
        buckets[bucket] = [path];
      }
    }
    final responses = await Future.wait([
      for (final bucket in buckets.keys)
        _storageApiService.deleteFiles(bucket, buckets[bucket]!),
    ]);
    // Check if there is any failed response.
    final failedResponse = responses.where(
      (response) => !response.success,
    );
    if (failedResponse.isNotEmpty) {
      // Concate all failed response messages and return a failed response.
      return Response<void>.failure(
        message: failedResponse.map((response) => response.message).join('\n'),
      );
    }
    // If all responses are successful, return a successful response.
    return const Response<void>.success();
  }

  @override
  Future<Response<Uint8List>> downloadFile(
    String path, {
    TransformOptions? transformOptions,
  }) {
    final bucket = _getBucketFromPath(path);
    return _storageApiService.downloadFile(
      bucket,
      path,
      transformOptions: transformOptions,
    );
  }

  @override
  Future<Response<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) {
    final oldBucket = _getBucketFromPath(oldPath);
    final newBucket = _getBucketFromPath(newPath);
    if (oldBucket != newBucket) {
      // Different buckets, means different file types
      // We only allow moving files in the same bucket.
      return Future.value(
        const Response<void>.failure(
          message: 'Cannot move file to a different bucket',
        ),
      );
    }
    // If the old bucket and the new bucket are the same,
    // we can just move the file in the same bucket.
    return _storageApiService.moveAnExistingFile(bucket, oldPath, newPath);
  }

  @override
  Future<Response<void>> overwriteFile(
    String path,
    File file, {
    FileOptions? fileOptions,
  }) {
    final bucket = _getBucketFromPath(path);
    return _storageApiService.overwriteFile(
      bucket,
      path,
      file,
      fileOptions: fileOptions,
    );
  }

  @override
  Future<Response<String>> retrieveFilePublicUrl(
    String path, {
    FileOptions? fileOptions,
    TransformOptions? transformOptions,
  }) {
    final bucket = _getBucketFromPath(path);
    return _storageApiService.retrieveFilePublicUrl(
      bucket,
      path,
      fileOptions: fileOptions,
      transformOptions: transformOptions,
    );
  }

  @override
  Future<Response<String>> storeFile(
    String path,
    File file, {
    FileOptions? fileOptions,
  }) {
    final bucket = _getBucketFromPath(path);
    return _storageApiService.storeFile(
      bucket,
      path,
      file,
      fileOptions: fileOptions,
    );
  }
}
