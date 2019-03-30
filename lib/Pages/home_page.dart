import 'package:flutter/material.dart';
import 'package:photo_atlas/Pages/pitcture_detail.dart';

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
//                    return new PicturePreviewPage(title: '路由是个好东西，要进一步封装');
            return new CarouselWithIndicator();
          }));
        },
        child: Text("浮动按钮"),
      ),
      ),
    );
  }
}
