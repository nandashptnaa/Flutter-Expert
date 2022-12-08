import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tvseries/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-page';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: kRichBlack,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(            
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.tv,
              color: Colors.white,
            ),
            label: 'Tv',
          ),
        ],
      ), 
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return WatchlistMoviesPage();
          case 1:
            return const WatchlistTvPage() ;
          default:
            return const Center(
              child: Text(
                "Page not found!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
        }
      },
    );
  }
}