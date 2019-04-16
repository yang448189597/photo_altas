import 'dart:io';

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
      ),

      body: Container(
        child: PhotoView(
          imageProvider: FileImage(File(widget.filePath)),
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
}
