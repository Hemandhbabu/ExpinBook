import '../core_package/core_widget.dart';

import 'package:flutter/material.dart';

class ShortcutCard extends StatelessWidget {
  final List<ShortcutData> data;

  const ShortcutCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleCard(title: 'See also'),
        ...data.map(
          (e) => Row(
            children: [
              Expanded(
                child: _ShortcutItem(
                  shortcut: e.left,
                  margin: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                ),
              ),
              Expanded(
                child: _ShortcutItem(
                  shortcut: e.right,
                  margin: const EdgeInsets.fromLTRB(5, 5, 10, 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const _borderRadius = BorderRadius.all(Radius.circular(15));

class ShortcutData {
  final ShortcutGridData left;
  final ShortcutGridData right;

  const ShortcutData({required this.left, required this.right});
}

class ShortcutGridData {
  final String firstName;
  final String lastName;
  final String message;
  final String destination;
  final dynamic argument;
  final Color? color;

  const ShortcutGridData({
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.destination,
    this.color,
    this.argument,
  });
}

class _ShortcutItem extends StatelessWidget {
  final EdgeInsets margin;
  final ShortcutGridData shortcut;
  const _ShortcutItem({
    Key? key,
    required this.shortcut,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      margin: margin,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          shortcut.destination,
        ),
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            shortcut.firstName,
                            style: TextStyle(
                              fontSize: 20,
                              color: shortcut.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11,
                          color: shortcut.color,
                        ),
                      ],
                    ),
                    Text(
                      shortcut.lastName,
                      style: TextStyle(
                        fontSize: 20,
                        color: shortcut.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      shortcut.message,
                      maxLines: 2,
                      style: TextStyle(color: shortcut.color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
