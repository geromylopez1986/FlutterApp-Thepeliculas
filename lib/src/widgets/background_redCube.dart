import 'package:flutter/material.dart';


class BackgroundRedCube extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: NetworkImage('https://i.pinimg.com/originals/df/7b/66/df7b66d7ac329e00f59b2ec1dbc8fe54.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
