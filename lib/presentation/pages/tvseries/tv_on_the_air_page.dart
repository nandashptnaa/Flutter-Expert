import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvOnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air';
  const TvOnTheAirPage({Key? key}) : super(key: key);
  @override
  _TvOnTheAirPageState createState() => _TvOnTheAirPageState();
}

class _TvOnTheAirPageState extends State<TvOnTheAirPage> {
  @override
  void initState() {    
    super.initState();
    Future.microtask(() => context.read<TvSeriesOnTheAirBloc>().add(const FetchTvSeriesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesOnTheAirBloc, TvSeriesState>(
            builder: (context, state) {
              if (state is LoadingTvData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHasData) {
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
          ),
      ),
    );
  }
}
