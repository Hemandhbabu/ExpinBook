import '../../core_package/core_widget.dart';

import '../../../domain/models/category.dart';
import 'package:flutter/material.dart';

class ManagePinnedCategoryTile extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;
  const ManagePinnedCategoryTile({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      leadingIcon: category.icon,
      leadingSymbol: category.symbol,
      leadingColor: category.color,
      title: category.name,
      trailing: isSelected ? const Icon(Icons.done_rounded) : null,
      onTap: onTap,
    );
  }
}
