import 'package:flutter_test/flutter_test.dart';
import 'package:s_c/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:s_c/features/number_trivia/domain/entities/number_trivia.dart';
import 'dart:convert';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "1 Test text");

  test('should be a subclass of NumberTrivia entity', () async {
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
  });

  group('toJson', () {
    test('should return ', () async {
      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      final expectedMap = {
        "text": "1 Test text",
        "number": 1,
      };
      expect(result, equals(expectedMap));
    });
  });
}
