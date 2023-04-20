import '../core_package/core_widget.dart';
import '../../utils/base_extensions.dart';

import 'package:flutter/material.dart';

Future<void> showCustomAction<T>(
    BuildContext context, TileActionData<T> actionData,
    {Widget? tile}) {
  const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  );
  final length = actionData.actions.length;
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints.loose(Size(size.width, size.height * 0.75)),
    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    builder: (context) => ClipRRect(
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (tile != null) IgnorePointer(child: tile),
              if (tile != null) const Divider(),
              Wrap(
                children: List.generate(
                  length,
                  (index) {
                    final action = actionData.actions[index];
                    final selected = actionData.selectedAction == action.value;
                    return ActionTile<T>(
                      selected: selected,
                      foldable: actionData.foldable && length > 6,
                      action: action,
                      callback: (T val) {
                        Navigator.of(context).pop();
                        if (!selected || action.selectedTappable) {
                          actionData.valueChanged(val);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ActionTile<T> extends StatelessWidget {
  final bool selected;
  final TileAction<T> action;
  final ValueChanged<T> callback;
  final bool foldable;

  const ActionTile({
    Key? key,
    required this.action,
    required this.callback,
    this.selected = false,
    required this.foldable,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = foldable ? MediaQuery.of(context).size.width / 2 : null;
    final hasColor = action.iconColor?.let(
          (value) => value.value != Colors.transparent.value,
        ) ??
        false;
    return SizedBox(
      width: width,
      child: CustomTile(
        padding: EdgeInsets.symmetric(vertical: hasColor ? 3 : 0),
        onTap: () => callback(action.value),
        leadingColor: action.iconColor,
        leadingIcon: action.icon,
        leadingSymbol: action.symbol,
        titleColor: action.tileColor,
        title: action.text,
        color: selected
            ? (action.tileColor ?? Theme.of(context).colorScheme.primary)
                .withOpacity(0.15)
            : Colors.transparent,
      ),
    );
  }
}

class TileActionData<T> {
  final T? selectedAction;

  final bool foldable;
  final List<TileAction<T>> actions;
  final ValueChanged<T> valueChanged;

  TileActionData({
    this.selectedAction,
    this.foldable = false,
    required this.actions,
    required this.valueChanged,
  });
}

class TileAction<T> {
  final IconData? icon;
  final String text;
  final String? symbol;
  final Color? iconColor;
  final Color? tileColor;
  final T value;
  final bool selectedTappable;

  const TileAction({
    this.icon,
    required this.text,
    this.symbol,
    required this.value,
    this.tileColor,
    this.iconColor,
    this.selectedTappable = false,
  });
}
