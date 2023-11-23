import 'package:clearance_processing_system/core/services/navigation_services.dart';
import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utils/routes.dart';
import '../features/login/presentation/notifiers/login_notifier.dart';
import '../features/login/presentation/notifiers/user_notifier.dart';

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
        trailing: TextButton(onPressed: (){
          FirebaseAuth.instance.signOut();

          ref.read(navigationService).navigateOffAllNamed(Routes.login, (p0) => false);
        }, child: const Text('Logout'),),
        onDestinationSelected: (index){
          currentIndex.state = index;

          if(onTap == null) return;
          onTap!();
        },
        selectedIndex: currentIndex.state,
      destinations: _getDestinations(ref),
    );
  }

  List<NavigationRailDestination> _getDestinations(WidgetRef ref) {
    final isStudent = ref.read(userIsStudentStateNotifier);

    if(isStudent){
      return const [
        NavigationRailDestination(icon: Icon(Icons.home_outlined, color: Colors.grey,), label: Text('Home'), selectedIcon: Icon(Icons.home, color: UCPSColors.primary,)),
        NavigationRailDestination(icon: Icon(Icons.people_alt_outlined, color: Colors.grey,), label: Text('My profile'), selectedIcon: Icon(Icons.people_alt, color: UCPSColors.primary)),
        NavigationRailDestination(icon: Icon(Icons.book_outlined, color: Colors.grey,), label: Text('Clearance'), selectedIcon: Icon(Icons.book, color: UCPSColors.primary)),
        NavigationRailDestination(icon: Icon(Icons.attach_money, color: Colors.grey,), label: Text('Wallet'), selectedIcon: Icon(Icons.attach_money_sharp, color: UCPSColors.primary)),
      ];
    }

    return const [
      NavigationRailDestination(icon: Icon(Icons.home_outlined, color: Colors.grey,), label: Text('Home'), selectedIcon: Icon(Icons.home, color: UCPSColors.primary,)),
      NavigationRailDestination(icon: Icon(Icons.people_alt_outlined, color: Colors.grey,), label: Text('User Management'), selectedIcon: Icon(Icons.people_alt, color: UCPSColors.primary)),
      NavigationRailDestination(icon: Icon(Icons.book_outlined, color: Colors.grey,), label: Text('Student Management'), selectedIcon: Icon(Icons.book, color: UCPSColors.primary)),
      NavigationRailDestination(icon: Icon(Icons.attach_money, color: Colors.grey,), label: Text('Fee Management'), selectedIcon: Icon(Icons.attach_money_sharp, color: UCPSColors.primary)),
    ];
  }
}