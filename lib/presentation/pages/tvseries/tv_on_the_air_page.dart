import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/on_the_air_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<TvOnTheAirNotifier>(context, listen: false)
            .fetchTvOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TvOnTheAirNotifier>(
          builder: (context, value, child) {
            if (value.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.state == RequestState.Loaded) {
              print('Berhasil');
              return ListView.builder(
                  itemCount: value.tv.length,
                  itemBuilder: (context, index) {
                    final tvSeries = value.tv[index];
                    return TvSeriesCard(tvSeries);
                  });
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }
}
