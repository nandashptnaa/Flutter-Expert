// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/bloc/recommendation_movie_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:ditonton/common/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ditonton/domain/entities/movie/movie.dart' as _i7;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeMovieRepository_0 extends _i1.SmartFake
    implements _i2.MovieRepository {
  _FakeMovieRepository_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends _i1.Mock
    implements _i4.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue:
                  _FakeMovieRepository_0(this, Invocation.getter(#repository)))
          as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.Movie>>(
                          this, Invocation.method(#execute, [id]))))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>);
}
