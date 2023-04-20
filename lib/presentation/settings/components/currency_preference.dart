import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../../utils/base_extensions.dart';
import '../../../utils/theme.dart';

class CurrencyPreference extends ConsumerWidget {
  const CurrencyPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      title: 'Currency',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Text(
        ref.watch(currencyPreferencesProvider),
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      onTap: () => showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        builder: (context) => const CurrencyDialog(),
      ).then(
        (value) => value?.let(
          (value) =>
              ref.read(currencyPreferencesProvider.notifier).setString(value),
        ),
      ),
    );
  }
}

class CurrencyDialog extends ConsumerStatefulWidget {
  const CurrencyDialog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyDialogState createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends ConsumerState<CurrencyDialog> {
  late String value;
  late TextEditingController controller;
  @override
  void initState() {
    value = ref.read(currencyPreferencesProvider);
    controller =
        TextEditingController(text: currencies.contains(value) ? '' : value);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currencies.contains(value)) controller.clear();
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom;
    final height = mediaQuery.size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Select currency',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: height * 0.075),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 24),
              child: Center(
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  selectedBorderColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  isSelected: currencies.map((e) => e == value).toList(),
                  onPressed: (i) => setState(() => value = currencies[i]),
                  children: currencies
                      .map((e) => Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                maxLength: 3,
                controller: controller,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration:
                    const InputDecoration(labelText: 'Custom currency instead'),
                textCapitalization: TextCapitalization.characters,
                onChanged: (val) => setState(() => value = val.isEmpty
                    ? !currencies
                            .contains(ref.read(currencyPreferencesProvider))
                        ? currencies[0]
                        : ref.read(currencyPreferencesProvider)
                    : val),
              ),
            ),
            SizedBox(height: height * 0.075),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, value),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: shape,
              ),
              child: const Text('Save currency'),
            ),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}
