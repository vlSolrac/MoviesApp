import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/providers.dart';
import 'package:movies/theme/app_theme.dart';

import 'package:provider/provider.dart';

import '../routers/routes.dart';

class MovieSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return !appProvider.theme ? AppTheme.darkTheme : AppTheme.ligthTheme;
  }

  @override
  String? get searchFieldLabel => "Seach Movie";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() => close(context, null)),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);
    final size = MediaQuery.of(context).size;

    return query.isEmpty
        ? EmptyContainer(size: size)
        : StreamBuilder(
            stream: moviesProvider.stream,
            // stream: moviesProvider.searchMovie(query),
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              final allMovies = snapshot.data;
              return !snapshot.hasData
                  ? EmptyContainer(size: size)
                  : ListView.builder(
                      itemCount: allMovies!.length,
                      itemBuilder: (context, index) {
                        final movie = allMovies[index];
                        movie.hero = "search-${movie.id}";
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.detail,
                              arguments: movie),
                          child: SearchPoster(
                            size: size,
                            imgMovie: movie.fullPosterImg,
                            title: movie.title,
                            overview: movie.overview,
                            hero: movie.hero!,
                          ),
                        );
                      });
            },
          );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.only(top: size.height * 0.20),
      child: Lottie.asset(
        'assets/search.json',
        reverse: true,
      ),
    ));
  }
}

class SearchPoster extends StatelessWidget {
  final Size size;
  final String imgMovie;
  final String title;
  final String overview;
  final String hero;

  const SearchPoster({
    super.key,
    required this.size,
    required this.imgMovie,
    required this.title,
    required this.overview,
    required this.hero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Hero(
            tag: hero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: size.height * 0.16,
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(imgMovie),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          overview,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ),
                const Icon(Icons.arrow_right_rounded)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
