import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_atlas/App_Me_Pages/downloader_picture_preview.dart';

class DownloadedPictureList extends StatefulWidget {
  @override
  DownloadedPictureListState createState() => new DownloadedPictureListState();
}

class PictureGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GridViewState();
}

class GridViewState extends State {
  List<FileSystemEntity> _files = [];
  @override
  void initState() {
    super.initState();
    loadDownloadImages();
  }

  @override
  Widget build(BuildContext context) => new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      crossAxisCount: 3,
      childAspectRatio: 3 / 4,

      //横向间距
      children: buildGridTileList(_files.length));

  Future loadDownloadImages() async {
    print('----------loadDownloadImages---------------start');

    Directory dir = await getApplicationDocumentsDirectory();
    String dirString = dir.path;
    print('----------dirString---------------start' + dirString);
    var directory = Directory(dirString);
    print('----------directory---------------start' + directory.toString());
    List<FileSystemEntity> files = directory.listSync();
    print(files);
    print('files length' + files.length.toString());
    print('----------loadDownloadImages---------------end');

    setState(() {
      _files = files;
    });
  }

  List<Widget> buildGridTileList(int number) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < number; i++) {
      widgetList.add(getItemWidget(i));
    }
    return widgetList;
  }

  Widget getItemWidget(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: (){
          // 跳转 预览页面
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) {
            return new PictureView(filePath: _files[index].path,);
          }));
        },
          child: new Image.file(
        File(_files[index].path),
        fit: BoxFit.cover,
      )),
    );
  }
}

class DownloadedPictureListState extends State<DownloadedPictureList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的下载'),
      ),
      body: SafeArea(
        child: Center(
          child: new PictureGridView(),
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
  void didUpdateWidget(DownloadedPictureList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}