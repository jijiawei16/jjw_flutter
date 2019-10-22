import 'package:flutter/material.dart';
import 'JMainTabbarItemBean.dart';
export 'JMainTabbarItemBean.dart';

class BoostItem extends StatefulWidget {

  final bool selected;
  final JmainTabbarItemBean bean;
  final JMainTabbarItemBlock onTap;

  BoostItem({Key key,
    this.selected,
    this.bean,
    this.onTap,
  }): super(key: key);

  @override
  _BoostItemState createState() => _BoostItemState();
}

class _BoostItemState extends State<BoostItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned.fill(
              top: -20.0,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Image.asset(
                    widget.selected ? widget.bean.selectImg : widget.bean.nomalImg,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                onTap: () {
                  widget.onTap();
                },
              )
          ),
        ],
      ),
    );
  }
}
