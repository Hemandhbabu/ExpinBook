import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CenterText(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style ?? Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
