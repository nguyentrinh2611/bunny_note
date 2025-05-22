part of 'number_trivia_cubit.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class EmptyTrivia extends NumberTriviaState {}

class LoadingTrivia extends NumberTriviaState {}

class LoadedTrivia extends NumberTriviaState {
  final NumberTrivia trivia;

  const LoadedTrivia({required this.trivia});
}

class ErrorTrivia extends NumberTriviaState {
  final String message;

  const ErrorTrivia({required this.message});
}
