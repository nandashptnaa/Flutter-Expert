import 'package:ditonton/data/models/tvseries/season_model.dart';
import 'package:ditonton/domain/entities/tvseries/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tvSeasonModel = TvSeasonModel(
      episodeCount: 1, 
      id: 1,
      name: 'name',
      overview: 'overview', 
      posterPath: 'posterPath', 
      seasonNumber: 1,  
  );
  final tvSeason = TvSeason(
      episodeCount: 1, 
      id: 1, 
      name: 'name',
      overview: 'overview', 
      posterPath: 'posterPath', 
      seasonNumber: 1, 
  );


  test('should be a subclass of season entity', () async {
    final result = tvSeasonModel.toEntity();
    expect(result, tvSeason);
  });

}