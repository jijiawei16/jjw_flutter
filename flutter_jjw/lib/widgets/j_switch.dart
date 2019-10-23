import 'package:flutter/material.dart';

typedef OnChange = Function(bool selected);

class JSwitch extends StatefulWidget {

  // 宽度(100.0)
  final double width;

  // 高度(默认50.0)
  final double height;

  // 状态改变回调
  final OnChange onChange;

  // 选中状态(默认false)
  final bool selected;

  // 选中颜色(默认绿色)
  final Color selectColor;

  // 未选中颜色(默认浅灰色)
  final Color nomalColor;

  // 选中文字(默认没有)
  final String title;

  JSwitch({
    Key key,
    this.width = 90.0,
    this.height = 40.0,
    this.selected = false,
    this.selectColor = Colors.green,
    this.nomalColor = Colors.black26,
    this.title,
    this.onChange,
  }): super(key: key);

  @override
  _JSwitchState createState() => _JSwitchState();
}

class _JSwitchState extends State<JSwitch> with TickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _controller;
  double padding;
  bool selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    padding = widget.selected ? widget.width-widget.height + 2.0 : 2.0;
    selected = widget.selected;
  }

  // 选中时的动画效果
  selectAnimation(bool select) {
    double begin = 2.0;
    double end = widget.width-widget.height + 2.0;
    if (select == false) {
      begin = widget.width-widget.height + 2.0;
      end = 2.0;
    }
    // 外部曲线动画
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _animation = new Tween(begin: begin, end: end).animate(_controller)
      ..addListener(() {
        setState(() {
          padding = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selected = !selected;
        selectAnimation(selected);
        if (widget.onChange != null) widget.onChange(selected);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: selected ? widget.selectColor : widget.nomalColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.height/2)),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 2.0,
              top: 2.0,
              child: selected ? Container(
                width: widget.width-widget.height-2.0,
                height: widget.height-4,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.title == null ? '' : widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ) : Container(),
            ),
            Positioned(
              left: padding,
              top: 2.0,
              child: Container(
                height: widget.height-4,
                width: widget.height-4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular((widget.height-4.0)/2)),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
