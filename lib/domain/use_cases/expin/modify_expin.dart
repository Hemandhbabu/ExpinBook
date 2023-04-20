import 'dart:io' show File;

import 'package:flutter/foundation.dart';

import '../../models/expin.dart';
import '../../repositories/expin_repository.dart';

class ModifyExpin {
  final ExpinRepository _repository;

  const ModifyExpin(this._repository);

  Future<bool> add(Expin expin) async {
    return _repository.insert(expin).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<Expin> expins) {
    return _repository.insertAll(expins);
  }

  Future<bool> update(Expin expin) {
    return _repository.update(expin);
  }

  void _deleteImage(String? path) {
    if (path == null) return;
    try {
      File(path).deleteSync();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> delete(Expin expin) {
    try {
      _deleteImage(expin.imagePath);
      return _repository.delete(expin);
    } catch (e) {
      return Future.value(false);
    }
  }
}
