import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/routes.dart';

final currentPageProvider = StateProvider<String>((ref) => Routes.homepage);
final selectedIndexProvider = StateProvider<int>((ref) => 0);

final navigatorKeysProvider = Provider<Map<String, GlobalKey<NavigatorState>>>((ref) {
  return {
    Routes.homepage: GlobalKey<NavigatorState>(),
    // Routes.category: GlobalKey<NavigatorState>(),
    // Routes.orders: GlobalKey<NavigatorState>(),
    // Routes.more: GlobalKey<NavigatorState>(),
  };
});

class NavigationService {
  final Ref ref;

  NavigationService(this.ref);

  Future<T?>? navigateTo<T extends Object?>(Route<T> route) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.push(route);
  }

  Future<T?>? navigateToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?>? navigateOff<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.pushReplacement(
      newRoute,
      result: result,
    );
  }

  Future<T?>? navigateOffNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?>? navigateOffAll<T extends Object?>(
    Route<T> newRoute,
    bool Function(Route<dynamic>) predicate,
  ) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.pushAndRemoveUntil(
      newRoute,
      predicate,
    );
  }

  Future<T?>? navigateOffAllNamed<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    final currentPage = getCurrentPageKey();

    return currentPage?.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void navigateBack<T extends Object?>([T? result]) {
    final currentPage = getCurrentPageKey();

    currentPage?.currentState?.pop(result);
  }

  GlobalKey<NavigatorState>? getCurrentPageKey() {
    final navigate = ref.read(navigatorKeysProvider);
    final currentPage = ref.read(currentPageProvider.state).state;

    return navigate[currentPage];
  }
}

final newNavigationService = Provider((ref) => NavigationService(ref));
