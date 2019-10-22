import 'package:flutter/material.dart';
import 'JMainTabbarItem.dart';
import 'JMainTabbarItemBean.dart';

/// tabbar选中指定item回调
typedef JMainTabbarBlock(int index);

class JMainTabbar extends StatefulWidget {
  final int currentIndex;
  final JMainTabbarBlock onTap;
  final List<JmainTabbarItemBean> items;

  JMainTabbar({
    Key key,
    this.items,
    this.currentIndex = 0,
    this.onTap
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JMainTabbarState();
  }
}

class JMainTabbarState extends State<JMainTabbar> {
  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        alignment: Alignment.bottomCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
              height: 49.0,
              color: Colors.white,
              child: Row(
                children: widget.items.map( (model) {
                  int index = widget.items.indexOf(model);
                  return JMainTabbarItem(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        widget.onTap(index);
                      });
                    },
                    selected: currentIndex == index,
                    bean: widget.items[index],
                  );
                }).toList(),
              )
          )
        ],
    );
  }
}