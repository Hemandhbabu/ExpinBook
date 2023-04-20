import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/expin_list_view.dart';
import '../utils/show_action_utils.dart';
import 'search_transactions_provider.dart';

class SearchTransactionPage extends StatelessWidget {
  static const route = 'search-page';
  const SearchTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: SearchTransactionsProvider.elevatedProvider,
        titleWidget: Consumer(
          builder: (context, ref, child) => CustomTextField(
            fillColor: Colors.transparent,
            hintText: 'Search amount, category, etc.,',
            provider: SearchTransactionsProvider.queryProvider,
            autoFocus: true,
          ),
        ),
        actions: [
          Consumer(
              builder: (context, ref, child) => IconButton(
                    tooltip: 'Filter',
                    onPressed: () => showCustomAction(
                      context,
                      TileActionData(
                        selectedAction:
                            ref.read(SearchTransactionsProvider.filterProvider),
                        actions: SearchFilter.values
                            .map(
                              (e) => TileAction(
                                text: e.name,
                                value: e,
                              ),
                            )
                            .toList(),
                        valueChanged: (value) => ref
                            .read(SearchTransactionsProvider
                                .filterProvider.notifier)
                            .update((state) => value),
                      ),
                    ),
                    icon: const Icon(Icons.filter_alt_rounded),
                  )),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: SearchTransactionsProvider.elevatedProvider,
        child: ExpinListView(
          provider: SearchTransactionsProvider.searchTransactionsProvider,
        ),
      ),
    );
  }
}
