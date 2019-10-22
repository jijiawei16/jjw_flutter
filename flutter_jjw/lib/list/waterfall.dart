import 'package:flutter/material.dart';

typedef Item = Widget Function(int index);

class JWaterfall extends StatefulWidget {
  // item之间的间距
  final double margin;
  // 控件高度
  final double height;
  // 控件宽度
  final double width;
  // 设置对应的item
  final Item item;
  // item数量
  final int count;
  // 列数
  final int lines;
  // 底层颜色
  final Color color;

  JWaterfall({
    Key key,
    this.margin = 10.0,
    this.height,
    this.width,
    this.item,
    this.count,
    this.lines = 2,
    this.color = Colors.black12,
  }):   assert(height != null, '需要设置控件高度'),
        assert(height != null, '需要设置控件宽度'),
        assert(item != null, '需要使用item来设置子widget'),
        assert(count != null, '需要设置item的数量'),
        super(key: key);

  @override
  _JWaterfallState createState() => _JWaterfallState();
}

class _JWaterfallState extends State<JWaterfall> {
  List<Widget> items;
  double _scrollHeight;
  double itemWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollHeight = 800.0;
    itemWidth = (widget.width-widget.margin*(widget.lines+1))/widget.lines;
    // 设置item数组
    items = List();
    for (int i = 0; i< widget.count; i++) {
      items.add(SizedBox(
        width: itemWidth,
        child: widget.item(i),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      color: widget.color,
      child: SingleChildScrollView(
        child: Container(
          height: _scrollHeight,
          width: widget.width,
          alignment: Alignment.topCenter,
          child: Flow(
            delegate: JWaterfallDelegate(
              width: itemWidth,
              margin: widget.margin,
              lines: widget.lines,
              state: this,
            ),
            children: items,
          ),
        ),
      ),
    );
  }
}

class JWaterfallDelegate extends FlowDelegate {

  double width;
  double margin;
  int lines;
  _JWaterfallState state;
  List<double> heights;

  JWaterfallDelegate({
    Key key,
    this.width,
    this.margin = 10.0,
    this.lines = 2,
    this.state,
  });

  int getCurrentIndex(List<double> heights) {
    double minHeight = double.maxFinite;
    int index = 0;
    for (int i=0; i< heights.length; i++) {
      if (minHeight > heights[i]) {
        minHeight = heights[i];
        index = i;
      }
    }
    return index;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    heights = List<double>.filled(lines, 0.0, growable: true);

    for (int i = 0; i < context.childCount; i++) {
      int index = getCurrentIndex(heights);
      context.paintChild(i,
          transform: new Matrix4.translationValues(index*(width+margin)+margin, heights[index]+margin, 0.0)
      );
      heights[index] += context.getChildSize(i).height + 10.0;
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return super.getSize(constraints);
  }
}
