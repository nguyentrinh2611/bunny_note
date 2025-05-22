import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final List<String> words = (response.data as String).split(" ");
      final int number = int.tryParse(words.first) ?? 0;
      return NumberTriviaModel(text: response.data, number: number);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');
}
