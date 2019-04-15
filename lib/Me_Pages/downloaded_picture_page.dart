import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_atlas/API/api_host.dart';
import 'package:photo_atlas/Home_Pages/pitcture_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DownloadedPictureList extends StatefulWidget {
  @override
  DownloadedPictureListState createState() => new DownloadedPictureListState();
}

class DownloadedPictureListState extends State<DownloadedPictureList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的下载'),
      ),
      body: Center(
        child: new Text('下载列表'),
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