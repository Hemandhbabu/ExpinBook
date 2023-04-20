import 'package:flutter/material.dart';

class CustomDialogAction<T> {
  final String text;
  final Color? color;
  final VoidCallback? onTap;

  CustomDialogAction({
    required this.text,
    this.color,
    required this.onTap,
  });
}

Widget _buildAction<T>(CustomDialogAction<T> value) {
  return TextButton(
    style: TextButton.styleFrom(foregroundColor: value.color),
    onPressed: value.onTap,
    child: Text(value.text),
  );
}

Widget buildCustomDialog<T>({
  String? title,
  double? titleFontSize,
  FontWeight? titleFontWeight,
  required Widget content,
  required List<CustomDialogAction<T>> actions,
}) =>
    AlertDialog(
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: titleFontWeight,
                fontSize: titleFontSize,
              ),
            )
          : null,
      content: content,
      actions: actions.map(_buildAction).toList(),
    );

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  String? title,
  required String content,
  Widget Function()? body,
  bool barrierDismissible = true,
  bool useSafeArea = true,
  TextAlign contentAlign = TextAlign.center,
  required List<CustomDialogAction<T>> Function(BuildContext context)
      actionsBuilder,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (context) {
        final actions = actionsBuilder(context);
        return AlertDialog(
          title:
              title != null ? Text(title, textAlign: TextAlign.center) : null,
          content:
              body != null ? body() : Text(content, textAlign: contentAlign),
          actions: actions.map(_buildAction).toList(),
        );
      },
    );
