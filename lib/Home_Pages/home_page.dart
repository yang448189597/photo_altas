import 'package:flutter/material.dart';
import 'package:photo_atlas/Home_Pages/pitcture_detail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('美女集中营'),
      ),
      body: Center(
        child:   RaisedButton(
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new PicturePreview();
          }));
        },
        child: Text("浮动按钮"),
      ),
      ),
    );
  }
}
