import 'dart:core';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_atlas/Pages/pitcture_detail.dart';
import 'package:photo_atlas/API/api_host.dart';

class WeekPage extends StatefulWidget {
  @override
  WeekPageState createState() => new WeekPageState();
}

class WeekPageState extends State<WeekPage> with AutomaticKeepAliveClientMixin {
  List _datalist = [];

  // 保持页面状态
  @override
  bool get wantKeepAlive => true;

  Future dioRequest() async {
    Dio dio = new Dio();
    Response response = await dio.get(weekBaseUrl);
    print('statusCode:' + response.statusCode.toString());
    Map<String, dynamic> ret = json.decode(response.data);

    //  List dataList = ret['data'];

    setState(() {
      _datalist = ret['data'];
    });

    print('week' + _datalist.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => new Divider(
                  color: Colors.white,
                ),
            itemCount: _datalist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){

                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                    return new CarouselWithIndicator();
                  }));

                  Fluttertoast.showToast(
                      msg: '点击了第'+_datalist[index]['id'].toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.black,
                      backgroundColor: Colors.white12);
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _datalist[index]['image'],
                          headers: apiHeaders,
                          fit: BoxFit.cover,
                          width: 350.0,
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Text(_datalist[index]['title'],
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFFffffff))),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          onRefresh: () {
            // _datalist.clear();
            // dioRequest();
          }
          ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _datalist = new List();
    dioRequest();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(WeekPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
