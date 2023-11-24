import 'dart:io';

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:storage/src/api/api.dart';
import 'package:storage/src/response/storage_response.dart';

/// [FirebaseStorageApiService] is an implementation of [StorageApiService]
/// for Firebase storage.
class FirebaseStorageApiService implements StorageApiService {
  /// Creates a [FirebaseStorageApiService].
  const FirebaseStorageApiService(this.storage);

  /// [storage] is the firebase storage client.
  final FirebaseStorage storage;

  @override
  Future<StorageResponse<void>> deleteDirectory(String bucket) {
    // Since FirebaseStorage only stores in one bucket, we can't delete the
    // bucket.
    return Future.value(
      const StorageResponse<void>.failure(
        message: 'This method is not supported in Firebase storage.',
      ),
    );
  }

  @override
  Future<StorageResponse<void>> deleteFile(String bucket, String path) async {
    try {
      await storage.ref().child(path).delete();
      return Future.value(const StorageResponse<void>.success());
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'deleting a file'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> deleteFiles(String bucket, List<String> paths) {
    try {
      final futures = <Future<void>>[];
      for (final path in paths) {
        futures.add(storage.ref().child(path).delete());
      }
      return Future.wait(futures).then(
        (_) => const StorageResponse<void>.success(),
      );
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'deleting multiple files'),
      );
    }
  }

  @override
  Future<StorageResponse<bool>> directoryExists(String bucket, String path) {
    try {
      return storage.ref().child(path).listAll().then(
            (_) => const StorageResponse<bool>.success(data: true),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'checking if directory exists'),
      );
    }
  }

  @override
  Future<StorageResponse<Uint8List>> downloadFile(
    String bucket,
    String path,
  ) {
    try {
      return storage.ref().child(path).getData().then(
            (data) => StorageResponse<Uint8List>.success(data: data),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<Uint8List>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'downloading a file'),
      );
    }
  }

  @override
  Future<StorageResponse<bool>> fileExists(String bucket, String path) {
    try {
      return storage.ref().child(path).getMetadata().then(
            (_) => const StorageResponse<bool>.success(data: true),
          );
    } on FirebaseException catch (e) {
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
  Future<StorageResponse<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) async {
    try {
      final file = await storage.ref().child(oldPath).getData();
      if (file == null) {
        return const StorageResponse<void>.failure(
          message: 'File does not exist.',
        );
      }
      await storage.ref().child(newPath).putData(file);
      await storage.ref().child(oldPath).delete();
      return const StorageResponse<void>.success();
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'moving a file'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> overwriteFile(
    String bucket,
    String path,
    File file,
  ) {
    try {
      return storage.ref().child(path).putFile(file).then(
            (_) => const StorageResponse<void>.success(),
          );
    } on FirebaseException catch (e) {
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
    String path,
  ) {
    try {
      return storage.ref().child(path).getDownloadURL().then(
            (url) => StorageResponse<String>.success(data: url),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        StorageResponse<String>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const StorageResponse.unknown(action: 'retrieving file public url'),
      );
    }
  }

  @override
  Future<StorageResponse<void>> storeFile(
    String bucket,
    String path,
    File file,
  ) {
    try {
      return storage.ref().child(path).putFile(file).then(
            (_) => const StorageResponse<void>.success(),
          );
    } on FirebaseException catch (e) {
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
