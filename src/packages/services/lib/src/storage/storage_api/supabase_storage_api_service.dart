import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:services/src/response/response.dart';
import 'package:services/src/storage/storage_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseStorageApiService] is an implementation of [StorageApiService]
/// for Supabase storage.
class SupabaseStorageApiService implements StorageApiService {
  /// Creates a [SupabaseStorageApiService].
  const SupabaseStorageApiService(this.storage);

  /// [storage] is the supabase client.
  final SupabaseStorageClient storage;

  @override
  Future<Response<void>> deleteDirectory(
    String bucket,
  ) async {
    try {
      // Clear the directory first.
      await storage.emptyBucket(bucket);
      await storage.deleteBucket(bucket);
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'deleting a directory'),
      );
    }
  }

  @override
  Future<Response<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) async {
    try {
      await storage.from(bucket).move(oldPath, newPath);
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'moving an existing file'),
      );
    }
  }

  @override
  Future<Response<void>> deleteFile(
    String bucket,
    String path,
  ) async {
    try {
      await storage.from(bucket).remove([path]);
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: 'Cannot delete file: ${path.split('/').last}\n${e.message}',
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'deleting a file'),
      );
    }
  }

  @override
  Future<Response<void>> deleteFiles(
    String bucket,
    List<String> paths,
  ) async {
    try {
      await storage.from(bucket).remove(paths);
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      final pathNames = paths.map((path) => path.split('/').last).join(', ');
      return Future.value(
        Response<void>.failure(
            message: 'Cannot delete files: $pathNames\n${e.message}'),
      );
    } catch (e) {
      final pathNames = paths.map((path) => path.split('/').last).join(', ');
      return Future.value(
        Response.unknown(action: 'deleting $pathNames}'),
      );
    }
  }

  @override
  Future<Response<bool>> directoryExists(
    String bucket,
    String directoryName,
  ) async {
    try {
      final response = await storage
          .from(bucket)
          .list()
          .then((files) => files.map((e) => e.name.split('/').first).toList());
      return Future.value(
        Response<bool>.success(
          data: response.firstWhere((element) => element == directoryName) ==
              directoryName,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        Response<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'checking if a directory exists'),
      );
    }
  }

  @override
  Future<Response<Uint8List>> downloadFile(
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
        Response<Uint8List>.success(
          data: response,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        Response<Uint8List>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(
          action: 'downloading a file from storage',
        ),
      );
    }
  }

  @override
  Future<Response<bool>> fileExists(String bucket, String path) async {
    try {
      return await storage.from(bucket).list().then(
            (files) => Response<bool>.success(
              data: files.any((element) => element.name == path),
            ),
          );
    } on StorageException catch (e) {
      return Future.value(
        Response<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'checking if a file exists'),
      );
    }
  }

  @override
  Future<Response<void>> overwriteFile(
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
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'overwriting a file'),
      );
    }
  }

  @override
  Future<Response<String>> retrieveFilePublicUrl(
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
        Response<String>.success(
          data: response,
        ),
      );
    } on StorageException catch (e) {
      return Future.value(
        Response<String>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(
          action: 'retrieving a file public url',
        ),
      );
    }
  }

  @override
  Future<Response<void>> storeFile(
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
      return Future.value(const Response<void>.success());
    } on StorageException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'storing a file'),
      );
    }
  }
}
