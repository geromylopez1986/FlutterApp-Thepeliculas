import 'package:flutter/material.dart';
import 'package:thepeliculas/src/widgets/background_redCube.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: BackgroundRedCube(),
    );
  }
}
