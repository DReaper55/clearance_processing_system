import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/general_widgets/bottom_navigation.dart';

import '../../../../core/services/new_navigation_services.dart';


final List<String> pageKeys = [ Routes.dashboard, Routes.userManagement, Routes.studentManagement, Routes.feeManagement ];

class SideNavPages extends HookConsumerWidget {
  const SideNavPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPage = ref.watch(currentPageProvider.state).state;
    final selectedIndexState = ref.watch(selectedIndexProvider.state);
    final navigatorKeys = ref.watch(navigatorKeysProvider);

    void selectTab(String tabItem, int index) {
      if (tabItem == currentPage) {
        navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);

        ref.read(newNavigationService).navigateToNamed(tabItem);

      } else {
        ref.read(currentPageProvider.state).state = tabItem;
        ref.read(selectedIndexProvider.state).state = index;

        ref.read(newNavigationService).navigateToNamed(tabItem);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != Routes.homepage) {
            selectTab(Routes.homepage, 0);
            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Row(
          children: [
            NavigationRailWidget(
              currentIndex: selectedIndexState,
              onTap: () {
                int index = selectedIndexState.state;

                selectTab(pageKeys[index], index);
              },
            ),
            CustomVerticalDivider(height: Helpers.height(context),),

            Expanded(
              child: Stack(
                children: <Widget>[
                  _buildOffstageNavigator(ref, Routes.homepage, currentPage),
                  _buildOffstageNavigator(ref, Routes.userManagement, currentPage),
                  _buildOffstageNavigator(ref, Routes.studentManagement, currentPage),
                  _buildOffstageNavigator(ref, Routes.feeManagement, currentPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(WidgetRef ref, String pageKey, String currentPage) {
    return Offstage(
      offstage: currentPage != pageKey,
      child: Navigator(
        key: ref.read(navigatorKeysProvider)[pageKey],
        initialRoute: Routes.homepage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
