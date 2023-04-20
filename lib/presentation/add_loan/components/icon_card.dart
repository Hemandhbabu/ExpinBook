import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/base_extensions.dart';
import '../../../utils/category_data.dart';
import '../../../utils/theme.dart';
import '../../../utils/type_def_utils.dart';
import '../../utils/show_action_utils.dart';
import '../add_loan_provider.dart';

class IconCard extends ConsumerWidget {
  const IconCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = ref.watch(AddLoanProvider.iconProvider);
    final symbol = ref.watch(AddLoanProvider.symbolProvider);
    return AddEditInfoCard(
      title: 'Symbol',
      alignment: CrossAxisAlignment.center,
      onTap: () => showOptions(context, ref.read),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          key: ValueKey(icon ?? symbol),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Center(
            child: SizedBox.square(
              dimension: 64,
              child: FittedBox(
                child: icon != null
                    ? Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(icon),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          symbol!,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showOptions(BuildContext context, Reader read) => showCustomAction(
      context,
      TileActionData(
        actions: const [
          TileAction(text: 'Select icon', value: 0),
          TileAction(text: 'Set symbol', value: 1),
        ],
        valueChanged: (value) {
          if (value == 0) {
            showIconPicker(context, read(AddLoanProvider.iconProvider)).then(
              (value) => value?.let(
                (value) {
                  read(AddLoanProvider.iconProvider.notifier)
                      .update((state) => value);
                  read(AddLoanProvider.symbolProvider.notifier)
                      .update((state) => null);
                },
              ),
            );
          } else if (value == 1) {
            showSymbolGetter(context, read(AddLoanProvider.symbolProvider))
                .then(
              (value) => value?.let(
                (value) {
                  read(AddLoanProvider.iconProvider.notifier)
                      .update((state) => null);
                  read(AddLoanProvider.symbolProvider.notifier)
                      .update((state) => value);
                },
              ),
            );
          }
        },
      ),
    );

Future<IconData?> showIconPicker(BuildContext context, IconData? icon) =>
    showDialog<IconData>(
      context: context,
      builder: (context) => _IconPicker(icon),
    );

final _elevatedProvider = StateProvider.autoDispose((ref) => false);

class _IconPicker extends StatelessWidget {
  final IconData? iconData;
  const _IconPicker(this.iconData);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;
    final selectedColor = theme.colorScheme.primary;
    return Scaffold(
      appBar: CustomAppBar.elevated(
        leading: const CustomCloseButton(),
        provider: _elevatedProvider,
        title: 'Select icon',
      ),
      body: ScrollNotificationWrapper(
        provider: _elevatedProvider,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 12),
          itemCount: categoryWiseIcons.length,
          itemBuilder: (context, index) {
            final item = categoryWiseIcons[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                TitleCard(title: item.name),
                GridView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  itemCount: item.icons.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 64,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final icon = item.icons[index];
                    final selected = iconData == icon;
                    final splash = (selected ? selectedColor : iconColor)
                        ?.withOpacity(0.2);
                    return Center(
                      child: InkWell(
                        highlightColor: splash,
                        splashColor: splash,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        onTap: () => Navigator.pop(context, icon),
                        child: SizedBox(
                          height: 64,
                          width: 64,
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            color: selected
                                ? selectedColor.withOpacity(0.1)
                                : iconColor?.withOpacity(0.05),
                            child: Icon(
                              icon,
                              color: selected ? selectedColor : iconColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final _symbolProvider = StateProvider.autoDispose((ref) => '');

Future<String?> showSymbolGetter(BuildContext context, String? initialSymbol) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProviderScope(
        overrides: [
          if (initialSymbol?.isNotEmpty == true)
            _symbolProvider.overrideWith((ref) => initialSymbol!),
        ],
        child: const _SymbolGetter(),
      ),
    );

class _SymbolGetter extends ConsumerWidget {
  const _SymbolGetter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom;
    final height = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Enter symbol',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.1),
          CustomTextField(
            autoFocus: true,
            provider: _symbolProvider,
            textAlign: TextAlign.center,
            fillColor: Colors.transparent,
            hintText: 'Symbol',
            maxLength: 3,
            capitalization: TextCapitalization.characters,
            contentPadding: const EdgeInsets.all(24),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            labelStyle: const TextStyle(fontSize: 32),
          ),
          SizedBox(height: height * 0.1),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              context,
              ref.read(_symbolProvider),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Set symbol'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
