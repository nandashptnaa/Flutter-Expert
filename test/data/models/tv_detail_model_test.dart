import 'dart:convert';

import 'package:ditonton/data/models/tvseries/tvseries_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      final result = TvDetailResponseModel.fromJson(jsonMap);
      expect(result, testTvDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = testTvDetailResponse.toJson();
      expect(result, testTvDetailResponseMap);
    });
  });
}