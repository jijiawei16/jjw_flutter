import 'package:flutter/material.dart';

typedef RowItem        = Widget Function(IndexPath indexPath);
typedef RowCount       = int    Function(int section);
typedef SectionItem    = Widget Function(IndexPath indexPath);
typedef SectionSpread  = bool   Function(int section);

class JListView extends StatefulWidget {

  // 当前控件高度
  final double height;

  // 当前控件宽度
  final double width;

  // 当前row对应的item
  final RowItem row;

  // 当前section对应的row的数量
  final RowCount rowCount;

  // 当前section对应的item
  final SectionItem section;

  // List的section的数量
  final int sectionCount;

  // 当前section的展开状态(默认true)
  final SectionSpread sectionSpread;

  // section是否自动展开收起(默认false)
  final bool autoSpread;

  // 背景颜色
  final Color color;

  JListView({
    Key key,
    this.height,
    this.width,
    this.row,
    this.rowCount,
    this.section,
    this.sectionCount = 1,
    this.sectionSpread,
    this.autoSpread,
    this.color = Colors.black12,
  }):   assert(row != null, '需要通过调用row来创建item'),
        assert(rowCount != null, '需要通过rowCount来设置当前section的row的数量'),
        super(key: key);

  @override
  _JListViewState createState() => _JListViewState();
}

class _JListViewState extends State<JListView> {
  List<IndexPath> indexPaths;
  List<bool> isSpreads;
  bool autoSpread;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 设置默认不自动展开
    autoSpread = widget.autoSpread == null ? false : widget.autoSpread;

    // 初始化展开列表数组
    isSpreads = List();

    // 设置每个item对应的indexPath
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
      IndexPath sectionIndexPath = IndexPath(section: i,row: -1);
      indexPaths.add(sectionIndexPath);

      // 获取当前section是否是展开状态,如果不展开，不添加对应的rowItems
      bool isSpread = true;
      if (widget.autoSpread == true) {
        if (widget.sectionSpread == null) {
          isSpreads.add(isSpread);
        } else {
          if (isNull) {
            isSpread = widget.sectionSpread(i);
            isSpreads.add(isSpread);
          } else {
            isSpread = isSpreads[i];
          }
        }
      } else {
        if (widget.sectionSpread != null) isSpread = widget.sectionSpread(i);
      }
      if (isSpread != true) continue;

      // 获取每个section对应的row的数量
      int rows = widget.rowCount(i);

      for (int j = 0; j < rows; j++) {

        // 添加row对应的indexPath
        IndexPath rowIndexPath = IndexPath(section: i,row: j);
        indexPaths.add(rowIndexPath);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 如果没有设置宽高,会自动填满
    double height = widget.height == null ? MediaQuery.of(context).size.height : widget.height;
    double width = widget.width == null ? MediaQuery.of(context).size.width : widget.width;

    return Container(
      width: width,
      height: height,
      color: widget.color,
      child: ListView.builder(
        itemCount: indexPaths.length,
        itemBuilder: (context, index) {

          // 获取到当前item对应的indexPath
          IndexPath currentIndexPath = indexPaths[index];

          // 根据indexPath的row属性来判断section/row
          if (currentIndexPath .row == -1) {
            return GestureDetector(
              onTap: () {
                if (widget.autoSpread != true) return;
                bool currentState = isSpreads[currentIndexPath.section];
                setState(() {
                  isSpreads[currentIndexPath.section] = !currentState;
                  setUpIndexPaths();
                });
              },
              child: widget.section == null ? Container() : widget.section(currentIndexPath),
            );
          } else {
            return widget.row(currentIndexPath);
          }
        },
      ),
    );
  }
}

class IndexPath {
  int section;
  int row;

  IndexPath({
    Key key,
    this.section,
    this.row,
  });
}