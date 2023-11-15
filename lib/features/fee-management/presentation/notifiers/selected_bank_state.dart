import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enitites/paystack_bank.dart';

final isLoadingAccNumState = StateProvider<bool>((ref) => true);
final isLoadingBankNameState = StateProvider<bool>((ref) => true);
final isLoadingAccNameState = StateProvider<bool>((ref) => true);

final accountNumberCtrlState = StateProvider<TextEditingController>((ref) => TextEditingController());
final accountNameCtrlState = StateProvider<TextEditingController>((ref) => TextEditingController());
final bankNameCtrlState = StateProvider<TextEditingController>((ref) => TextEditingController());

// check if the user has clicked button to save bank account details
final isSavingDataState = StateProvider<bool>((ref) => false);

// check if the value in accountNumberCtrl has changed
final isChangedAccNumState = StateProvider<bool>((ref) => false);

final selectedBankState = StateProvider<PayStackBankEntity>((ref) => const PayStackBankEntity());