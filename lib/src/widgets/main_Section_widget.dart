import 'package:flutter/material.dart';

import 'package:thepeliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  final Function nextPage;

  MovieHorizontal( { @required this.peliculas, @required this.nextPage } );

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {
        nextPage();
      }

    });

    return Container(
      width: double.infinity,
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i] ),
      ),
    );

  }

  _tarjeta( BuildContext context, Pelicula pelicula ) {

    pelicula.uniqueId = '${ pelicula.id }-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 180.0,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(
            context, 'ver',
            arguments: pelicula,
        );
      },
    );

  }

}
