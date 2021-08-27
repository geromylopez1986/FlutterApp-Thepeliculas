import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:thepeliculas/src/widgets/video_player.dart';
import 'home_page.dart';

class InicioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        VideoApp(),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _fadeImagenLogo(),
                _heightSpace( 50.0),
                _bodyText(),
                _btnEntrar( context ),
                _heightSpace( 50.0),
                _btnUser( context ),
                _heightSpace(20.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _fadeImagenLogo() {

    return Image(
      width: 320.0,
      image: AssetImage( 'assets/logo/cs.png' ),
      fit: BoxFit.fill,
    );

  }

  _heightSpace( double h ) {

    return SizedBox(height: h);

  }

  _bodyText() {

    return Container(
      width: 350.0,
      height:  100.0,
      child: Text(
        'Bienvenido disfruta de todo el contenido que te ofrecemos',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
    );

  }

  _btnEntrar( BuildContext context ) {

    return ClipRRect(
      borderRadius: BorderRadius.circular( 10.0 ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, 'home' ),
        child: Text('ENTRAR'),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            primary: Colors.red
        ),
      ),
    );

  }

  _btnUser( BuildContext context ) {

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular( 10.0 ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  side: BorderSide(color: Colors.deepPurpleAccent)
              ),
              autofocus: true,
              onPressed: () => Navigator.pushNamed(context, 'login'),
              child: Text(
                  'INICIAR SESIÓN'
              ),
            ),
          ),
          _heightSpace( 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular( 10.0 ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent,
              ),
              autofocus: true,
              onPressed: () {},
              child: Text(
                  'REGISTRARME'
              ),
            ),
          ),
        ],
      ),
    );

  }

  _footerPage() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            '2021 Copyright thepeliculas.com',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );

  }

}
