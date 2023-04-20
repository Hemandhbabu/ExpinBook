import '../../core_package/core_widget.dart';

import '../../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../../utils/theme.dart';

class UsernamePreference extends ConsumerWidget {
  const UsernamePreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      title: 'Username',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Text(
        ref.watch(usernamePreferencesProvider),
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      onTap: () => showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        builder: (context) => const _UsernameDialog(),
      ).then(
        (value) => value?.let(
          ref.read(usernamePreferencesProvider.notifier).setString,
        ),
      ),
    );
  }
}

class _UsernameDialog extends ConsumerStatefulWidget {
  const _UsernameDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<_UsernameDialog> createState() => _UsernameDialogState();
}

class _UsernameDialogState extends ConsumerState<_UsernameDialog> {
  late String value;

  @override
  void initState() {
    value = ref.read(usernamePreferencesProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              'Enter username',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.1),
          TextFormField(
            initialValue: value,
            textAlign: TextAlign.center,
            autofocus: true,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            decoration: const InputDecoration(
              hintText: 'Enter username',
              fillColor: Colors.transparent,
            ),
            maxLength: 12,
            textCapitalization: TextCapitalization.words,
            onChanged: (val) => value = val,
          ),
          SizedBox(height: height * 0.1),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, value),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Save username'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
