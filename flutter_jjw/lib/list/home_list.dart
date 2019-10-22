import 'package:flutter/material.dart';
import 'package:flutter_jjw/widgets/waterfall.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
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
      body: Container(),
    );
  }
}

/* 列表代码
      body: ListView.builder(
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
      ),
*/

/* 瀑布流
JWaterfall(
        count: 16,
        item: (index) {
          return Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                JWaterfall.of(context).scrollToIndex(index);
              },
              child: Container(
                alignment: Alignment.topCenter,
                height: (index+1)*30.0,
                child: Text(
                    'XXXXXXXXXXXXXXX'
                ),
              ),
            );
          });
        },
      )
*/