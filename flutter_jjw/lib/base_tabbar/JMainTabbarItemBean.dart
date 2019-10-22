import 'package:flutter/material.dart';

/// 当前Item的点击回调
typedef JMainTabbarItemBlock();

/// item样式类型
enum JMainTabbarItemType {
  nomal,  //  图片加文字
  image,  //  只有图片
  boost,  // 只有图片且放大图片
  animal, //  动画效果
}

class JmainTabbarItemBean {
  final String title;
  final double titleFont;
  final Color nomalColor;
  final Color selectColor;
  final String nomalImg;
  final String selectImg;
  final JMainTabbarItemType type;
  final Widget controller;

  JmainTabbarItemBean({Key key,
    this.title,
    this.titleFont,
    this.nomalColor,
    this.selectColor,
    this.nomalImg,
    this.selectImg,
    this.type,
    this.controller,
  });
}