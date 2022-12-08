import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/airing_today_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<TvAiringTodayNotifier>(context, listen: false)
            .fetchAiringToday());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Series Airing Today'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<TvAiringTodayNotifier>(
            builder: (context, value, child) {
              if (value.state == RequestState.Loading) {
                return Center(
                  child: const CircularProgressIndicator(),
                );
              } else if (value.state == RequestState.Loaded) {
                return ListView.builder(
                  itemCount: value.airingToday.length,
                  itemBuilder: (context, index) {
                    final airingToday = value.airingToday[index];
                    return TvSeriesCard(airingToday);
                  },
                );
              } else {
                return Center(
                  key: const Key('error_message'),
                  child: Text(value.message),
                );
              }
            },
          )),
    );
  }
}
