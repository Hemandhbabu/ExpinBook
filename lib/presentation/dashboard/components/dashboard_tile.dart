import 'package:flutter/material.dart';

const _borderRadius = BorderRadius.all(Radius.circular(15));

class DashboardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? small;
  final String routeName;
  final EdgeInsets margin;
  const DashboardTile({
    super.key,
    required this.icon,
    this.small,
    required this.title,
    required this.routeName,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
      margin: margin,
      child: InkWell(
        onTap: () => Navigator.popAndPushNamed(
          context,
          routeName,
        ),
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8),
                  Align(alignment: Alignment.centerLeft, child: Icon(icon)),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, right: 2.0),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (small != null)
                Text(
                  small!,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              FittedBox(
                child: Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
