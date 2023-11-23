import 'package:clearance_processing_system/features/login/domain/repositories/shared_prefs_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/generic-datasources/shared_prefs_datasource.dart';
import '../../data/repositories/shared_prefs_repo_impl.dart';
import '../../domain/use-cases/shared_prefs_usecases.dart';

final sharedPrefsRepoProvider = FutureProvider<SharedPrefsRepo>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return SharedPrefsRepoImpl(SharedPrefsDataSourceImpl(sharedPreference: sharedPreferences));
});

final saveStringToSharedPrefsUseCase = FutureProvider.autoDispose<SaveStringToPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return SaveStringToPref(repository: repository);
});

final saveIntToSharedPrefsUseCase = FutureProvider.autoDispose<SaveIntToPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return SaveIntToPref(repository: repository);
});

final saveBoolToSharedPrefsUseCase = FutureProvider.autoDispose<SaveBoolToPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return SaveBoolToPref(repository: repository);
});

final getStringFromSharedPrefsUseCase = FutureProvider<GetStringFromPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return GetStringFromPref(repository: repository);
});

final getBoolFromSharedPrefsUseCase = FutureProvider<GetBoolFromPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return GetBoolFromPref(repository: repository);
});

final getIntFromSharedPrefsUseCase = FutureProvider<GetIntFromPref>((ref) async {
  final repository = await ref.watch(sharedPrefsRepoProvider.future);
  return GetIntFromPref(repository: repository);
});

final clearSharedPrefsUseCase = FutureProvider.autoDispose<ClearPrefs>((ref) async {
  final repository = await ref.read(sharedPrefsRepoProvider.future);
  return ClearPrefs(repository: repository);
});
