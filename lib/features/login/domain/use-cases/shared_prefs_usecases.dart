import 'package:clearance_processing_system/features/register/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

import '../repositories/shared_prefs_repo.dart';

class SaveStringToPref implements UseCase<bool, SharedPrefsParams> {
  final SharedPrefsRepo repository;

  SaveStringToPref({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(SharedPrefsParams params) async {
    return await repository.saveString(params.key!, params.stringValue!);
  }
}

class SaveBoolToPref implements UseCase<bool, SharedPrefsParams> {
  final SharedPrefsRepo repository;

  SaveBoolToPref({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(SharedPrefsParams params) async {
    return await repository.saveBool(params.key!, params.boolValue!);
  }
}

class SaveIntToPref implements UseCase<bool, SharedPrefsParams> {
  final SharedPrefsRepo repository;

  SaveIntToPref({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(SharedPrefsParams params) async {
    return await repository.saveInt(params.key!, params.intValue!);
  }
}

class GetIntFromPref implements UseCase<int, String> {
  final SharedPrefsRepo repository;

  GetIntFromPref({required this.repository});

  @override
  Future<Either<TaskFailure, int>> call(String key) async {
    return await repository.getInt(key);
  }
}

class GetStringFromPref implements UseCase<String, String> {
  final SharedPrefsRepo repository;

  GetStringFromPref({required this.repository});

  @override
  Future<Either<TaskFailure, String>> call(String key) async {
    return await repository.getString(key);
  }
}

class GetBoolFromPref implements UseCase<bool, String> {
  final SharedPrefsRepo repository;

  GetBoolFromPref({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(String key) async {
    return await repository.getBool(key);
  }
}

class ClearPrefs implements UseCase<bool, NoParams> {
  final SharedPrefsRepo repository;

  ClearPrefs({required this.repository});

  @override
  Future<Either<TaskFailure, bool>> call(NoParams params) async {
    return await repository.clear();
  }
}

class SharedPrefsParams extends Equatable {
  final String? key;
  final String? stringValue;
  final bool? boolValue;
  final int? intValue;

  const SharedPrefsParams({this.stringValue, this.boolValue, this.intValue, this.key});

  @override
  List<Object?> get props => [stringValue, intValue, boolValue, key];

}
