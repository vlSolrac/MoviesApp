import 'package:flutter/material.dart';
import 'package:movies/providers/app_provider.dart';
import 'package:movies/providers/movies_providers.dart';

import 'package:movies/routers/routes.dart';
import 'package:movies/screens/screens.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      home: const HomeScreen(),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
      theme: appProvider.theme ? AppTheme.ligthTheme : AppTheme.darkTheme,
    );
  }
}
