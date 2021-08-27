import 'package:flutter/material.dart';


import 'package:thepeliculas/src/providers/pelicula_provider.dart';
import 'package:thepeliculas/src/search/search_delegate.dart';
import 'package:thepeliculas/src/widgets/card_swiper_widget.dart';
import 'package:thepeliculas/src/widgets/main_Section_widget.dart';


class HomePage extends StatelessWidget {
  final peliculaProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {

    peliculaProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearch(),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Container(
              child: FadeInImage(
                width: 180.0,
                image: AssetImage('assets/logo/cs.png'),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _swiperCard(),
                SizedBox(height: 50.0,),
                _mainSection(context),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _swiperCard() {
    return FutureBuilder(
        future: peliculaProvider.getEncines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  _mainSection(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
              child: Text('POPULARES',
                  style: Theme.of(context).textTheme.subtitle1
              ),
          ),
          SizedBox(
            height: 15.0,
          ),
          StreamBuilder(
            stream: peliculaProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  nextPage: peliculaProvider.getPopular

                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
