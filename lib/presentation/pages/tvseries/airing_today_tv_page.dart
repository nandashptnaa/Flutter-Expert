import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:ditonton/presentation/provider/tvseries/airing_today_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AiringTodayPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today';
  const AiringTodayPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayPage> createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<TvSeriesAiringTodayBloc>().add(const FetchTvseriesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series Airing Today'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TvSeriesAiringTodayBloc, TvSeriesState>(
            builder: (context, state) {
              if (state is LoadingTvData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedTvData) {
                final result = state.result;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvseries = result[index];
                    return TvSeriesCard(tvseries);
                  },
                  itemCount: result.length,
                );
              } else if (state is ErrorTvData) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          ),),
    );
  }
}
