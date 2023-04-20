import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/base_extensions.dart';
import '../../../utils/theme.dart';
import '../add_category_provider.dart';

class DescriptionCard extends ConsumerWidget {
  const DescriptionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(AddCategoryProvider.descriptionProvider);
    final editable = ref.watch(AddCategoryProvider.editableProvider);
    if (!editable && description.isEmpty) return const SizedBox.shrink();
    return AddEditInfoCard(
      title: 'Description',
      onTap: editable
          ? () => showDescriptionGetter(context, description).then(
                (value) => value?.let(
                  (value) => ref
                      .read(AddCategoryProvider.descriptionProvider.notifier)
                      .update((state) => value),
                ),
              )
          : null,
      child: CustomTile(
        leadingIcon: Icons.notes_rounded,
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        title: description.isEmpty ? 'Enter description' : description,
        titleSize: 18,
        titleColor: description.isNotEmpty
            ? null
            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
      ),
    );
  }
}

final _descriptionProvider = StateProvider.autoDispose((ref) => '');

Future<String?> showDescriptionGetter(
        BuildContext context, String initialDescription) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProviderScope(
        overrides: [
          if (initialDescription.isNotEmpty)
            _descriptionProvider.overrideWith((ref) => initialDescription),
        ],
        child: const _DescriptionGetter(),
      ),
    );

class _DescriptionGetter extends ConsumerWidget {
  const _DescriptionGetter();

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
              'Enter description',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.075),
          CustomTextField(
            autoFocus: true,
            provider: _descriptionProvider,
            textAlign: TextAlign.center,
            fillColor: Colors.transparent,
            hintText: 'Description',
            maxLines: 4,
            minLines: 1,
            capitalization: TextCapitalization.sentences,
            contentPadding: const EdgeInsets.all(24),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            labelStyle: const TextStyle(fontSize: 24),
          ),
          SizedBox(height: height * 0.075),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              context,
              ref.read(_descriptionProvider),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Add description'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
