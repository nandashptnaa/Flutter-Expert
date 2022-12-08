import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/popular_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<TvPopularNotifier>(context, listen: false)
            .fetchPopularTvsEries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TvPopularNotifier>(
          builder: (context, value, child) {
            if (value.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: value.popularTv.length,
                itemBuilder: (context, index) {
                  final tvPopular = value.popularTv[index];
                  return TvSeriesCard(tvPopular);
                },
              );
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
