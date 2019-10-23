import 'package:flutter/material.dart';
import 'package:flutter_jjw/widgets/j_waterfallview.dart';
import 'package:flutter_jjw/widgets/j_switch.dart';
import 'package:flutter_jjw/widgets/j_listview.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> with AutomaticKeepAliveClientMixin {
  List<String> titles;
  List<bool> likes;

  Widget widgetForRow(int index) {
    return Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titles = ['1111111','22222222'];
    likes = [true,false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试demo'),
      ),
      body: Center(
        child: getJListView(),
      ),
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

  Widget getJWaterfallView() {
    return JWaterfallView(
      count: 16,
      item: (contexts, index) {
        return GestureDetector(
          onTap: () {
            JWaterfallView.of(contexts).scrollToIndex(index);
          },
          child: Container(
            alignment: Alignment.topCenter,
            height: (index+1)*30.0,
            child: Text(
                'XXXXXXXXXXXXXXX'
            ),
          ),
        );
      },
    );
  }

  Widget getJSwitch() {
    return JSwitch(
      selected: true,
      title: 'ON',
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
        return section+2;
      },
      row: (indexPath) {
        return Container(
          color: Colors.blue,
          height: 100.0,
          margin: EdgeInsets.only(bottom: 5.0),
        );
      },
      autoSpread: true,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
