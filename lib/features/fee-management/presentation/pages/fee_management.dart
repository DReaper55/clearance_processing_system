import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeeManagement extends HookConsumerWidget {
  const FeeManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
        child: Text('FeeManagement'),
    ));
  }
}