import 'package:flutter/material.dart';
import 'dart:async';

typedef JGridRowItem        = Widget Function(BuildContext context, JGridIndexPath indexPath);
typedef JGridRowCount       = int    Function(int section);
typedef JGridRowScale       = double Function(int section);
typedef JGridRowLine        = int    Function(int section);
typedef JGridSectionSpread  = bool   Function(int section);
typedef JGridSectionItem    = Widget Function(BuildContext context, int section);

class JGridView extends StatefulWidget {
  // 控件高度
  final double height;
  // 控件宽度
  final double width;
  // 设置对应的row
  final JGridRowItem row;
  // 设置当前section对应的row的个数
  final JGridRowCount rowCount;
  // 设置当前section对应的row的列数(默认 2)
  final JGridRowLine rowLine;
  // 设置当前section对应的的row的宽高比(默认 1.0)
  final JGridRowScale rowScale;
  // 设置当前section展开状态(默认 true)
  final JGridSectionSpread sectionSpread;
  // 设置当前section
  final JGridSectionItem section;
  // section个数(默认 1)
  final int sectionCount;
  // 底层颜色(默认 浅灰色)
  final Color color;
  // row之间的间距(默认 10.0)
  final double margin;
  // section是否自动展开收起(默认 false)
  final bool autoSpread;

  JGridView({
    Key key,
    this.height,
    this.width,
    this.row,
    this.rowCount,
    this.rowLine,
    this.rowScale,
    this.sectionSpread,
    this.section,
    this.sectionCount = 1,
    this.color = Colors.black12,
    this.margin = 10.0,
    this.autoSpread = false,
  }):   assert(row != null, '需要使用item来设置子widget'),
        assert(rowCount != null, '需要设置item的数量'),
        super(key: key);

  static _JGridViewState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<_JGridViewState>());
  }

  @override
  _JGridViewState createState() => _JGridViewState();
}

class _JGridViewState extends State<JGridView> {
  List<Widget> items; // 控件item数组
  double _scrollHeight = double.maxFinite; // 控件可滑动高度
  ScrollController _scrollController = ScrollController(); // 滑动控制器
  List<bool> isSpreads; // section展开状态数组
  List<JGridIndexPath> indexPaths; // item的indexpath数组

  scrollTo(double offset) {
    _scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
  scrollToIndex(int index) {
    double offset = indexPaths[index].offset;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化展开列表数组
    isSpreads = List();

    // 初始化展开列表数组
    setUpIndexPaths();
  }

  setUpIndexPaths() {

    // 初始化indexPaths数组
    indexPaths = List();

    // 获取section的数量
    int sections = widget.sectionCount;

    // 判断是否缓存了展开状态数据
    bool isNull = isSpreads.length == 0;

    for (int i = 0; i < sections; i++) {

      // 添加section对应的indexPath
      JGridIndexPath sectionIndexPath = JGridIndexPath(section: i,row: -1);
      indexPaths.add(sectionIndexPath);

      // 获取当前section是否是展开状态,如果不展开，不添加对应的rowItems
      bool isSpread = widget.sectionSpread == null ? true : widget.sectionSpread(i);
      if (widget.autoSpread == true) isNull ? isSpreads.add(isSpread) : isSpread = isSpreads[i];
      if (isSpread != true) continue;

      // 获取每个section对应的row的数量
      int rows = widget.rowCount(i);

      for (int j = 0; j < rows; j++) {

        // 添加row对应的indexPath
        JGridIndexPath rowIndexPath = JGridIndexPath(section: i,row: j);
        indexPaths.add(rowIndexPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    // 如果没有设置宽高,会自动填满
    double height = widget.height == null ? MediaQuery.of(context).size.height : widget.height;
    double width = widget.width == null ? MediaQuery.of(context).size.width : widget.width;

    items = List();
    for (int i = 0; i< indexPaths.length; i++) {
      JGridIndexPath indexPath = indexPaths[i];
      if (indexPath.row == -1) { // 当前是section
        items.add(Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (widget.autoSpread != true) return;
                bool currentState = isSpreads[indexPath.section];
                setState(() {
                  isSpreads[indexPath.section] = !currentState;
                  setUpIndexPaths();
                });
              },
              child: widget.section(context, indexPath.section),
            );
          },
        ));
      }else { // 当前是row
        items.add(Builder(
          builder: (context) {
            int line = widget.rowLine == null ? 2 : widget.rowLine(indexPath.section);
            double itemWidth = (width-widget.margin*(line+1))/line;
            double scale = widget.rowScale == null ? 1.0 : widget.rowScale(indexPath.section);
            return SizedBox(
              height: itemWidth*scale,
              width: itemWidth,
              child: widget.row(context, indexPath),
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
            delegate: JGridViewDelegate(
              width: width,
              state: this,
              margin: widget.margin,
            ),
            children: items,
          ),
        ),
      ),
    );
  }
}

class JGridViewDelegate extends FlowDelegate {

  double width;
  _JGridViewState state;
  double margin;

  JGridViewDelegate({
    Key key,
    this.width,
    this.state,
    this.margin
  });

  @override
  void paintChildren(FlowPaintingContext context) {

    int count = context.childCount;
    // 初始化每个item对应的offset
    List<double> offsets = List<double>.filled(count, 0.0, growable: true);
    List<JGridIndexPath> indexPaths = state.indexPaths;
    double top = 0.0;
    double left = margin;
    double lastItemHeight = 0.0;

    for (int i = 0; i < count; i++) {
      Size size = context.getChildSize(i);
      print(size);
      JGridIndexPath indexPath = indexPaths[i];
      if (indexPath.row == -1) { // 当前是section
        top += lastItemHeight;
        lastItemHeight = 0.0;
        // 绘制
        context.paintChild(i,
            transform: new Matrix4.translationValues(0 , top, 0.0)
        );
        double itemHeight = context.getChildSize(i).height;
        top += itemHeight + margin;
        left = margin;
      }else { // 当前是row
        double itemHeight = context.getChildSize(i).height;
        double itemWidth = context.getChildSize(i).width;
        if (left + itemWidth > width) {
          left = margin;
          top += itemHeight + margin;
        }
        // 绘制
        context.paintChild(i,
            transform: new Matrix4.translationValues(left , top, 0.0)
        );
        left += itemWidth + margin;
        if (i == count-1) {
          top += itemHeight + margin;
        }
        lastItemHeight = itemHeight + margin;
      }
    }

    // 通过最大高度判断是否需要重新刷新可滚动高度
    if (state._scrollHeight != top) {
      state._scrollHeight = top;
      Timer timer = new Timer(new Duration(milliseconds: 10), () {
        // 只在倒计时结束时回调
        state.updateUI();
      });
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

class JGridIndexPath {
  int section;
  int row;
  double offset;

  JGridIndexPath({
    Key key,
    this.section,
    this.row,
    this.offset,
  });
}