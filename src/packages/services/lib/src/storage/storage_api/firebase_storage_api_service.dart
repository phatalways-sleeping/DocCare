import 'dart:io';

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:services/src/response/response.dart';
import 'package:services/src/storage/storage_api_service.dart';

/// [FirebaseStorageApiService] is an implementation of [StorageApiService]
/// for Firebase storage.
class FirebaseStorageApiService implements StorageApiService {
  /// Creates a [FirebaseStorageApiService].
  const FirebaseStorageApiService(this.storage);

  /// [storage] is the firebase storage client.
  final FirebaseStorage storage;

  @override
  Future<Response<void>> deleteDirectory(String bucket) {
    // Since FirebaseStorage only stores in one bucket, we can't delete the
    // bucket.
    return Future.value(
      const Response<void>.failure(
        message: 'This method is not supported in Firebase storage.',
      ),
    );
  }

  @override
  Future<Response<void>> deleteFile(String bucket, String path) async {
    try {
      await storage.ref().child(path).delete();
      return Future.value(const Response<void>.success());
    } on FirebaseException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'deleting a file'),
      );
    }
  }

  @override
  Future<Response<void>> deleteFiles(String bucket, List<String> paths) {
    try {
      final futures = <Future<void>>[];
      for (final path in paths) {
        futures.add(storage.ref().child(path).delete());
      }
      return Future.wait(futures).then(
        (_) => const Response<void>.success(),
      );
    } on FirebaseException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'deleting multiple files'),
      );
    }
  }

  @override
  Future<Response<bool>> directoryExists(String bucket, String path) {
    try {
      return storage.ref().child(path).listAll().then(
            (_) => const Response<bool>.success(data: true),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        Response<bool>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'checking if directory exists'),
      );
    }
  }

  @override
  Future<Response<Uint8List>> downloadFile(
    String bucket,
    String path,
  ) {
    try {
      return storage.ref().child(path).getData().then(
            (data) => Response<Uint8List>.success(data: data),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        Response<Uint8List>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'downloading a file'),
      );
    }
  }

  @override
  Future<Response<bool>> fileExists(String bucket, String path) {
    try {
      return storage.ref().child(path).getMetadata().then(
            (_) => const Response<bool>.success(data: true),
          );
    } on FirebaseException catch (e) {
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
  Future<Response<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) async {
    try {
      final file = await storage.ref().child(oldPath).getData();
      if (file == null) {
        return const Response<void>.failure(
          message: 'File does not exist.',
        );
      }
      await storage.ref().child(newPath).putData(file);
      await storage.ref().child(oldPath).delete();
      return const Response<void>.success();
    } on FirebaseException catch (e) {
      return Future.value(
        Response<void>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'moving a file'),
      );
    }
  }

  @override
  Future<Response<void>> overwriteFile(
    String bucket,
    String path,
    File file,
  ) {
    try {
      return storage.ref().child(path).putFile(file).then(
            (_) => const Response<void>.success(),
          );
    } on FirebaseException catch (e) {
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
    String path,
  ) {
    try {
      return storage.ref().child(path).getDownloadURL().then(
            (url) => Response<String>.success(data: url),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        Response<String>.failure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Future.value(
        const Response.unknown(action: 'retrieving file public url'),
      );
    }
  }

  @override
  Future<Response<String>> storeFile(
    String bucket,
    String path,
    File file,
  ) {
    try {
      return storage.ref().child(path).putFile(file).then(
            (value) async => Response<String>.success(
              data: await value.ref.getDownloadURL(),
            ),
          );
    } on FirebaseException catch (e) {
      return Future.value(
        Response<String>.failure(
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
