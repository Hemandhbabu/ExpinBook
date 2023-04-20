import 'package:flutter/material.dart';

class SnackBarData {
  final String message;
  final String actionLabel;
  final VoidCallback? action;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final SnackBarBehavior? behavior;
  final Duration duration;

  const SnackBarData({
    required this.message,
    this.actionLabel = 'Undo',
    this.action,
    this.margin,
    this.padding,
    this.behavior,
    this.duration = const Duration(seconds: 3),
  });
}
