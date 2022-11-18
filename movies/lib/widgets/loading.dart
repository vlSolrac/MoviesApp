import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Size size;
  const Loading({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Image(
          width: size.width * 0.5,
          height: size.height * 0.5,
          fit: BoxFit.cover,
          image: const AssetImage("assets/giphy.gif"),
        ),
      ),
    );
  }
}
