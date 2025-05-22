// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/extensions/number_input_converter.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_state.dart';

class NumberTriviaCubit extends Cubit<NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final NumberInputConverter numberInputConverter;

  NumberTriviaState get initialState => EmptyTrivia();
  NumberTriviaCubit({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.numberInputConverter,
  }) : super(EmptyTrivia());

  Future<void>? getTriviaForConcreteNumber(String numberString) async {
    final inputEither =
        numberInputConverter.stringToUnsignedInteger(numberString);
    inputEither.fold((failure) {
      emit(const ErrorTrivia(message: INVALID_INPUT_FAILURE_MESSAGE));
    }, (integer) async {
      emit(LoadingTrivia());
      final failureOrTrivia =
          await getConcreteNumberTrivia(NumberTriviaParams(number: integer));
      failureOrTrivia!.fold((failure) {
        emit(ErrorTrivia(message: _mapFailureToMessage(failure)));
      }, (trivia) {
        emit(LoadedTrivia(trivia: trivia));
      });
    });
  }

  Future<void>? getTriviaForRandomNumber() async {
    emit(LoadingTrivia());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    failureOrTrivia!.fold((failure) {
      emit(ErrorTrivia(message: _mapFailureToMessage(failure)));
    }, (trivia) {
      emit(LoadedTrivia(trivia: trivia));
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';
