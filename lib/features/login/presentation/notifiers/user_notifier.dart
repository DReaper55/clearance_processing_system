import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const isStudentKey = 'isStudent';

final userIsStudentStateNotifier = StateNotifierProvider<UserIsStudentNotifier, bool>((ref) {
  return UserIsStudentNotifier(ref.read, ref.watch);
});

class UserIsStudentNotifier extends StateNotifier<bool> {
  final Reader read;
  final Function(AlwaysAliveProviderListenable) watch;

  UserIsStudentNotifier(this.read, this.watch) : super(false) {
    _loadIsStudent();
  }

  Future<void> _loadIsStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final isStudent = prefs.getBool(isStudentKey) ?? false;
    state = isStudent;
  }

  Future<void> setIsStudent(bool value) async {
    // Set the userIsStudent value in shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isStudentKey, value);

    // Update the state
    state = value;
  }
}
