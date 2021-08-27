import 'package:flutter/material.dart';

import 'package:thepeliculas/src/pages/home_page.dart';
import 'package:thepeliculas/src/pages/start_page.dart';
import 'package:thepeliculas/src/pages/ver_pelicula.dart';
import 'package:thepeliculas/src/user/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'     : ( BuildContext context) => InicioPage(),
        'home'  : ( BuildContext context ) => HomePage(),
        'login' : ( BuildContext context ) => LoginPage(),
        'ver'   : ( BuildContext context ) => VerPelicula()
      },
    );
  }
}