import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica5/src/app.dart';
import 'package:practica5/src/models/product_dao.dart';
import 'package:practica5/src/providers/firebase_providers.dart';

class formNewProduct extends StatefulWidget {
  formNewProduct({Key key}) : super(key: key);

  @override
  _formNewProductState createState() => _formNewProductState();
}

class _formNewProductState extends State<formNewProduct> {
  TextEditingController claveController = TextEditingController()..text = '';
  TextEditingController descripcController = TextEditingController()..text = '';
  File _image, _imageSheet;
  final picker = ImagePicker();

  FirebaseProvider firestore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if( product != null ){
      claveController.text    = product['model'];
      descripcController.text = product['description'];
    }

    return Container(
       child: formView(product),
    );
  }

  Widget formView(product){
    final txtClave = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
      controller: claveController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: 'Clave',
        hintText: 'Introduce la clave del producto',
        labelStyle: TextStyle(
          color: Colors.white
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 4)
      ),
    );

    final txtDescripc = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
      controller: descripcController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: 'Descripción',
        hintText: 'Introduce la descripción del producto',
        labelStyle: TextStyle(
          color: Colors.white
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 4)
      ),
    );
    
    final photoBtn = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),              
      color: Colors.amberAccent,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Icon(
              Icons.photo_library,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () async{
        chooseModelFile();
        print(_image);
      },
    );

    final saveBtn = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(255, 255, 255, 1), // Color pinkAccent
      child: Row( // Add a Row Widget for placing objects.
        mainAxisAlignment: MainAxisAlignment.center, // Center the Widgets.
        mainAxisSize: MainAxisSize.max, // Use all of width in RaisedButton.
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0), // Give to the text some space.
            child: Text(
              "Enviar",
              style: TextStyle(
                fontSize: 18, // 18pt in font.
                color: Colors.black, // You can ommit it if you use textColor in RaisedButton.
              ),
            ),
          ),
          Icon(
            Icons.send, // Send Icon. (Papper Plane Icon)
            color: Colors.black, // White Color. You can ommit it too if you use textColor property on RaisedButton.
            size: 18, // 18 pt, same as text.
          ),
        ],
      ),     
      onPressed: () async{
        if (product != null) {
          print('Actualizar producto');
        } else {
          print('Guardar producto');
          await uploadProductToCloud(context);
        }
        // Navigator.pushAndRemoveUntil(
        //   context, 
        //   MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), 
        //   ModalRoute.withName('/dashboard')
        // );
        // Navigator.pop(context);
      }
    );

    final imgFinal = _image == null 
      ? product != null ? CircleAvatar(radius: 70, backgroundImage: NetworkImage(product['image'])) :  CircleAvatar(radius: 70, backgroundImage: NetworkImage('https://www.nicepng.com/png/detail/304-3048415_business-advice-product-icon-png.png'))
      : ClipOval(child: Image.file(_image, fit: BoxFit.cover, width: 130,),);
    var _avatarPic = imgFinal;

    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Container(height: 50, width: 50 ,child: Icon(Icons.arrow_back_ios, size: 24,color: Colors.black54,), decoration: BoxDecoration(border: Border.all(color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(10))),),
                Text('Product details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Container(height: 24,width: 24)
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0,0 ,50),
              child: Stack(
                children: <Widget>[
                  _avatarPic,
                  Positioned(bottom: 1, right: 1 ,child: Container(
                    height: 40, width: 40,
                    child: photoBtn,
                  ))
                ],
              ),
            ),
          ),
          Expanded(child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.blueGrey
            ),
            child: Column(
              children: <Widget>[              
                 Expanded(
                  child: Card(
                    color: Colors.blueGrey,
                    margin: EdgeInsets.all(20.0),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            SizedBox(height: 5,),
                            txtClave,
                            SizedBox(height: 26,),
                            txtDescripc,
                            SizedBox(height: 35,),
                            saveBtn
                          ],
                      ),
                    ),
                  ),
                ),              
              ],
            ),
          ))
        ],
      );
  }

  Future chooseModelFile() async {    
    await picker.getImage(source: ImageSource.gallery).then((image) {    
      setState(() {    
        _image = File(image.path);    
      });    
    });    
  }

  void uploadProductToCloud(var context) async{
    if( claveController.text.isNotEmpty && descripcController.text.isNotEmpty && _image != null ){
      firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref().child(claveController.text.trim());
      final firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();

      await firestore.saveProduct(
        ProductDAO(
          model         : claveController.text,
          image         : imageUrl.toString(),
          description   : descripcController.text,
        )
      );

      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), 
        ModalRoute.withName('/dashboard')
      );
    }else{
      _showDialog(context);
    }
  }

  void updateProductToCloud(var data) async {
    
    String urlImage = data['image'];

    // Verificamos si se seleccionó una imagen de la galeria
    if( _image != null ){
      // Borramos imagen
      firebase_storage.Reference photoRef = await firebase_storage.FirebaseStorage.instance.getReferenceFromUrl(data['image']);await photoRef.delete().then((image){});
      // Subimos nueva imagen
      firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref().child(claveController.text.trim());
      final firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
      urlImage = await (await uploadTask).ref.getDownloadURL().toString();
    }
  
     await firestore.updateProduct(
      ProductDAO(
        model         : claveController.text,
        image         : urlImage,
        description   : descripcController.text,
      ),
      data['documentid']
    );
  }

  Future<void> _showDialog(BuildContext context){
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context){
        return AlertDialog(
          title: Text('Advertencia'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Los datos enviados son incorrectos.'),
                Text('Por favor revisalos'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ); 
      }
    );
  }
}