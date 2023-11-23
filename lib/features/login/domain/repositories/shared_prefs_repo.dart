import 'package:dartz/dartz.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

abstract class SharedPrefsRepo {
  Future<Either<TaskFailure, bool>> saveString(String key, String value);
  Future<Either<TaskFailure, bool>> saveBool(String key, bool value);
  Future<Either<TaskFailure, bool>> saveInt(String key, int value);
  Future<Either<TaskFailure, String>> getString(String key);
  Future<Either<TaskFailure, bool>> getBool(String key);
  Future<Either<TaskFailure, int>> getInt(String key);
  Future<Either<TaskFailure, bool>> clear();
}