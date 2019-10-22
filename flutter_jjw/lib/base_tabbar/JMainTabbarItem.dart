import 'package:flutter/material.dart';
import 'JMainAnimationTabbarItem.dart';
import 'JMainNomalTabbarItem.dart';
import 'JMainImageTabbarItem.dart';
import 'JMainBoostTabbarItem.dart';

class JMainTabbarItem extends StatelessWidget {
  final bool selected;
  final JMainTabbarItemBlock onTap;
  final JmainTabbarItemBean bean;

  JMainTabbarItem({Key key,
    this.onTap,
    this.selected,
    this.bean,
  });

  getItem() {

    // 根据传进的type展示对应的item
    switch (bean.type) {

      // 放大图片样式
      case JMainTabbarItemType.boost:
        return BoostItem(
          selected: selected,
          bean: bean,
          onTap: () {
            onTap();
          },
        );

      // 普通样式
      case JMainTabbarItemType.nomal:
        return NomalItem(
          selected: selected,
          bean: bean,
          onTap: () {
            onTap();
          },
        );

      // 只有图片样式
      case JMainTabbarItemType.image:
        return ImageItem(
          selected: selected,
          bean: bean,
          onTap: () {
            onTap();
          },
        );

      // 动画样式
      case JMainTabbarItemType.animal:
        return AnimationItem(
          selected: selected,
          bean: bean,
          onTap: () {
            onTap();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getItem();
  }
}


