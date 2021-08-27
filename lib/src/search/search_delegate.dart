import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:thepeliculas/src/models/pelicula_model.dart';
import 'package:thepeliculas/src/providers/pelicula_provider.dart';



class DataSearch extends SearchDelegate {

  final peliculasProvider = new PeliculaProvider();

  final peliculas = [
    'Batman 2021',
    'Advenger',
    'superman 2',
    'Zhasan',
    'La Momia return',
    'shrek'
  ];

  final peliculasRecientes = [
    'Batman 2021',
    'Advenger'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las Acciones de nuestro AppBar

    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon( Icons.clear ),
      ),
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar

    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            progress: transitionAnimation,
            icon: AnimatedIcons.menu_arrow,
        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar en la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Spm ñas sigerencias que aparecen cuando se esta tipiando una busqueda

    if( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPelicula( query ),
        builder: ( BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot ) {

          if( snapshot.hasData ) {

            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map(
                      ( pelicula ) {
                        return ListTile(
                          leading: FadeInImage(
                            image: NetworkImage( pelicula.getPosterImg() ),
                            placeholder: AssetImage('assets/img/no-image.jpg'),
                            width: 50.0,
                            fit: BoxFit.contain,
                          ),
                          title: Text( pelicula.title ),
                          subtitle: Text( pelicula.originalTitle ),
                          onTap: () {
                            close(context, null);
                            pelicula.uniqueId = '';
                            Navigator.pushNamed(context, 'ver', arguments: pelicula);
                          },
                        );
                },
              ).toList(),
            );

          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        }
    );


  }

}