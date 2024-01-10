import 'dart:io' show File;

import 'package:flutter/foundation.dart' show Uint8List;
import 'package:services/services.dart';

/// [StorageRepositoryService] is an interface for providing functionality
/// to access any storage to retrieve and store files, images, videos
/// from the domain layer.
///
/// [FO] is the file options type. If you don't need to use file options,
/// you can use [dynamic] as the type.
/// [TO] is the transform options type. If you don't need to use transform
/// options, you can use [dynamic] as the type
abstract interface class StorageRepositoryService {
  /// [retrieveFilePublicUrl] retrieves a file public url from the storage.
  /// This method will return a public url of a [path].
  /// Then you can use this url to access the file.
  Future<Response<String>> retrieveFilePublicUrl(
    String path,
  );

  /// [downloadFile] retrieves a file from the storage.
  Future<Response<Uint8List>> downloadFile(
    String path,
  );

  /// [storeFile] stores a file to the storage.
  /// This will create a new file if the file does not exist.
  /// This should not overwrite an existing file.
  Future<Response<String>> storeFile(
    String path,
    File file,
  );

  /// [overwriteFile] overwrites a file in the storage.
  /// This will should not create a new file if the file does not exist.
  Future<Response<void>> overwriteFile(
    String path,
    File file,
  );

  /// [moveAnExistingFile] moves an existing file in the storage.
  /// This method move a file at [oldPath] to [newPath].
  Future<Response<void>> moveAnExistingFile(
    String bucket,
    String oldPath,
    String newPath,
  );

  /// [deleteFile] deletes a file from the storage.
  Future<Response<void>> deleteFile(String path);

  /// [deleteFiles] deletes multiple files from the storage.
  Future<Response<void>> deleteFiles(
    List<String> paths,
  );
}
