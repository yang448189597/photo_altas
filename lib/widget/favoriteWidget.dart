import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite= false;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _isFavorite = false;
        Fluttertoast.showToast(
            msg: "添加至收藏列表",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.orange,
            backgroundColor: Colors.white12);
      } else {
        _isFavorite = true;
        Fluttertoast.showToast(
            msg: "取消收藏",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.orange,
            backgroundColor: Colors.white12);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
              onPressed: _toggleFavorite,
              icon: _isFavorite
                  ? new Icon(Icons.favorite,color: Colors.red,)
                  : new Icon(Icons.favorite_border,color: Colors.white,)
             ),
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
