import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final String? tooltip;
  final Color? color;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    const shape = StadiumBorder();
    final child = Material(
      shape: shape,
      type: MaterialType.card,
      color: color,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ),
    );
    return tooltip == null ? child : Tooltip(message: tooltip, child: child);
  }
}
