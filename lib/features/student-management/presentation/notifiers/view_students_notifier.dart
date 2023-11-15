import 'package:clearance_processing_system/features/student-management/domain/entities/student.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/student_data_provider.dart';

final viewStudentsNotifierProvider =
    ChangeNotifierProvider((ref) => ViewStudentsNotifier(ref));

class ViewStudentsNotifier extends ChangeNotifier {
  final Ref ref;
  
  final students = ValueNotifier<List<StudentEntity>>([]);
  
  ViewStudentsNotifier(this.ref);
  
  void getStudents() async {
    final studentRes = ref.read(getStudentsUseCaseProvider).when(
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

    if(studentRes == null) return;

    students.value = studentRes.map((e) => StudentEntity.fromMap(e)).toList();

    notifyListeners();
  }
}