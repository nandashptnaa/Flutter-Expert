import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_state.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState> implements MovieDetailBloc {}

class MovieStateFake extends Fake implements MovieDetailState {}

class MovieEventFake extends Fake implements MovieListEvent {}

class MockRecommendationMovieBloc extends MockBloc<MovieListEvent, MovieListState> implements MovieRecommendationsBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;
  late MockRecommendationMovieBloc mockBlocRecom;

  setUpAll(() {
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    mockBlocRecom = MockRecommendationMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockBloc),
        BlocProvider<MovieRecommendationsBloc>.value(value: mockBlocRecom),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(' Page should display Progressbar when movie detail loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(movieDetailState: RequestState.Loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display Progressbar when recommendation movie is loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      isAddedToWatchlist: false,
      movieDetail: testMovieDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadingData());

    final progressBarFinder = find.byType(CircularProgressIndicator).first;

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      isAddedToWatchlist: true,
    ));
    when(() => mockBlocRecom.state).thenReturn(MovieListHasData(testMovieList));
    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      isAddedToWatchlist: false,
      movieDetail: testMovieDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(MovieListHasData(testMovieList));
    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });
}

