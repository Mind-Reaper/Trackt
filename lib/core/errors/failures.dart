

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message = 'Failed.']);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server failure.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache failure.']);
}
