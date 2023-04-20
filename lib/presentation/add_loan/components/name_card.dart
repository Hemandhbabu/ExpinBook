import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/base_extensions.dart';
import '../../../utils/theme.dart';
import '../add_loan_provider.dart';

class NameCard extends ConsumerWidget {
  const NameCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(AddLoanProvider.nameProvider);
    return AddEditInfoCard(
      title: 'Name',
      onTap: () => showNameGetter(context, name).then(
        (value) => value?.let(
          (value) => ref
              .read(AddLoanProvider.nameProvider.notifier)
              .update((state) => value),
        ),
      ),
      child: CustomTile(
        leadingIcon: Icons.drive_file_rename_outline_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        title: name.isEmpty ? 'Enter name' : name,
        titleSize: name.isEmpty ? 18 : 22,
        titleColor: name.isNotEmpty
            ? null
            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
      ),
    );
  }
}

final _nameProvider = StateProvider.autoDispose((ref) => '');

Future<String?> showNameGetter(BuildContext context, String initialName) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProviderScope(
        overrides: [
          if (initialName.isNotEmpty)
            _nameProvider.overrideWith((ref) => initialName),
        ],
        child: const _NameGetter(),
      ),
    );

class _NameGetter extends ConsumerWidget {
  const _NameGetter();

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
              'Enter name',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.075),
          CustomTextField(
            autoFocus: true,
            provider: _nameProvider,
            textAlign: TextAlign.center,
            fillColor: Colors.transparent,
            hintText: 'Name',
            maxLength: 25,
            capitalization: TextCapitalization.words,
            contentPadding: const EdgeInsets.all(24),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            labelStyle: const TextStyle(fontSize: 32),
          ),
          SizedBox(height: height * 0.075),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              context,
              ref.read(_nameProvider),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Add name'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
