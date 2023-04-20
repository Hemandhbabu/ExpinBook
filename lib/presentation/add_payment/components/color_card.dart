import '../../core_package/core_widget.dart';

import '../../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/category_data.dart';
import '../add_payment_provider.dart';

class ColorCard extends ConsumerWidget {
  const ColorCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(AddPaymentProvider.colorProvider);
    final editable = ref.watch(AddPaymentProvider.editableProvider);
    return AddEditInfoCard(
      title: 'Color',
      alignment: CrossAxisAlignment.center,
      onTap: editable
          ? () => showColorPicker(
                      context, ref.read(AddPaymentProvider.colorProvider))
                  .then(
                (value) => value?.let(
                  (value) => ref
                      .read(AddPaymentProvider.colorProvider.notifier)
                      .update((state) => value),
                ),
              )
          : null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          key: ValueKey(color),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Align(
            child: Container(
              height: 52,
              width: 52,
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Color?> showColorPicker(BuildContext context, Color color) =>
    showDialog<Color>(
      context: context,
      builder: (context) => _ColorPicker(color),
    );

final _elevatedProvider = StateProvider.autoDispose((ref) => false);

class _ColorPicker extends StatelessWidget {
  final Color color;
  const _ColorPicker(this.color);

  @override
  Widget build(BuildContext context) {
    final selectedColor = color;
    return Scaffold(
      appBar: CustomAppBar.elevated(
        leading: const CustomCloseButton(),
        provider: _elevatedProvider,
        title: 'Select color',
      ),
      body: ScrollNotificationWrapper(
        provider: _elevatedProvider,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: categoryColors.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 56,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final color = categoryColors[index];
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.pop(context, color),
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: color,
                child: selectedColor == color
                    ? Icon(
                        Icons.done_rounded,
                        color: ThemeData.estimateBrightnessForColor(color) ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
