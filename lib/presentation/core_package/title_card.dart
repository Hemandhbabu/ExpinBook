import 'package:flutter/material.dart';

import 'constants.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  const TitleCard({
    super.key,
    required this.title,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: trailing != null ? null : onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: trailing == null
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 16)
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              if (onTap != null && trailing == null)
                const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              if (onTap == null && trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
