import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/tvseries/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_tv_page';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeObserver.unsubscribe(this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
    ),
    
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer<WatchlistTvNotifier>(
        builder: (context, value, child){
          if(value.watchlistStateTv == RequestState.Loading){
            return const Center(child: CircularProgressIndicator(),);
          }else if(value.watchlistStateTv == RequestState.Loaded){
            return ListView.builder(
              itemCount: value.watchlistTv.length,
              itemBuilder: (context, index){
                final tvSeries = value.watchlistTv[index];
                return TvSeriesCard(tvSeries);
              },
            );
          }else{
            return Center(
              key: const Key('error_message'),
              child: Text(value.message),
            );
          }
        },
      ),)
    );
  }
}
