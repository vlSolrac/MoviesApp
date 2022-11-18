import 'package:flutter/material.dart';
    
import 'package:movies/screens/screens.dart';

class AppRoutes {
  static String home = "home";
  static String detail = "detail";

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (p0) => const HomeScreen(),
    detail: (p0) => const DetailScreen(),
  };
}
