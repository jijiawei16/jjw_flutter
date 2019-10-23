import 'package:flutter/material.dart';
import 'base_tabbar/JMainScaffold.dart';
import 'list/home_list.dart';
import 'mine/mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainTabbar(),
    );
  }
}

class MainTabbar extends StatefulWidget {
  @override
  _MainTabbarState createState() => _MainTabbarState();
}

class _MainTabbarState extends State<MainTabbar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: JMainScaffold(
        currentIndex: 0,
        items: [
          JmainTabbarItemBean(
              nomalColor: Colors.black12,
              selectColor: Colors.blue[600],
              title: '列表',
              titleFont: 12.0,
              nomalImg: 'images/list_nomal.png',
              selectImg: 'images/list_select.png',
              controller: HomeList(),
              type: JMainTabbarItemType.animal
          ),
          JmainTabbarItemBean(
              nomalColor: Colors.black12,
              selectColor: Colors.blue[600],
              title: '我的',
              titleFont: 12.0,
              nomalImg: 'images/mine_nomal.png',
              selectImg: 'images/mine_select.png',
              controller: Mine(),
              type: JMainTabbarItemType.animal
          ),
        ],
      ),
    );
  }
}

/*
自定义tabbar ✔️
瀑布流 ✔️
tableView
switch ✔️
collection
*/