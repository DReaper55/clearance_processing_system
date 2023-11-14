import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentManagement extends HookConsumerWidget {
  const StudentManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('StudentManagement'),
      ),
    );
  }
}