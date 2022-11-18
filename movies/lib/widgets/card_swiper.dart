import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies/models/models.dart';
import 'package:movies/routers/routes.dart';
import 'package:movies/widgets/widgets.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return movies.isEmpty
        ? Loading(size: size)
        : Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: size.height * 0.5,
            child: Swiper(
              itemCount: movies.length,
              layout: SwiperLayout.STACK,
              itemWidth: size.width * 0.6,
              itemHeight: size.height * 0.6,
              itemBuilder: (context, index) {
                final movie = movies[index];
                movie.hero = "swiper-${movie.id}";
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail,
                      arguments: movie),
                  child: Hero(
                    tag: movie.hero!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage("assets/loading.gif"),
                        image: NetworkImage(movie.fullPosterImg),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
