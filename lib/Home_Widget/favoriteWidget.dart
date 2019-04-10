import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWidget extends StatefulWidget {
  final String pictureUrl;

  FavoriteWidget({this.pictureUrl});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = false;

  Future saveString(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pictureUrl', url);
  }

  Future removeString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pictureUrl');
  }

  Future getString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      String url = prefs.get('pictureUrl');
      if(url == null){
        url = '空';
      }
      print("shared preferences : -----------------------" + url);
    });

  }

  @override
  Widget build(BuildContext context) {

    void _toggleFavorite() {

      setState(() {
        if (_isFavorite) {
          _isFavorite = false;
          getString();
         removeString();
          Fluttertoast.showToast(
              msg: "取消收藏",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.red,
              backgroundColor: Colors.white12);
        } else {
          _isFavorite = true;
          getString();
          saveString(widget.pictureUrl);
          Fluttertoast.showToast(
              msg: "添加至收藏列表",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.red,
              backgroundColor: Colors.white12);
        }
      });
    }

    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
              onPressed: _toggleFavorite,
              icon: _isFavorite
                  ? new Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : new Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
        ),
        new Container(
          child: new Text(
            '收藏',
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
