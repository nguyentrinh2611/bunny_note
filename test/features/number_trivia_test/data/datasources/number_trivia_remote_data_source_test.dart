import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:s_c/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio, DioAdapter])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = NumberTriviaRemoteDataSourceImpl(
      client: mockDio,
    );
  });

  void setUpSuccess200({required String url}) {
    when(mockDio.get(url)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(
            path: url,
          ),
          statusCode: 200,
          data: (jsonDecode(fixture('trivia.json'))
              as Map<String, dynamic>)["text"],
        ));
  }

  int randomErrorCode() {
    List<int> httpErrorCodes = [
      400, // Bad Request
      401, // Unauthorized
      403, // Forbidden
      404, // Not Found
      500, // Internal Server Error
      502, // Bad Gateway
      503, // Service Unavailable
      504, // Gateway Timeout
    ];
    return httpErrorCodes[Random().nextInt(httpErrorCodes.length - 1)];
  }

  void setUpError({required String url}) {
    when(mockDio.get(url)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(
            path: url,
          ),
          statusCode: randomErrorCode(),
          data: null,
        ));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpSuccess200(
          url: 'http://numbersapi.com/$tNumber',
        );
        // act
        dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockDio.get(
          'http://numbersapi.com/$tNumber',
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpSuccess200(url: 'http://numbersapi.com/$tNumber');
        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpError(url: 'http://numbersapi.com/$tNumber');
        // act
        final call = dataSource.getConcreteNumberTrivia;
        // assert
        expect(
            () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpSuccess200(
          url: 'http://numbersapi.com/random',
        );
        // act
        dataSource.getRandomNumberTrivia();
        // assert
        verify(mockDio.get(
          'http://numbersapi.com/random',
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpSuccess200(
          url: 'http://numbersapi.com/random',
        );
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpError(
          url: 'http://numbersapi.com/random',
        );
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
