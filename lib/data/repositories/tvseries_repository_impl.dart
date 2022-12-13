


import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/remote_data_source.dart';
import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TvRepositoryImpl implements TvRepository{
  final RemoteDataSource remoteDataSource;

  final TvLocalDataSource tvLocalDataSource;
  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.tvLocalDataSource
  });




  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    // TODO: implement getDetailTv
    try{
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    } on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }

  }

  @override
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries() async{
    // TODO: implement getTvAiringToday
    try{
      final result = await remoteDataSource.getAiringTodayTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries() async{
    // TODO: implement getTvOnTheAir
    try{
      final result = await remoteDataSource.getOnTheAirTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }
  }




  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    // TODO: implement getTvPopular
    try{
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async{
    // TODO: implement getTvTopRated
    try{
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async{
    // TODO: implement getWatchlistTv
    final result = await tvLocalDataSource.getWatchlistTvSeries();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTvSeries(int id) async{
    // TODO: implement isAddedToWatchlistTv
    final result = await tvLocalDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvSeries(TvSeriesDetail tvDetail) async{
    // TODO: implement removeWatchlistTv
    try{
      final result = await tvLocalDataSource.removeWatchlistTv(TvSeriesTable.fromEntity(tvDetail));
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvSeries(TvSeriesDetail tvDetail) async{
    // TODO: implement saveWatchlistTv
    try{
      final result = await tvLocalDataSource.insertWatchlistTv(TvSeriesTable.fromEntity(tvDetail));
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }catch(e){
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    // TODO: implement searchTv
    try{
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException {
      return  Left(SSLFailure('certificate failed to verify'));
    }
  }



  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id) async{
    // TODO: implement getRecommendationsTv
    try{
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerFailure{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }
  }

}