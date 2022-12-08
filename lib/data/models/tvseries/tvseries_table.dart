
import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable{
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvDetail) => TvSeriesTable(
      id: tvDetail.id,
      name: tvDetail.name,
      posterPath: tvDetail.posterPath,
      overview: tvDetail.overview
  );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
      id: map["id"],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
  );

  factory TvSeriesTable.fromDTO(TvSeriesModel tvModel) => TvSeriesTable(
      id: tvModel.id,
      name: tvModel.name,
      posterPath: tvModel.posterPath,
      overview: tvModel.overview
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  TvSeries toEntity() => TvSeries.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    overview: overview,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview,
  ];


}