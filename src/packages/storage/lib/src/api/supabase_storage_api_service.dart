import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:storage/src/api/storage_api_service.dart';
import 'package:storage/src/response/storage_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseStorageApiService] is an implementation of [StorageApiService]
/// for Supabase storage.
class SupabaseStorageApiService
    implements StorageApiService<FileOptions, TransformOptions> {
  /// Creates a [SupabaseStorageApiService].
  SupabaseStorageApiService(this.storage);

  /// [storage] is the supabase client.
  final SupabaseStorageClient storage;

  @override
  Future<StorageResponse<void>> deleteDirectory(
    String bucket,
  ) async {
    try {
      // Clear the directory first.
      await storage.emptyBucket(bucket);
      await storage.deleteBucket(bucket);
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'deleting a directory'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) async {
    try {
      await storage.from(bucket).move(oldPath, newPath);
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'moving an existing file'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> deleteFile(
    String bucket,
    String path,
  ) async {
    try {
      await storage.from(bucket).remove([path]);
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: 'Cannot delete file: ${path.split('/').last}\n${e.message}',
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'deleting a file'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> deleteFiles(
    String bucket,
    List<String> paths,
  ) async {
    try {
      await storage.from(bucket).remove(paths);
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      final pathNames = paths.map((path) => path.split('/').last).join(', ');
      return Future.value(
        StorageResponse<void>.failure(
            message: 'Cannot delete files: $pathNames\n${e.message}'),
      );
    } catch (e) {
      final pathNames = paths.map((path) => path.split('/').last).join(', ');
      return Future.value(
        StorageResponse.unknown(action: 'deleting $pathNames}'),
      );
    }
  }

  @override
  Future<StorageResponse<bool>> directoryExists(
    String bucket,
    String directoryName,
  ) async {
    try {
      final response = await storage
          .from(bucket)
          .list()
          .then((files) => files.map((e) => e.name.split('/').first).toList());
      return Future.value(
        StorageResponse<bool>.success(
          data: response.firstWhere((element) => element == directoryName) ==
              directoryName,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'checking if a directory exists'),
      );
    }
  }

  @override
  Future<StorageResponse<Uint8List>> downloadFile(
    String bucket,
    String path, {
    TransformOptions? transformOptions,
  }) async {
    try {
      final response = await storage.from(bucket).download(
            path,
            transform: transformOptions,
          );
      return Future.value(
        StorageResponse<Uint8List>.success(
          data: response,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<Uint8List>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(
          action: 'downloading a file from storage',
        ),
      );
    }
  }

  @override
  Future<StorageResponse<bool>> fileExists(String bucket, String path) async {
    try {
      return await storage.from(bucket).list().then(
            (files) => StorageResponse<bool>.success(
              data: files.any((element) => element.name == path),
            ),
          );
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'checking if a file exists'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> overwriteFile(
    String bucket,
    String path,
    File file, {
    FileOptions? fileOptions,
  }) async {
    try {
      await storage.from(bucket).upload(
            path,
            file,
            fileOptions: FileOptions(
              cacheControl: fileOptions?.cacheControl ?? '3600',
              upsert: fileOptions?.upsert ?? false,
            ),
          );
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'overwriting a file'),
      );
    }
  }

  @override
  Future<StorageResponse<String>> retrieveFilePublicUrl(
    String bucket,
    String path, {
    FileOptions? fileOptions,
    TransformOptions? transformOptions,
  }) async {
    try {
      final response = storage.from(bucket).getPublicUrl(
            path,
            transform: transformOptions,
          );
      return Future.value(
        StorageResponse<String>.success(
          data: response,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<String>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(
          action: 'retrieving a file public url',
        ),
      );
    }
  }

  @override
  Future<StorageResponse<void>> storeFile(
    String bucket,
    String path,
    File file, {
    FileOptions? fileOptions,
  }) async {
    try {
      await storage.from(bucket).upload(
            path,
            file,
            fileOptions: FileOptions(
              cacheControl: fileOptions?.cacheControl ?? '3600',
              upsert: fileOptions?.upsert ?? false,
            ),
          );
      return Future.value(const StorageResponse<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'storing a file'),
      );
    }
  }
}
