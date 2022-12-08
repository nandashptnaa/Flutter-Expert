import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tvSeriesModel = TvSeriesModel(
    backdropPath: "backdropPath",
    genreIds: [18],
    id: 11250,
    name: "Name",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "originalName",
    overview: "Toverview",
    popularity: 1.0,
    posterPath: "posterPath",
    voteAverage: 1.0,
    voteCount: 1
);
  final tvSeries = TvSeries(
      backdropPath: "backdropPath",
      genreIds: [18],
      id: 11250,
      name: "Name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1
  );


  test('should be a subclass of tv entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}