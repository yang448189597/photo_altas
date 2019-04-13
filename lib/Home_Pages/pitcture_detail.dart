import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_atlas/API/api_host.dart';
import 'package:photo_atlas/Home_Widget/favoriteWidget.dart';
import 'package:photo_atlas/Model/Favorite.dart';

import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final Widget placeholder = new Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  print('map length:' + list.length.toString());
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class PicturePreview extends StatefulWidget {
  final String firstPictureUrl;
  final String pictureListUrl;
  final String pictureTitle;

  PicturePreview(
      {this.firstPictureUrl, this.pictureListUrl, this.pictureTitle});

  @override
  _PicturePreviewState createState() => _PicturePreviewState();
}

class _PicturePreviewState extends State<PicturePreview> {
  int _current = 0;

  List _imgList = new List();

  Future<File> file(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    print('dir:' + dir.toString());
    String pathName = p.join(dir.path, filename);
    print('pathName:' + pathName);
    return File(pathName);
  }

  @override
  void initState() {
    dioRequest();
    super.initState();
  }

  Future dioRequest() async {
    Dio dio = new Dio();
    Response response = await dio.get(widget.pictureListUrl);
    print('statusCode:' + response.statusCode.toString());
    Map<String, dynamic> ret = json.decode(response.data);

    setState(() {
      _imgList = ret['images'];
    });

    print('week' + 'id:' + widget.pictureListUrl);
  }

  Widget _controlButton(CarouselSlider pictureSlider) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: new RaisedButton(
            onPressed: () => pictureSlider.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red[300],
            padding: EdgeInsets.all(0.0),
            child: new Text('上一张'),
            textColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            highlightColor: Colors.red,
            splashColor: Colors.black,
            colorBrightness: Brightness.dark,
            elevation: 10.0,
            highlightElevation: 10.0,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: new RaisedButton(
            onPressed: () => pictureSlider.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red[300],
            padding: EdgeInsets.all(0.0),
            child: new Text('下一张'),
            textColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            highlightColor: Colors.red,
            splashColor: Colors.black,
            colorBrightness: Brightness.dark,
            elevation: 10.0,
            highlightElevation: 10.0,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // 图片轮播器
    final _pictureSlider = CarouselSlider(
      height: 600,
      items: map<Widget>(
        _imgList,
        (index, i) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(children: <Widget>[
                Image.network(
                  _imgList[index],
                  fit: BoxFit.cover,
                  height: 600,
                  width: 1000.0,
                  headers: apiHeaders,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. $index',
                      style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ).toList(),
      autoPlay: false,
      initialPage: 0,
      enlargeCenterPage: true,
      aspectRatio: 1.0,
      viewportFraction: 0.9,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );

    // downLoad button
    Widget _downLoadBtnRow(IconData icon, String label) {
      Color color = Colors.white;
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () async {
              print('----------download---------------start');
              print('download picture');
              print('url:' + _imgList[_current]);
              print('----------download---------------end');
              File temp = await file('aaa.png');
              NetworkToFileImage(
                  file: temp,
                  url: _imgList[_current],
                  debug: true,
                  headers: apiHeaders,
              processError: (error) {
                    print(error);
              });
            },
            color: color,
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: new AppBar(
        // 去掉导航栏下面的阴影
        title: new Text('妹子图'),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.bottomCenter,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _pictureSlider,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 18, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FavoriteWidget(
                      favorite: new Favorite(widget.firstPictureUrl,
                          widget.pictureListUrl, widget.pictureTitle),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                    ),
                    _downLoadBtnRow(Icons.file_download, '下载')
                  ],
                ),
              ),
              _controlButton(_pictureSlider)
            ]),
      ),
    );
  }
}
