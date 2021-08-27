import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:thepeliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper( { @required this.peliculas } );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width * 0.6,
        itemHeight: MediaQuery.of(context).size.height * 0.5,
        itemBuilder: (BuildContext context, int index){

          peliculas[index].uniqueId = '${ peliculas[index].id }-card';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: _fadeImg( context, index, peliculas[index] ),
            ),
          );
        },
        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );

  }

  _fadeImg( BuildContext context, int index, Pelicula pelicula ) {

    final imagenClick = FadeInImage (
      width: double.infinity,
      height: double.infinity,
      image: NetworkImage( peliculas[index].getPosterImg(), ),
      placeholder: AssetImage('assets/img/no-image.jpg'),
      fit: BoxFit.contain,
    );

    return GestureDetector(
      child: imagenClick,
      onTap: () {
        Navigator.pushNamed(
          context, 'ver',
          arguments: pelicula,
        );
      },
    );

  }
}
