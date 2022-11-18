import 'package:flutter/material.dart';
import 'package:movies/theme/colors_theme.dart';

import '../../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  final Size size;
  final String title;
  final String imgUrl;

  const CustomAppBar({
    super.key,
    required this.size,
    required this.title,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsTheme.primary,
      expandedHeight: size.height * 0.3,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black38,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
