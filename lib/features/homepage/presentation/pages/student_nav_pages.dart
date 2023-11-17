import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:clearance_processing_system/core/utils/routes.dart';
import 'package:clearance_processing_system/general_widgets/side_navigation.dart';

import '../../../../core/services/student_navigation_services.dart';


final List<String> pageKeys = [ Routes.dashboard, Routes.myProfile, Routes.clearance, Routes.wallet ];

class StudentNavPages extends HookConsumerWidget {
  const StudentNavPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPage = ref.watch(currentPageProvider.state).state;
    final selectedIndexState = ref.watch(selectedIndexProvider.state);
    final navigatorKeys = ref.watch(navigatorKeysProvider);

    void selectTab(String tabItem, int index) {
      if (tabItem == currentPage) {
        navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);

        ref.read(studentNavigationService).navigateToNamed(tabItem);

      } else {
        ref.read(currentPageProvider.state).state = tabItem;
        ref.read(selectedIndexProvider.state).state = index;

        ref.read(studentNavigationService).navigateToNamed(tabItem);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != Routes.dashboard) {
            selectTab(Routes.dashboard, 0);
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
                  _buildOffstageNavigator(ref, Routes.dashboard, currentPage),
                  _buildOffstageNavigator(ref, Routes.myProfile, currentPage),
                  _buildOffstageNavigator(ref, Routes.clearance, currentPage),
                  _buildOffstageNavigator(ref, Routes.wallet, currentPage),
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
        initialRoute: Routes.dashboard,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
