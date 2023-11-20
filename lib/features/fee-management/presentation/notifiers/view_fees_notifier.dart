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
  
  void getFees() async {
    final feeRes = await ref.read(feeRepositoryProvider).getFees();

    fees.value = feeRes.map((e) => FeeEntity.fromMap(e)).toList();

    notifyListeners();
  }
}