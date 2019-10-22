import 'package:flutter/material.dart';
import 'JMainTabbarItemBean.dart';
export 'JMainTabbarItemBean.dart';

class ImageItem extends StatefulWidget {

  final bool selected;
  final JmainTabbarItemBean bean;
  final JMainTabbarItemBlock onTap;

  ImageItem({Key key,
    this.selected,
    this.bean,
    this.onTap,
  }): super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                child: Image.asset(
                  widget.selected ? widget.bean.selectImg : widget.bean.nomalImg,
                  height: widget.selected ? 45.0 : 25.0,
                  width: widget.selected ? 45.0 : 25.0,
                ),
              ),
            ),
            onTap: () {
              widget.onTap();
            },
          ),
        ],
      ),
    );
  }
}