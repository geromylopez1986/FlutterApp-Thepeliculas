import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:thepeliculas/src/models/actores_model.dart';
import 'package:thepeliculas/src/models/pelicula_model.dart';
import 'package:thepeliculas/src/providers/pelicula_provider.dart';



class VerPelicula extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0, ),
                _posterTitle( context, pelicula ),
                _description( pelicula ),
                _crearCasting( pelicula ),
              ]
            ),
          ),
        ],
      ),
    );
  }  // build

  _crearAppbar( Pelicula pelicula ) {

    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
         title: Text(
            pelicula.title,
          style: TextStyle(
            fontSize: 16.0
          ),
        ),
        background: FadeInImage(
          image: NetworkImage( pelicula.getBackdropPath() ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );

  }  // _crearAppbar

  _posterTitle( BuildContext context, Pelicula pelicula ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                height: 250.0,
                  image: NetworkImage( pelicula.getPosterImg(), ),
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( pelicula.title, style: Theme.of(context).textTheme.subtitle1 ),
                  Text( pelicula.originalTitle, style: TextStyle(color: Colors.white60) ),
                  Row(
                    children: [
                      Icon(Icons.star_border),
                      Text( pelicula.voteAverage.toString() ),
                    ],
                  ),
                ],
              ),
          ),
        ],
      ),
    );

  }  // _posterTitle

  _description(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text( pelicula.overview, textAlign: TextAlign.justify, ),
    );

  }  // _description

  _crearCasting( Pelicula pelicula ) {

    final peliProvide = new PeliculaProvider();

    return FutureBuilder(
      future: peliProvide.getCast( pelicula.id.toString() ),
      builder: ( BuildContext context, AsyncSnapshot<List> snapshot ) {

        if( snapshot.hasData ) {
          return _crearActoresPageView( snapshot.data );
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },

    );

  }   // _crearCasting

  _crearActoresPageView( List<Actor> actores ) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
          itemBuilder: ( context, index ) => _actorCard( actores[index], ),
      ),
    );

  }  // _crearActoresPageView

  _actorCard(Actor actor) {

    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getPicture() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name),
        ],
      ),
    );

  }  // _actorCard


} // VerPelicula Classe Padre
