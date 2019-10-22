import 'package:flutter/material.dart';
import 'JMainTabbarItemBean.dart';
export 'JMainTabbarItemBean.dart';

class NomalItem extends StatefulWidget {

  final bool selected;
  final JmainTabbarItemBean bean;
  final JMainTabbarItemBlock onTap;

  NomalItem({Key key,
  this.selected,
  this.bean,
  this.onTap,
  }): super(key: key);

  @override
  _NomalItemState createState() => _NomalItemState();
}

class _NomalItemState extends State<NomalItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 3.0),
                    child: Image.asset(
                      widget.selected ? widget.bean.selectImg : widget.bean.nomalImg,
                      height: 25.0,
                      width: 25.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 0.0,top: 0.0),
                    alignment: Alignment.center,
                    child: Text(
                      widget.bean.title,
                      style: TextStyle(
                        color: widget.selected ? widget.bean.selectColor : widget.bean.nomalColor,
                        fontSize: widget.bean.titleFont,
                      ),
                    ),
                  )
                ],
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
