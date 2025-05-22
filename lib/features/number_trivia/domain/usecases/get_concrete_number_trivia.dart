import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, NumberTriviaParams> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>?> call(NumberTriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class NumberTriviaParams extends DefaultParams {
  final int number;

  const NumberTriviaParams({required this.number});

  @override
  List<Object?> get props => [number, isShowDefaultLoading];
}
