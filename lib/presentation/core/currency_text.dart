import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/preferences_provider.dart';

final currencyFormat = Provider.autoDispose.family(
  (ref, double amount) =>
      CurrencyText.format(ref.watch(currencyPreferencesProvider))
          .format(amount),
);

class CurrencyText extends ConsumerWidget {
  final double value;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String prefix;
  const CurrencyText(
    this.value, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.prefix = '',
  }) : super(key: key);

  static NumberFormat format(String s) => NumberFormat.simpleCurrency(name: s);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyPreferencesProvider);
    return Text(
      prefix + format(currency).format(value),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
