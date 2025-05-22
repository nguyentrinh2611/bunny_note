// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, DefaultParams> {
  Future<Either<Failure, Type>?> call(DefaultParams params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class DefaultParams extends Equatable {
  final bool isShowDefaultLoading;
  const DefaultParams({
    this.isShowDefaultLoading = true,
  });
  @override
  List<Object?> get props => [isShowDefaultLoading];
}
