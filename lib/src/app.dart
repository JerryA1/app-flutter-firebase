import 'package:flutter/material.dart';
import 'package:practica5/src/screens/alta_products.dart';
import 'package:practica5/src/screens/list_products_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/new': (BuildContext context) => NewProduct(),
        '/dashboard': (BuildContext context) => HomeScreen()
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            MaterialButton(
              child: Icon(Icons.add_circle, color: Colors.white),
              // color: Colors.transparent,
              onPressed: (){
                 Navigator.pushNamed(context, '/new');
              },
            )
          ],
        ),
        body: ListProducts(),
      ),
    );
  }
}