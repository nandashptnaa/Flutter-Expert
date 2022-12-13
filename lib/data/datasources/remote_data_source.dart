import 'dart:convert';

import 'package:ditonton/data/models/movie/movie_detail_model.dart';
import 'package:ditonton/data/models/movie/movie_model.dart';
import 'package:ditonton/data/models/movie/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvseries/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_response.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);

  Future<List<TvSeriesModel>> getTvRecommendations(int id);
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<TvDetailResponseModel> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TvDetailResponseModel> getTvSeriesDetail(int id) async{    
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if(response.statusCode == 200){
      return TvDetailResponseModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async{
    // TODO: implement getTvAiringToday
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;

    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    // TODO: implement getTvOnTheAir
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async{
    // TODO: implement getTvPopular
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    }else{
      throw ServerException();
    }
  }

  
  @override
  Future<List<TvSeriesModel>> getTvRecommendations(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    }
    throw ServerException();
  }
  
  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async{
    // TODO: implement getTvTopRated
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async{
    // TODO: implement searchTv
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if(response.statusCode == 200){
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    }else{
      throw ServerException();
    }
  }
}
