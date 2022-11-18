import 'package:flutter/material.dart';
import 'package:movies/delegates/delegates.dart';

import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatelessWidget {
//Parametes.

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.

    final moviesProvider = Provider.of<MoviesProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          actions: [
            IconButton(
              key: const Key("Btn_Search"),
              onPressed: () {
                showSearch(context: context, delegate: MovieSearch());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                appProvider.changeTheme();
              },
              icon:
                  Icon(appProvider.theme ? Icons.dark_mode : Icons.light_mode),
              splashRadius: 1,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // moviesProvider.nowPlayMovies.isEmpty ? const Text("Cargandfo") : CardSwiper(movies: moviesProvider.nowPlayMovies),
              CardSwiper(movies: moviesProvider.nowPlayMovies),
              const SizedBox(height: 10),
              MovieSlider(
                title: "Popular Movies",
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                tag: "popular",
              ),
              MovieSlider(
                title: "Upcoming Movies",
                movies: moviesProvider.upcomingMovies,
                onNextPage: () => moviesProvider.getUpComingMovies(),
                tag: "upcoming",
              ),
              MovieSlider(
                title: "Top Rated Movies",
                movies: moviesProvider.topRatedMovies,
                onNextPage: () => moviesProvider.getTopRatedMovies(),
                tag: "rated",
              ),
              // MovieSlider(),
            ],
          ),
        ));
  }
}
