import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  final String overview;
  const Overview({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}
