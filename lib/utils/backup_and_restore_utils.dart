import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as en;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'snack_bar_data.dart';
import 'snack_bar_utils.dart';

// Font family is set as "_"
const fontFamily = null;
const titleWeight = FontWeight.w500;
const contentWeight = FontWeight.normal;

Future<void> backupAction({
  required BuildContext context,
  required String backupData,
  required String localFile,
  required int androidVersion,
  required void Function(bool) loadingChange,
}) =>
    _LocalBackup.localBackup(
      backupData: backupData,
      fileName: localFile,
      androidVersion: androidVersion,
      confirmRequest: () => _confirmRequest(context, true),
      onStart: () => loadingChange(true),
      onDone: (file) {
        loadingChange(false);
        showSnackBar(
          const SnackBarData(message: 'Backup completed successfully.'),
        );
      },
      onError: (error) {
        loadingChange(false);
        showSnackBar(SnackBarData(message: error));
      },
    );

Future<void> restoreAction({
  required BuildContext context,
  required Future<bool> Function(String) restore,
  required void Function(bool) loadingChange,
}) =>
    _LocalRestore.localRestore(
      confirmRequest: () => _confirmRequest(context, false),
      onStart: () => loadingChange(true),
      onDone: (data) async {
        final isDone = await restore(data);
        loadingChange(false);
        showSnackBar(
          SnackBarData(
            message: isDone
                ? 'Restore completed successfully.'
                : 'Error while restoring',
          ),
        );
      },
      onError: (error) {
        loadingChange(false);
        showSnackBar(SnackBarData(message: error));
      },
    );

Future<bool> _confirmRequest(BuildContext context, bool backup) async {
  final message = backup
      ? 'Do you want to backup current data ?'
      : 'Do you want to restore the previous backup ?';
  final request = await _showCustomDialog<bool>(
    context: context,
    title: 'Are you sure ?',
    content: message,
    actionsBuilder: (context) => [
      _CustomDialogAction(
        text: 'No',
        onTap: () => Navigator.pop(context, false),
      ),
      _CustomDialogAction(
        text: 'Yes',
        onTap: () => Navigator.pop(context, true),
      ),
    ],
  );
  return request ?? false;
}

class _MyEncrypt {
  static final _key = en.Key.fromLength(32);
  static final _iv = en.IV.fromLength(16);
  static final _encrypter = en.Encrypter(en.AES(_key));

  static String encryptAES(String text) =>
      _encrypter.encrypt(text, iv: _iv).base16;

  static String decryptAES(String encrypt) =>
      _encrypter.decrypt16(encrypt, iv: _iv);
}

Future<T?> _showCustomDialog<T>({
  required BuildContext context,
  String? title,
  required String content,
  Widget Function(TextStyle style)? body,
  TextAlign contentAlign = TextAlign.center,
  required List<_CustomDialogAction<T>> Function(BuildContext context)
      actionsBuilder,
}) =>
    showDialog<T>(
      context: context,
      useSafeArea: true,
      builder: (context) {
        final actions = actionsBuilder(context);
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: titleWeight,
                    fontFamily: fontFamily,
                    fontSize: 20,
                  ),
                )
              : null,
          content: body != null
              ? body(const TextStyle(
                  fontWeight: contentWeight,
                  fontSize: 17,
                  fontFamily: fontFamily,
                ))
              : Text(
                  content,
                  textAlign: contentAlign,
                  style: const TextStyle(
                    fontWeight: contentWeight,
                    fontSize: 17,
                    fontFamily: fontFamily,
                  ),
                ),
          actions: actions.map((e) => _buildAction(context, e)).toList(),
        );
      },
    );

Widget _buildAction<T>(BuildContext context, _CustomDialogAction<T> value) {
  return TextButton(
    onPressed: value.onTap,
    child: Text(
      value.text,
      style: TextStyle(
        color: value.color,
        fontWeight: contentWeight,
        fontSize: 15,
        fontFamily: fontFamily,
      ),
    ),
  );
}

class _CustomDialogAction<T> {
  final String text;
  final Color? color;
  final VoidCallback? onTap;

  _CustomDialogAction({
    required this.text,
    this.color,
    required this.onTap,
  });
}

class _LocalBackup {
  static Future<void> localBackup({
    required String backupData,
    required String fileName,
    required int androidVersion,
    required Future<bool> Function() confirmRequest,
    required VoidCallback onStart,
    required void Function(File) onDone,
    required void Function(String) onError,
  }) async {
    final confirm = await confirmRequest();
    if (!confirm) return;
    var granted = await (androidVersion > 29
            ? Permission.manageExternalStorage
            : Permission.storage)
        .isGranted;
    if (!granted) {
      granted = (await (androidVersion > 29
                  ? Permission.manageExternalStorage
                  : Permission.storage)
              .request())
          .isGranted;
    }
    if (granted) {
      onStart();
      try {
        final folderName = await FilePicker.platform.getDirectoryPath();
        if (folderName != null) {
          final result = await compute(
            _buckupIsolate,
            jsonEncode([folderName, fileName, backupData]),
          );
          onDone(result);
        }
      } catch (e) {
        if (kDebugMode) print(e);
        onError(e.toString());
      }
    } else {
      onError('Storage permission required');
    }
  }
}

Future<File> _buckupIsolate(String json) async {
  final decode = (jsonDecode(json) as List).cast<String>();
  final folderName = decode[0];
  final fileName = decode[1];
  final backupData = decode[2];
  final file = File('$folderName/$fileName');
  final encrypt = _MyEncrypt.encryptAES(backupData);
  return file.writeAsBytes(encrypt.codeUnits);
}

class _LocalRestore {
  static Future<String?> _pickLocalFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path;
      if (path != null && path.endsWith('.bk')) return path;
    }
    return null;
  }

  static Future<void> localRestore({
    required Future<bool> Function() confirmRequest,
    required VoidCallback onStart,
    required void Function(String) onDone,
    required void Function(String) onError,
  }) async {
    final confirm = await confirmRequest();
    if (!confirm) return;
    try {
      final filePath = await _pickLocalFile();
      if (filePath != null) {
        onStart();
        final result = await compute(_restoreIsolate, filePath);
        onDone(result);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      onError(e.toString());
    }
  }
}

Future<String> _restoreIsolate(String filePath) async {
  final file = File(filePath);
  return _MyEncrypt.decryptAES(await file.readAsString());
}
