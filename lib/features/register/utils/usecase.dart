import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clearance_processing_system/core/config/exceptions/task_failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<TaskFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
