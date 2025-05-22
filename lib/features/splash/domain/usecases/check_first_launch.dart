// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

class CheckFirstLaunch extends UseCase<bool, NoParams> {
  final SplashRepository repository;
  CheckFirstLaunch({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool>?> call(NoParams params) async {
    return await repository.checkFirstLaunch();
  }
}
