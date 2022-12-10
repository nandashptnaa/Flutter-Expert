import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart' as movieblloc;
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart' as movieblloc;
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart' as movieblloc;
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<movieblloc.WatchlistMovieBloc>()
          .add(movieblloc.FetchMoviesData());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context 
      .read<movieblloc.WatchlistMovieBloc>()
      .add(movieblloc.FetchMoviesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<movieblloc.WatchlistMovieBloc, movieblloc.MovieListState>(
        builder: (context, state) {
          if (state is movieblloc.LoadingData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is movieblloc.MovieListHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is movieblloc.ErrorData) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
