import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utils/icons.dart';

class NavigationRailWidget extends HookConsumerWidget {
  final StateController<int> currentIndex;
  final Function()? onTap;

  const NavigationRailWidget({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExtended = useState(false);

    return NavigationRail(
      backgroundColor: Colors.grey.shade50,
      extended: isExtended.value,
      elevation: null,
        leading: IconButton(
          icon: (){
            if(isExtended.value){
              return const Icon(Icons.close);
            }

            return const Icon(Icons.menu);
          }(),
          onPressed: () => isExtended.value = !isExtended.value,
        ),
        trailing: TextButton(onPressed: (){}, child: const Text('Logout'),),
        onDestinationSelected: (index){
          currentIndex.state = index;

          if(onTap == null) return;
          onTap!();
        },
        selectedIndex: currentIndex.state,
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home_outlined, color: Colors.grey,), label: Text('Home'), selectedIcon: Icon(Icons.home, color: UCPSColors.primary,)),
        NavigationRailDestination(icon: Icon(Icons.people_alt_outlined, color: Colors.grey,), label: Text('User Management'), selectedIcon: Icon(Icons.people_alt, color: UCPSColors.primary)),
        NavigationRailDestination(icon: Icon(Icons.book_outlined, color: Colors.grey,), label: Text('Student Management'), selectedIcon: Icon(Icons.book, color: UCPSColors.primary)),
        NavigationRailDestination(icon: Icon(Icons.attach_money, color: Colors.grey,), label: Text('Fee Management'), selectedIcon: Icon(Icons.attach_money_sharp, color: UCPSColors.primary)),
      ],
    );

    /*return BottomNavigationBar(
        currentIndex: currentIndex.state,
        backgroundColor: Colors.white,
        elevation: 0.0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          currentIndex.state = index;

          if(onTap == null) return;
          onTap!();
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: GradientWidget(child: SvgPicture.asset(AppIcons.homeFilled, )),
              icon: SvgPicture.asset(AppIcons.home)),

          BottomNavigationBarItem(
            label: 'Categories',
            activeIcon: GradientWidget(child: SvgPicture.asset(AppIcons.categoriesFilled)),
              icon: SvgPicture.asset(AppIcons.categories)),

          BottomNavigationBarItem(
            label: 'Orders',
            activeIcon: GradientWidget(child: SvgPicture.asset(AppIcons.orders)),
              icon: SvgPicture.asset(AppIcons.orders)),

          BottomNavigationBarItem(
            label: 'More',
            activeIcon: GradientWidget(child: SvgPicture.asset(AppIcons.moreFilled)),
              icon: SvgPicture.asset(AppIcons.more)),

        ]);*/
  }
}