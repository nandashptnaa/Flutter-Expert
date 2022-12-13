
import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/data/models/tvseries/season_model.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponseModel extends Equatable {
  TvDetailResponseModel({

    required this.seasons,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  List<GenreModel> genres;
  List<TvSeasonModel> seasons;

  bool adult;
  String backdropPath;
  String firstAirDate;
  String homepage;
  int id;
  bool inProduction;
  String lastAirDate;
  String name;
  dynamic nextEpisodeToAir;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  factory TvDetailResponseModel.fromJson(Map<String, dynamic> json) => TvDetailResponseModel(
    seasons: List<TvSeasonModel>.from(json["seasons"].map((x) => TvSeasonModel.fromJson(x))),
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    firstAirDate: json["first_air_date"],
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    lastAirDate: json["last_air_date"],
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "adult": adult,
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate,
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "last_air_date": lastAirDate,
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeriesDetail toEntity(){
    return TvSeriesDetail(

        seasons: seasons.map((e) => e.toEntity()).toList(),
        genres: genres.map((e) => e.toEntity()).toList(),
        adult: adult,
        backdropPath: backdropPath,
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        name: name,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        status: status,
        tagline: tagline,
        type: type,
        voteAverage: voteAverage,
        voteCount: voteCount
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    seasons,
    adult,
    backdropPath,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    lastAirDate,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}

/*class Season {
  Season({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  int episodeCount;
  int id;
  String name;
  String overview;
  String? posterPath;
  int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
  };
}*/

