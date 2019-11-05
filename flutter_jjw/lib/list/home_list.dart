import 'package:flutter/material.dart';
import 'package:flutter_jjw/widgets/j_waterfallview.dart';
import 'package:flutter_jjw/widgets/j_switch.dart';
import 'package:flutter_jjw/widgets/j_listview.dart';
import 'package:flutter_jjw/widgets/j_gridview.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> with AutomaticKeepAliveClientMixin {
  List<String> titles;
  List<bool> likes;
  bool select = false;
  List<String> urls = [
    "http://cdn2.jianshu.io/assets/default_avatar/2-9636b13945b9ccf345bc98d0d81074eb.jpg",
    "https://cdn2.jianshu.io/assets/default_avatar/10-e691107df16746d4a9f3fe9496fd1848.jpg",
    "https://upload-images.jianshu.io/upload_images/3734843-8fee84933a1497f5.gif?imageMogr2/auto-orient/strip|imageView2/2/w/337",
  ];
  List<String> titles1 = [
    'ssssssssssssssssssssssssssssssssssssssssssssss',
    'ddddddddddddddddddddddddddddddd',
    'ffffffffffffffffffffffffffffffffffffffffffffffffff',
    'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr',
    'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
  ];
  List<double> heights1 = [
    50.0,
    40.0,
    60.0,
    65.0,
    100.0,
  ];

  List<String> titles2 = [
    'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS',
    'DDDDDDDDDDDDDDDDDDD',
    'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF',
    'RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR',
    'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW'
  ];
  List<double> heights2 = [
    80.0,
    30.0,
    100.0,
    65.0,
    75.0,
  ];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titles = ['1111111','22222222'];
    likes = [true,false];
    getClipboardDatas();
    textEditingController.addListener(() {
      if (textEditingController.text.length > 0) {
        try {
          int.parse(textEditingController.text);
        }catch (error) {
          textEditingController.clear();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试demo'),
      ),
      body: Center(
        child: TextField(
          controller: textEditingController,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        print('进入了后台');
        break;
      case AppLifecycleState.resumed:

        break;
      case AppLifecycleState.suspending:
        break;
    }
  }

  getClipboardDatas() async {
    var str = await Clipboard.getData('text/plain');
    int num;
    try {
      num = int.parse(str.text);
    }catch (error) {
      Clipboard.setData(ClipboardData(text: ''));
    }
    print(num.toString());
  }


  Widget getJGridView() {
    return JGridView(
      width: 400.0,
      sectionCount: 3,
      sectionSpread: (section) {
        return true;
      },
      section: (context, section) {
        return Container(
          color: Colors.blueGrey,
          alignment: Alignment.topCenter,
          height: 100.0,
          width: 400.0,
          child: Text(
            select ? titles1[section] : titles2[section],
          ),
        );
      },
      rowCount: (section) {
        return section+5;
      },
      rowLine: (section) {
        return section+1;
      },
      rowScale: (section) {
        return section+1.0;
      },
      row: (context, indexpath) {
        return Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: Text('row'),
        );
      },
      autoSpread: true,
    );
  }

  Widget getJWaterfallView() {
    return JWaterfallView(
      count: select ? titles1.length : titles2.length,
      item: (contexts, index) {
        return GestureDetector(
          onTap: () {
//            JWaterfallView.of(contexts).scrollToIndex(index);
          setState(() {
            select = !select;
          });
          },
          child: Container(
            color: Colors.blueGrey,
            alignment: Alignment.topCenter,
            height: select ? heights1[index] : heights2[index],
            child: Text(
              select ? titles1[index] : titles2[index],
            ),
          ),
        );
      },
    );
  }

  Widget getJSwitch() {
    return JSwitch(
      width: 75.0,
      height: 30.0,
      selected: true,
      openTitle: 'ON',
      closeTitle: 'Flase',
      onChange: (select) {
        print(select);
      },
    );
  }

  Widget getJListView() {
    return  JListView(
      sectionCount: 3,
      sectionSpread: (index) {
        return true;
      },
      section: (indexPath) {
        return Container(
          color: Colors.orange,
          height: 50.0,
        );
      },
      rowCount: (section) {
        return urls.length;
      },
      row: (indexPath) {
        return Column(
          children: <Widget>[
            Image.network(urls[indexPath.row]),
            Container(
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '标题标题标题',
                    maxLines: 5,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.do_not_disturb),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '用户用户用户用户用户用户',
                            maxLines: 5,
                          ),
                        ),
                        Icon(Icons.no_encryption),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      autoSpread: true,
    );
  }

  Widget getListView() {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15.0,top: 15.0,right: 15.0),
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  titles[index],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  likes[index] ? 'images/like_select.png' : 'images/like_nomal.png',
                  height: 30.0,
                  width: 30.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

