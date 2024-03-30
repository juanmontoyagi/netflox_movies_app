import 'package:flutter/material.dart';
import 'package:netflox_movies_app/providers/movies_providers.dart';
import 'package:netflox_movies_app/search/search_delegate.dart';
import 'package:netflox_movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProviders = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NETFLOX'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search_outlined),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          CardSwiper(movies: moviesProviders.onDisplayMovies),
          MovieSlider(movies: moviesProviders.popularMovies, title: 'Populares', onNextPage: () => moviesProviders.getPopulateMovies()),
          MovieSlider(movies: moviesProviders.upComingMovies, title: 'Próximas', onNextPage: () => moviesProviders.getUpcomingMovies()),
          MovieSlider(movies: moviesProviders.topRatedMovies, title: 'Top Ranked', onNextPage: () => moviesProviders.getTopRatedMovies()),
        ],
      ),
      )
    );
  }
}