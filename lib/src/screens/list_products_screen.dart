import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica5/src/providers/firebase_providers.dart';
import 'package:practica5/src/views/card_product.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  FirebaseProvider firestore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore = FirebaseProvider();
  }
  
  @override
  Widget build(BuildContext context) {
    // return CustomScrollView(
    //   slivers: [
    //     StreamBuilder(
    //     stream: firestore.getAllProducts(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    //       return SliverGrid(
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2,
    //           childAspectRatio: .8
    //         ),
    //         delegate: SliverChildBuilderDelegate((BuildContext context, int index){
    //           return CardProduct(productDocument: snapshot.data.docs[index],);
    //         },
    //         childCount: snapshot.data.docs.length),
    //       );
    //     }
    //   ),]
    // );
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.getAllProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document){
            return CardProduct(productDocument: document,);
            // new ListTile(
            //   title: new Text(document.data()['model']),
            //   subtitle: new Text(document.data()['description']),
            // );
          }).toList(),
        );
      }
    );
  }
}