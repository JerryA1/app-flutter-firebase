import 'package:flutter/material.dart';
import 'package:practica5/src/views/form_product.dart';

class NewProduct extends StatefulWidget {
  NewProduct({Key key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: Text('New Product'),
        ),
        body: formNewProduct(),
        resizeToAvoidBottomPadding: false 
      ),
    );
  }
}