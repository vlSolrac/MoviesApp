import 'package:flutter/material.dart';

class PosterAndTitle extends StatelessWidget {
  final Size size;
  final String imgUrl;
  final String title;
  final String originalTitle;
  final String rating;
  final int id;

  const PosterAndTitle({
    super.key,
    required this.size,
    required this.imgUrl,
    required this.title,
    required this.originalTitle,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Hero(
            tag: id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                height: size.height * 0.26,
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(imgUrl),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline5,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        originalTitle,
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5),
                    Text(rating, style: Theme.of(context).textTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
