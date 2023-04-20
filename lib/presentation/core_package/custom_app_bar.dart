import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_icon_button.dart';
import 'elevation_builder.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final double? elevation;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final AutoDisposeStateProvider<bool>? _provider;
  final Widget? titleWidget;

  const CustomAppBar({
    Key? key,
    this.title = '',
    this.leading,
    this.elevation,
    this.actions,
    this.bottom,
    this.titleWidget,
  })  : _provider = null,
        super(key: key);

  const CustomAppBar.elevated({
    Key? key,
    this.title = '',
    this.leading,
    this.elevation,
    this.actions,
    this.bottom,
    required AutoDisposeStateProvider<bool> provider,
    this.titleWidget,
  })  : _provider = provider,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final hasDrawer = scaffold?.hasDrawer ?? false;
    final canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    final leading = this.leading ??
        (hasDrawer
            ? IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              )
            : canPop
                ? useCloseButton
                    ? const CustomCloseButton()
                    : const CustomBackButton()
                : null);
    final appBar = AppBar(
      centerTitle: true,
      elevation: elevation,
      automaticallyImplyLeading: false,
      leading: leading,
      title: titleWidget ??
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: FittedBox(child: Text(title, key: ValueKey(title))),
          ),
      actions: actions,
      bottom: bottom,
    );
    if (_provider == null) return appBar;
    return ElevationBuilder(provider: _provider!, child: appBar);
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}

class CustomBackButton extends StatelessWidget {
  final bool withBackground;
  const CustomBackButton({
    Key? key,
    this.withBackground = false,
  }) : super(key: key);

  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return Icons.arrow_back_rounded;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_back_ios_rounded;
    }
  }

  @override
  Widget build(BuildContext context) => withBackground
      ? CustomIconButton(
          icon: Icon(_getIconData(Theme.of(context).platform)),
          onTap: () => Navigator.maybePop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        )
      : IconButton(
          icon: Icon(_getIconData(Theme.of(context).platform)),
          onPressed: () => Navigator.maybePop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        );
}

class CustomCloseButton extends StatelessWidget {
  final bool withBackground;
  const CustomCloseButton({
    Key? key,
    this.withBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return withBackground
        ? CustomIconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onTap: () => Navigator.maybePop(context),
          )
        : IconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onPressed: () => Navigator.maybePop(context),
          );
  }
}
