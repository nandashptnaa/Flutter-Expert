import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tvseries/airing_today_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_on_the_air_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/tvseries/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tvs';

  const TvPage({Key? key}) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
      context.read<TvSeriesAiringTodayBloc>().add(const FetchTvseriesData()),
      context.read<TvSeriesOnTheAirBloc>().add(const FetchTvseriesData()),
      context.read<PopularTvseriesBloc>().add(const FetchTvseriesData()),
      context.read<TopRatedTvseriesBloc>().add(const FetchTvseriesData()),});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com')
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () => {
                // Navigator.pop(context)
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME)
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              onTap: () => {
                Navigator.pop(context)
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Watchlist'),
              onTap: () {
                // Navigator.pushNamed(context, WatchlistPage.routeName);
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvseriesBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is LoadingTvData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedTvData) {
                    final result = state.result;
                    return TvList(result);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME);
                }
              ),
              BlocBuilder<PopularTvseriesBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is LoadingTvData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedTvData) {
                    final result = state.result;
                    return TvList(result);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'On The Air',
                onTap: () {
                  Navigator.pushNamed(context, TvOnTheAirPage.ROUTE_NAME);
                }
              ),       
              BlocBuilder<TvSeriesOnTheAirBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is LoadingTvData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedTvData) {
                    final result = state.result;
                    return TvList(result);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () {
                  Navigator.pushNamed(context, AiringTodayPage.ROUTE_NAME);
                }
              ),
              BlocBuilder<TvSeriesOnTheAirBloc, TvSeriesState>(
                builder: (context, state) {
                  if (state is LoadingTvData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedTvData) {
                    final result = state.result;
                    return TvList(result);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [Text('See more'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tv.length,
        itemBuilder: (context, index) {
          final tvSeries = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                debugPrint('${tvSeries.id}');
                Navigator.pushNamed(context, TvDetailPage.ROUTE_NAME,
                    arguments: tvSeries.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
