import 'package:flutter/cupertino.dart';
import 'package:movies/models/models.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

class CastingSlider extends StatelessWidget {
  final int idMovie;

  const CastingSlider({
    super.key,
    required this.idMovie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getCatingMovie(idMovie),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        final allCast = snapshot.data;
        return !snapshot.hasData
            ? SizedBox(
                height: size.height * 0.01,
                width: double.infinity,
                child: const CupertinoActivityIndicator(),
              )
            : SizedBox(
                // color: Colors.white,
                height: size.height * 0.25,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Casting",
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: allCast!.length,
                          itemBuilder: (context, index) {
                            final cast = allCast[index];
                            return CastingPoster(
                                size: size,
                                imgCast: cast.fullImg,
                                nameCast: cast.name);
                          }),
                    )
                  ],
                ),
              );
      },
    );
  }
}
