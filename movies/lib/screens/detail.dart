import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';
import 'package:movies/screens/screens.dart';
import '../widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
//Parametes.

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // get arguments
    final Movie? movie = ModalRoute.of(context)?.settings.arguments as Movie?;
    //global variables.

    return movie == null
        ? const NotFoundScreen()
        : Scaffold(
            body: CustomScrollView(
            slivers: [
              CustomAppBar(
                size: size,
                title: movie.title,
                imgUrl: movie.fullBackDropImg,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  PosterAndTitle(
                    size: size,
                    imgUrl: movie.fullPosterImg,
                    title: movie.title,
                    originalTitle: movie.originalTitle,
                    rating: movie.voteAverage.toString(),
                    id: movie.id,
                  ),
                  Overview(overview: movie.overview),
                  Overview(overview: movie.overview),
                  CastingSlider(idMovie: movie.id),
                  const SizedBox(height: 20)
                ]),
              )
            ],
          ));
  }
}
