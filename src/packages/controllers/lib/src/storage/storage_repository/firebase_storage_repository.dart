import 'dart:io' show File;

import 'package:controllers/src/storage/storage_repository_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:services/services.dart';

/// [FirebaseStorageRepository] is an implementation of
/// [StorageRepositoryService] for Firebase storage in the domain layer.
class FirebaseStorageRepository implements StorageRepositoryService {
  /// Creates a [FirebaseStorageRepository].
  FirebaseStorageRepository();

  /// [storage] is the instance implements [StorageApiService].
  final StorageApiService storage = FirebaseStorageApiService(
    FirebaseStorage.instance,
  );

  /// [kFirbaseStorageBucket] is the placeholder for the bucket name.
  /// Firebase storage only stores in one bucket.
  final String kFirbaseStorageBucket = '';

  @override
  Future<Response<void>> deleteFile(String path) => storage.deleteFile(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<Response<void>> deleteFiles(List<String> paths) =>
      storage.deleteFiles(
        kFirbaseStorageBucket,
        paths,
      );

  @override
  Future<Response<Uint8List>> downloadFile(
    String path,
  ) =>
      storage.downloadFile(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<Response<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  ) =>
      storage.moveAnExistingFile(
        kFirbaseStorageBucket,
        oldPath,
        newPath,
      );

  @override
  Future<Response<void>> overwriteFile(
    String path,
    File file,
  ) =>
      storage.overwriteFile(
        kFirbaseStorageBucket,
        path,
        file,
      );

  @override
  Future<Response<String>> retrieveFilePublicUrl(
    String path,
  ) =>
      storage.retrieveFilePublicUrl(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<Response<void>> storeFile(
    String path,
    File file,
  ) =>
      storage.storeFile(
        kFirbaseStorageBucket,
        path,
        file,
      );
}
