import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';

import 'package:photo_atlas/API/api_host.dart';

class AllPage extends StatefulWidget {
  @override
  AllPageState createState() => new AllPageState();
}

class AllPageState extends State<AllPage> with AutomaticKeepAliveClientMixin {
  List _datalist = [];

  // 保持页面状态
  @override
  bool get wantKeepAlive => true;

  Future dioRequest() async {
    Dio dio = new Dio();
    Response response = await dio.get(allBaseUrl);
    print('statusCode:' + response.statusCode.toString());
    Map<String, dynamic> ret = json.decode(response.data);

    //  List dataList = ret['data'];

    setState(() {
      _datalist = ret['data'];
    });

    print('all:' + _datalist.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: RefreshIndicator(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  new Divider(
                    color: Colors.white,
                  ),
              itemCount: _datalist.length,
              itemBuilder: (context, index) {
                return Container(
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
                );
              },
            ),
            onRefresh: () {
              // _datalist.clear();
              // dioRequest();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '+1',
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
  void didUpdateWidget(AllPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
