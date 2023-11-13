import 'package:equatable/equatable.dart';

abstract class TaskFailure extends Equatable {

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends TaskFailure {}

class CacheFailure extends TaskFailure {}

class SharedPrefsFailure extends TaskFailure {
  final String? message;

  SharedPrefsFailure({this.message});

  @override
  String toString() {
    return 'SharedPrefsFailure: $message';
  }
}

class DatabaseFailure extends TaskFailure {
  final String? message;

  DatabaseFailure({this.message});

  @override
  String toString() {
    return 'DatabaseFailure: $message';
  }
}

class GalleryImageFailure extends TaskFailure {}

class DynamicLinkFailure extends TaskFailure {
  final String? message;

  DynamicLinkFailure({this.message});

  @override
  String toString() {
    return 'DynamicLinkFailure: $message';
  }
}

class FireStoreFailure extends TaskFailure {
  final String? message;

  FireStoreFailure({this.message});

  @override
  String toString() {
    return 'FireStoreFailure: $message';
  }
}

class PayStackFailure extends TaskFailure {
  final String? message;

  PayStackFailure({this.message});

  @override
  String toString() {
    return 'PayStackFailure: $message';
  }
}

class AssetFailure extends TaskFailure {
  final String? message;

  AssetFailure({this.message});

  @override
  String toString() {
    return 'AssetFailure: $message';
  }
}

class DecodeImageFailure extends TaskFailure {}

class ProcessImageFailure extends TaskFailure {}

class TypeError extends TaskFailure {}
