import 'package:flutter/material.dart';

import '../constants/app_dimens.dart';
import 'app_bottom_nav.dart';
import 'app_drawer.dart';
import 'app_header.dart';

export 'app_header.dart' show AppHeader, HeaderLeading;

/// The standard screen shell: header + body + optional bottom navigation and
/// navigation drawer. Every main screen is wrapped in this so the header,
/// drawer and tab bar stay pixel-identical across the app.
class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.headerLeading = HeaderLeading.menu,
    this.showBottomNav = true,
    this.bottomNavIndex,
  });

  final Widget body;
  final HeaderLeading headerLeading;

  /// Bottom navigation visibility. When visible, [bottomNavIndex] highlights
  /// the active tab — `null` means no tab is highlighted (map screens).
  final bool showBottomNav;
  final int? bottomNavIndex;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppHeader(
        leading: widget.headerLeading,
        onMenu: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Column(
        children: [
          Expanded(child: widget.body),
          if (widget.showBottomNav)
            AppBottomNav(currentIndex: widget.bottomNavIndex),
        ],
      ),
    );
  }
}

/// Standard horizontal padding for screen content.
const EdgeInsets kScreenPadding = EdgeInsets.all(AppDimens.screenPadding);
