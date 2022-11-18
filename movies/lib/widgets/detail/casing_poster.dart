import 'package:flutter/material.dart';

class CastingPoster extends StatelessWidget {
  final Size size;
  final String imgCast;
  final String nameCast;
  const CastingPoster({
    super.key,
    required this.size,
    required this.imgCast,
    required this.nameCast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      width: size.width * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: size.height * 0.16,
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(imgCast),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            nameCast,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
