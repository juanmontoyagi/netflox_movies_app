import 'package:flutter/material.dart';

import 'package:netflox_movies_app/pages/pages.dart';
import 'package:netflox_movies_app/providers/movies_providers.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
    const AppState({super.key});
  
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false,)
        ],
        child: const MyApp(),
        );
    }
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NETFLOX',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'detail': ( _ ) => DetailsScreen(),
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.red[900],
        )
      ),
    );
  }
}