import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key key,
    @required this.productDocument
  }) : super(key: key);

  final DocumentSnapshot productDocument;

  @override
  Widget build(BuildContext context) {print(productDocument.data());
    final _card = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            placeholder: AssetImage('assets/activity_indicator.gif'),
            // image: NetworkImage(productDocument['image']),
            image: productDocument['image'] == null || productDocument['image'] == '' ? NetworkImage('https://www.nicepng.com/png/detail/304-3048415_business-advice-product-icon-png.png') : NetworkImage(productDocument['image']),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 100),
            height: 230.0,
          ),
        ),
        Opacity(
          opacity: .6,
          child: Container(
            height: 55.0,
            color: Colors.black,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(productDocument['model'], style: TextStyle(color: Colors.white),),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.edit, color: Colors.white,),
                  onPressed: (){
                    Navigator.pushNamed(context, 
                      '/new',
                      arguments: {
                        'model': productDocument['model'],
                        'description': productDocument['description'],
                        'image': productDocument['image']
                      }
                    );
                  }
                )
              ],
            ),
          ),
        )
      ],
    );

    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(0.0, 5.0),
            blurRadius: 1.0
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _card,
      ),
    );
  }
}