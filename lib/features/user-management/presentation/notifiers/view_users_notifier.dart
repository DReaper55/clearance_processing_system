import 'package:clearance_processing_system/features/register/domain/entities/user.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/admin_data_provider.dart';

final viewUsersNotifierProvider =
    ChangeNotifierProvider((ref) => ViewUsersNotifier(ref));

class ViewUsersNotifier extends ChangeNotifier {
  final Ref ref;
  
  final users = ValueNotifier<List<UserEntity>>([]);
  
  ViewUsersNotifier(this.ref);
  
  void getUsers() async {
    final userRes = ref.read(getUsersUseCaseProvider).when(
        data: (value){
          return value;
        },
        error: (err, __){
          return null;
        },
        loading: (){
          print('Senddd 1');
        },
    );

    if(userRes == null) return;

    users.value = userRes.map((e) => UserEntity.fromMap(e)).toList();

    notifyListeners();
  }
}