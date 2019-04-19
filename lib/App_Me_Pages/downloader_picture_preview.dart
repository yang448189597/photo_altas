import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PictureView extends StatefulWidget {
  const PictureView({Key key, this.filePath}) : super(key: key);
  final String filePath;

  @override
  PictureViewState createState() => new PictureViewState();
}

class PictureViewState extends State<PictureView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('图片预览'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right:16),
            child: new GestureDetector(
                child: new Icon(Icons.menu),
                onTap: () {
                  final reslut = showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          2000.0,
                          kBottomNavigationBarHeight +
                              MediaQueryData.fromWindow(window).padding.top,
                          16.0,
                          0.0),
                      items: <PopupMenuItem<String>>[
                        PopupMenuItem(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Icon(Icons.add_photo_alternate,color: Colors.redAccent,),
                            new Text('保存图库'),
                          ],
                        )),

                        PopupMenuItem(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Icon(Icons.delete_forever,color: Colors.redAccent),
                                new Text('移除列表'),
                              ],
                            )),
                      ]);
                }),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: PhotoView(
            imageProvider: FileImage(File(widget.filePath)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(PictureView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  // 添加到系统相册
  void saveToGallery(){}

  // 移除列表
  void removePicture(){}
}
