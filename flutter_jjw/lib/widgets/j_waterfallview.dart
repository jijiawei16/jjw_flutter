import 'package:flutter/material.dart';
import 'dart:async';

typedef Item = Widget Function(BuildContext context, int index);

class JWaterfallView extends StatefulWidget {
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

  JWaterfallView({
    Key key,
    this.margin = 10.0,
    this.height,
    this.width,
    this.item,
    this.count,
    this.lines = 2,
    this.color = Colors.black12,
  }):   assert(item != null, '需要使用item来设置子widget'),
        assert(count != null, '需要设置item的数量'),
        super(key: key);

  static _JWaterfallViewState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<_JWaterfallViewState>());
  }

  @override
  _JWaterfallViewState createState() => _JWaterfallViewState();
}

class _JWaterfallViewState extends State<JWaterfallView> {
  List<Widget> items;
  double _scrollHeight = 0.0;
  double itemWidth;
  List<double> offsets = List();
  ScrollController _scrollController = ScrollController();

  scrollTo(double offset) {
    _scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  scrollToIndex(int index) {
    double offset = offsets[index];
    _scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void updateUI() {
    // mounted 为 true 表示当前页面挂在到构件树中，为 false 时未挂载当前页面
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    // 如果没有设置宽高,会自动填满
    double height = widget.height == null ? MediaQuery.of(context).size.height : widget.height;
    double width = widget.width == null ? MediaQuery.of(context).size.width : widget.width;
    itemWidth = (width-widget.margin*(widget.lines+1))/widget.lines;

    // 只初始化一次
    if (items == null) {
      items = List();
      for (int i = 0; i< widget.count; i++) {
        items.add(Builder(
          builder: (context) {
            return SizedBox(
              width: itemWidth,
              child: widget.item(context, i),
            );
          },
        ));
      }
    }

    return Container(
      height: height,
      width: width,
      color: widget.color,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: _scrollHeight,
          width: width,
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
  _JWaterfallViewState state;
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

  double getMaxHeight(List<double> heights) {
    double maxHeight = 0;
    for (int i=0; i< heights.length; i++) {
      if (maxHeight < heights[i]) {
        maxHeight = heights[i];
      }
    }
    return maxHeight;
  }

  @override
  void paintChildren(FlowPaintingContext context) {

    int count = context.childCount;
    // 初始化每列高度数组
    heights = List<double>.filled(lines, margin, growable: true);
    // 初始化每个item对应的offset
    List<double> offsets = List<double>.filled(count, 0.0, growable: true);

    for (int i = 0; i < count; i++) {
      // 获取最低列对应的index
      int index = getCurrentIndex(heights);
      // 绘制
      context.paintChild(i,
          transform: new Matrix4.translationValues(index*(width+margin)+margin, heights[index], 0.0)
      );
      // 修改高度
      offsets[i] = heights[index];
      double currentHeight = context.getChildSize(i).height + margin;
      heights[index] += currentHeight;
    }

    // 通过最大高度判断是否需要重新刷新可滚动高度
    double maxHeight = getMaxHeight(heights);
    if (state._scrollHeight != maxHeight) {
        state._scrollHeight = maxHeight;
        Timer timer = new Timer(new Duration(milliseconds: 10), () {
          // 只在倒计时结束时回调
          state.updateUI();
        });
    }
    state.offsets = offsets;
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
