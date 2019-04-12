import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_atlas/Model/Favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWidget extends StatefulWidget {
//  final String pictureUrl;
//  final String pictureTittle;
  final Favorite favorite;

  FavoriteWidget({this.favorite});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = false;

  List<String> _urlList = new List();

  Future saveString(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('pictureUrl', list);
    print(list);
    return;
  }

  Future<List<String>> getStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String> listUrl = prefs.getStringList("pictureUrl");
      print('listurl' + listUrl.toString());
      return listUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    print("shared preferences : -----------------------" + 'init');

    getStringList().then((List<String> list) {
      setState(() {
        _urlList = list == null ? [] : list;
        _isFavorite = _urlList.contains(widget.favorite.toJson().toString());
        print('json:'+widget.favorite.toJson().toString());
        print(_isFavorite);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void _toggleFavorite() {
      setState(() {
        if (_isFavorite) {
          _isFavorite = false;

          _urlList.remove(widget.favorite.toJson().toString());
          print(_urlList);
          print(_urlList.length.toString());

          saveString(_urlList);

          Fluttertoast.showToast(
              msg: "取消收藏",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.red,
              backgroundColor: Colors.white12);
        } else {
          _isFavorite = true;

          _urlList.add(widget.favorite.toJson().toString());
          print(_urlList);
          print(_urlList.length.toString());

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
