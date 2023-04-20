import 'package:flutter/material.dart';

import '../../core_package/core_widget.dart';

class DescriptionInfo extends StatelessWidget {
  final String? description;
  const DescriptionInfo({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    if ((description ?? '').isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AddEditInfoCard(
        title: 'Description',
        child: CustomTile(
          leadingIcon: Icons.notes_rounded,
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: Colors.transparent,
          margin: EdgeInsets.zero,
          title: description,
          titleSize: 20,
        ),
      ),
    );
  }
}
