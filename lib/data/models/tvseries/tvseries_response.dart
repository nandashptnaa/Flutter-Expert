
import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TvResponseModel extends Equatable{
  final List<TvSeriesModel> tvList;

  const TvResponseModel({required this.tvList});

  factory TvResponseModel.fromJson(Map<String, dynamic> json) => TvResponseModel(
    tvList: List<TvSeriesModel>.from((json['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .where((element) => element.backdropPath != null)
    ),
  );

  Map<String, dynamic> toJson() => {
    'results' : List<dynamic>.from(tvList.map((e) => e.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    tvList,
  ];
}