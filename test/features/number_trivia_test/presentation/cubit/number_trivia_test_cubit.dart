import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/extensions/number_input_converter.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:s_c/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:s_c/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:s_c/features/number_trivia/presentation/cubit/number_trivia_cubit.dart';

import 'number_trivia_test_cubit.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([NumberInputConverter])
void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockNumberInputConverter mockNumberInputConverter;
  late NumberTriviaCubit cubit;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockNumberInputConverter = MockNumberInputConverter();

    cubit = NumberTriviaCubit(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      numberInputConverter: mockNumberInputConverter,
    );
  });

  test('initialState should be Empty', () async {
    //assert
    expect(cubit.initialState, equals(EmptyTrivia()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockNumberInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));
    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      cubit.getTriviaForConcreteNumber(tNumberString);
      await untilCalled(mockNumberInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockNumberInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [ErrorTrivia()] when the inpus is invalid.', () async* {
      //arrange
      when(mockNumberInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final expected = [
        EmptyTrivia(),
        const ErrorTrivia(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      //assert later
      expectLater(cubit, emitsInOrder(expected));

      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });

    test('should get data from the concrete usecase', () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
      await untilCalled(mockGetRandomNumberTrivia(any));

      //assert
      verify(mockGetConcreteNumberTrivia(
          const NumberTriviaParams(number: tNumberParsed)));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const LoadedTrivia(trivia: tNumberTrivia)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Left(ServerFailure()));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const ErrorTrivia(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });

    test(
        'should emits [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const ErrorTrivia(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForConcreteNumber(tNumberString);
    });
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the random usecase', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      cubit.getTriviaForRandomNumber();
      await untilCalled(mockGetRandomNumberTrivia(any));

      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });
    test('should emits [Loading, Loaded] when data is gotten successfully',
        () async* {
      //arrange
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const LoadedTrivia(trivia: tNumberTrivia)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForRandomNumber();
    });
    test('should emits [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Left(ServerFailure()));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const ErrorTrivia(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForRandomNumber();
    });

    test(
        'should emits [Loading, Error] with a proper message for the error when getting data fails',
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expeted = [
        EmptyTrivia(),
        LoadingTrivia(),
        const ErrorTrivia(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(cubit, emitsInOrder(expeted));
      //act
      cubit.getTriviaForRandomNumber();
    });
  });
}
