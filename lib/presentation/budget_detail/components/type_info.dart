import 'package:flutter/material.dart';

import '../../core_package/core_widget.dart';

class TypeInfo extends StatelessWidget {
  final bool isTotal;
  final bool isSingleCategory;
  const TypeInfo({
    super.key,
    required this.isTotal,
    required this.isSingleCategory,
  });

  @override
  Widget build(BuildContext context) {
    return AddEditInfoCard(
      title: 'Budget type',
      child: CustomTile(
        leadingIcon: Icons.extension_rounded,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        title: isTotal ? 'Total' : 'Categor${isSingleCategory ? 'y' : 'ies'}',
        titleSize: 20,
      ),
    );
  }
}
