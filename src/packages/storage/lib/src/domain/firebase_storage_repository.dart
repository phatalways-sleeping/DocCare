import 'dart:io' show File;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:storage/storage.dart';

/// [FirebaseStorageRepository] is an implementation of
/// [StorageRepositoryService] for Firebase storage in the domain layer.
class FirebaseStorageRepository implements StorageRepositoryService {
  /// Creates a [FirebaseStorageRepository].
  FirebaseStorageRepository._();

  /// [instance] is the singleton instance of [FirebaseStorageRepository].
  static final instance = FirebaseStorageRepository._();

  /// [storage] is the instance implements [StorageApiService].
  final StorageApiService storage = FirebaseStorageApiService(
    FirebaseStorage.instance,
  );

  /// [kFirbaseStorageBucket] is the placeholder for the bucket name.
  /// Firebase storage only stores in one bucket.
  final String kFirbaseStorageBucket = '';

  @override
  Future<StorageResponse<void>> deleteFile(String path) => storage.deleteFile(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<StorageResponse<void>> deleteFiles(List<String> paths) =>
      storage.deleteFiles(
        kFirbaseStorageBucket,
        paths,
      );

  @override
  Future<StorageResponse<Uint8List>> downloadFile(
    String path,
  ) =>
      storage.downloadFile(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<StorageResponse<void>> moveAnExistingFile(
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
  Future<StorageResponse<void>> overwriteFile(
    String path,
    File file,
  ) =>
      storage.overwriteFile(
        kFirbaseStorageBucket,
        path,
        file,
      );

  @override
  Future<StorageResponse<String>> retrieveFilePublicUrl(
    String path,
  ) =>
      storage.retrieveFilePublicUrl(
        kFirbaseStorageBucket,
        path,
      );

  @override
  Future<StorageResponse<void>> storeFile(
    String path,
    File file,
  ) =>
      storage.storeFile(
        kFirbaseStorageBucket,
        path,
        file,
      );
}
