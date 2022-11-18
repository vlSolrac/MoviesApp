import 'package:flutter/material.dart';

import 'package:movies/widgets/widgets.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  final Function onNextPage;
  final String tag;
  const MovieSlider({
    super.key,
    required this.movies,
    required this.title,
    required this.onNextPage,
    required this.tag,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      height: size.height * 0.33,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              style: textStyle,
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                movie.hero = "slider-${widget.tag}-${movie.id}";
                return MoviePoster(size: size, movie: movie);
              },
            ),
          )
        ],
      ),
    );
  }
}
