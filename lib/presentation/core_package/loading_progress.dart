import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      type: MaterialType.transparency,
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
