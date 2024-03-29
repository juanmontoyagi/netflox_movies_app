import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieSlider extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('En Tendencia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: ( _, int index ) => _MoviePoster() 
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 130,
                  height: 190,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'detail', arguments: 'movie-instance'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/no-image.jpg'), 
                            image: AssetImage('assets/no-image.jpg'),
                            width: 130,
                            height: 160,
                            fit: BoxFit.cover,
                            ),
                        ),
                      ),

                        SizedBox(height: 5,),
                        Text(
                          'La mejor película de Netflox para ver ahora mismo.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                );
  }
}