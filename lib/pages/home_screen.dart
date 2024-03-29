import 'package:flutter/material.dart';
import 'package:netflox_movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NETFLOX'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search_outlined),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          CardSwiper(),
          MovieSlider(),
          MovieSlider(),
          MovieSlider()
        ],
      ),
      )
    );
  }
}