import 'dart:math';

import '../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'center_text.dart';
import 'custom_tile.dart';
import 'shimmer.dart';

class CustomListView<T> extends StatelessWidget {
  final String emptyText;
  final Widget? forcedChild;
  final Widget Function(BuildContext context)? emptyWidgetBuilder;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  final Widget Function(BuildContext context, List<T> items)? firstChildBuilder;
  final Widget? firstChild;
  final Widget? lastChild;
  final bool hasFab;
  final bool animateListChanges;
  const CustomListView({
    super.key,
    required this.items,
    required this.emptyText,
    required this.builder,
    this.firstChild,
    this.firstChildBuilder,
    this.lastChild,
    this.hasFab = false,
    this.animateListChanges = false,
    this.emptyWidgetBuilder,
  }) : forcedChild = null;

  CustomListView.async({
    super.key,
    required AsyncValue<List<T>> asyncValue,
    required this.emptyText,
    required this.builder,
    this.firstChild,
    this.firstChildBuilder,
    this.lastChild,
    this.hasFab = false,
    this.animateListChanges = false,
    this.emptyWidgetBuilder,
  })  : items = asyncValue.maybeWhen(orElse: () => [], data: (data) => data),
        forcedChild = asyncValue.when(
          data: (data) => null,
          error: (error, stackTrace) {
            debugPrint(error.toString());
            return CenterText('$error', key: ValueKey(error));
          },
          loading: () => const LoadingList(),
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: () {
        final forcedChild = this.forcedChild;
        if (forcedChild != null) return forcedChild;

        if (items.isEmpty) {
          if (emptyWidgetBuilder != null) return emptyWidgetBuilder!(context);
          return CenterText(emptyText, key: ValueKey(emptyText));
        }

        final firstChild =
            firstChildBuilder?.call(context, items) ?? this.firstChild;
        final lastChild = this.lastChild;
        final length = items.length +
            (firstChild == null ? 0 : 1) +
            (lastChild == null ? 0 : 1);
        return ListView.builder(
          key: animateListChanges ? ValueKey(items.toString()) : null,
          itemCount: length,
          padding: EdgeInsets.only(bottom: hasFab ? 80 : 8),
          itemBuilder: (context, index) {
            if (firstChild == null) {
              if (lastChild != null && index == items.length) {
                return lastChild;
              }
              return builder(context, index, items[index]);
            } else {
              if (index == 0) return firstChild;
              if (lastChild != null && index == items.length + 1) {
                return lastChild;
              }
              return builder(context, index, items[index - 1]);
            }
          },
        );
      }(),
    );
  }
}

class LoadingList extends StatelessWidget {
  const LoadingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: IgnorePointer(
        child: Shimmer(
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                    child: ShimmerLoading(
                      isLoading: true,
                      child: LoadingText(length: 0.5),
                    ),
                  ),
                  LoadingTile(useShimmer: false),
                  SizedBox(height: 4),
                  LoadingTile(useShimmer: false),
                ],
              ),
            ),
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}

class LoadingChips extends StatelessWidget {
  const LoadingChips({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: IgnorePointer(
        child: Shimmer(
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  runSpacing: 8,
                  spacing: 12,
                  children: List.generate(
                    20,
                    (index) => ShimmerLoading(
                      isLoading: true,
                      child: LoadingText(
                        length: random
                            .nextDouble()
                            .let((d) => d < 0.15 ? 0.15 : d * 0.85),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
