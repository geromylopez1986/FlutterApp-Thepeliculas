import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:thepeliculas/src/models/actores_model.dart';
import 'package:thepeliculas/src/models/pelicula_model.dart';



class PeliculaProvider {

  String _apikey      = 'e8eec5e63b49e88f965d71cf0677f4e5';
  String _url         = 'api.themoviedb.org';
  String _language    = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuest( Uri url ) async{

    final resp = await http.get( url );
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;

  }

  Future<List<Pelicula>> getEncines() async{

   final url = Uri.https( _url, '/3/movie/now_playing', {
        'api_key'  : _apikey,
        'language' : _language
      });

   return await _procesarRespuest( url );

  }

  Future<List<Pelicula>> getPopular() async{

    if( _cargando ) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https( _url, '/3/movie/popular', {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuest( url );

    _populares.addAll(resp);
    popularesSink( _populares );

    _cargando = false;

    return resp;

  }

  Future<List<Actor>> getCast( String peliId ) async{

    final url = Uri.https(_url, '/3/movie/$peliId/credits',{
      'api_key'  : _apikey,
      'language' : _language,
    });

    final resp = await http.get( url );
    final decodedData = json.decode( resp.body );
    
    final cast = new Cast.fronJsonList( decodedData['cast'] );

    return cast.actores;

  }

  Future<List<Pelicula>> buscarPelicula( String query ) async{

    final url = Uri.https( _url, '/3/search/movie', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await _procesarRespuest( url );

  }


}