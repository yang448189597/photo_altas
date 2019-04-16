import 'package:flutter/material.dart';
import 'package:photo_atlas/Home_Pages/pitcture_all.dart';
import 'package:photo_atlas/Home_Pages/pitcture_day.dart';
import 'package:photo_atlas/Home_Pages/pitcture_week.dart';

class PicturePage extends StatefulWidget {
  @override
  PicturePageState createState() => new PicturePageState();
}

// with 混入（类似多重继承？）
class PicturePageState extends State<PicturePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('美女'),
        bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.redAccent,
            indicatorWeight: 3.0,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: '日榜',),
              Tab(text: '周榜',),
              Tab(text: '月榜',)
            ]
        ),
      ),
      body: TabBarView(
          controller:_controller,
          children: <Widget>[
            DayPage(),
            WeekPage(),
            AllPage(),
          ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //vsync 垂直
    // 初始化 TabController
    _controller = TabController(length: 3, vsync: this);
  }

  // 销毁方法
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PicturePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

