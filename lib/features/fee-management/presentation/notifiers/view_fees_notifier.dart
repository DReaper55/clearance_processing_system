import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enitites/fee_entity.dart';
import '../providers/fee_data_provider.dart';

final viewFeesNotifierProvider =
    ChangeNotifierProvider((ref) => ViewFeesNotifier(ref));

class ViewFeesNotifier extends ChangeNotifier {
  final Ref ref;
  
  final fees = ValueNotifier<List<FeeEntity>>([]);

  ViewFeesNotifier(this.ref);
  
  void getFees() {
    final feeRes = ref.read(getFeesUseCaseProvider).when(
        data: (value){
          return value;
        },
        error: (err, __){
          return null;
        },
        loading: (){
          Future.delayed(const Duration(seconds: 1), getFees);
        },
    );

    if(feeRes == null) return;

    fees.value = feeRes.map((e) => FeeEntity.fromMap(e)).toList();

    notifyListeners();
  }
}