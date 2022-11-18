import 'package:flutter/material.dart';
import 'package:movies/providers/providers.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
//Parametes.

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.nowPlayMovies),
              const SizedBox(height: 10),
              MovieSlider(
                title: "Popular Movies",
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                tag: "popular",
              ),
              // MovieSlider(
              //   title: "Upcoming Movies",
              //   movies: moviesProvider.upcomingMovies,
              //   onNextPage: () => moviesProvider.getUpComingMovies(),
              //   tag: "upcoming",
              // ),
              // MovieSlider(
              //   title: "Top Rated Movies",
              //   movies: moviesProvider.topRatedMovies,
              //   onNextPage: () => moviesProvider.getTopRatedMovies(),
              //   tag: "rated",
              // ),
              // MovieSlider(),
            ],
          ),
        ));
  }
}
