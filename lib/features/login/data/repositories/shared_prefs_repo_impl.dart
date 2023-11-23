import 'package:dartz/dartz.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

import '../../domain/repositories/shared_prefs_repo.dart';
import '../generic-datasources/shared_prefs_datasource.dart';

class SharedPrefsRepoImpl implements SharedPrefsRepo {
  final SharedPrefsDataSource datasource;

  SharedPrefsRepoImpl(this.datasource);

  @override
  Future<Either<TaskFailure, bool>> getBool(String key) async {
    try{
      bool value = await datasource.getBool(key);
      return Right(value);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to get bool value from sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, int>> getInt(String key) async {
    try{
      int value = await datasource.getInt(key);
      return Right(value);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to get int value from sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, String>> getString(String key) async {
    try{
      String value = await datasource.getString(key);
      return Right(value);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to get String value from sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> saveBool(String key, bool value) async {
    try{
      bool done = await datasource.saveBool(key, value);
      return Right(done);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to save bool value to sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> saveInt(String key, int value) async {
    try{
      bool done = await datasource.saveInt(key, value);
      return Right(done);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to save int value to sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> saveString(String key, String value) async {
    try{
      bool done = await datasource.saveString(key, value);
      return Right(done);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to save String value to sharedPrefs'));
    }
  }

  @override
  Future<Either<TaskFailure, bool>> clear() async {
    try{
      bool done = await datasource.clear();
      return Right(done);
    } on Exception{
      return Left(SharedPrefsFailure(message: 'Failed to clear sharedPrefs'));
    }
  }
}