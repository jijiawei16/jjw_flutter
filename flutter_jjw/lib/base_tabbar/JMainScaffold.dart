import 'package:flutter/material.dart';
import 'JMainTabbar.dart';
import 'JMainTabbarItemBean.dart';
export 'JMainAnimationTabbarItem.dart';


class JMainScaffold extends StatefulWidget {
  final int currentIndex;
  final List<JmainTabbarItemBean> items;

  JMainScaffold({Key key,
    this.currentIndex = 0,
    this.items
  });

  @override
  State<StatefulWidget> createState() {
    return JMainScaffoldState();
  }
}

class JMainScaffoldState extends State<JMainScaffold> {
  final pageController = PageController();
  List<Widget> items = List();
  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.currentIndex;
    getItemControllers();
  }

  // 获取子控制器
  void getItemControllers() {
    items = List();
    widget.items.map((bean) {
      items.add(bean.controller);
    }).toList();
  }

  // item点击事件
  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  // 滚动pageView事件
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: items,
        ),
        bottomNavigationBar: JMainTabbar(
          currentIndex: currentIndex,
          items: widget.items,
          onTap: onTap,
        ),
      ),
    );
  }
}