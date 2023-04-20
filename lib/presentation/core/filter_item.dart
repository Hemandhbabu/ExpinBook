import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool dense;
  final bool showDropdown;
  final bool selected;
  final EdgeInsets? margin;
  final Color? selectedColor;
  const FilterItem({
    super.key,
    required this.text,
    required this.onTap,
    this.dense = false,
    this.showDropdown = true,
    this.selected = false,
    this.margin,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected ? selectedColor ?? theme.colorScheme.primary : null;
    final style = TextStyle(
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      color: color,
    );
    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: dense ? 8 : 12,
            vertical: dense ? 6 : 9,
          ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.fromBorderSide(
          BorderSide(
            color: color ?? theme.dividerColor,
          ),
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: dense ? 4 : 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    text,
                    key: ValueKey(text),
                    style: style,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (showDropdown)
                Icon(Icons.arrow_drop_down_rounded, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
