import 'package:flutter/material.dart';
import 'JMainTabbarItemBean.dart';
export 'JMainTabbarItemBean.dart';

class AnimationItem extends StatefulWidget {
  final bool selected;
  final JmainTabbarItemBean bean;
  final JMainTabbarItemBlock onTap;

  AnimationItem({Key key,
    this.selected,
    this.bean,
    this.onTap,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationItemState();
}

class _AnimationItemState extends State<AnimationItem> with TickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _controller;
  double scale;
  bool animaltion;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scale = 0.0;
    animaltion = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.selected == true) {
      if (animaltion == false) {
        animaltion = true;
        selectAnimation();
      }
    }else {
      scale = 0.0;
      animaltion = false;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          height: 49.0,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: -26.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: ClipPath(
                  clipper: BottomClipper(topSpace: 26.0,scale: scale),
                  child: Container(
                    color: Colors.white,
                    height: 75.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                height: 49.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  child: Center(
                    child: showItem(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 选中时的动画效果
  selectAnimation() {
    // 外部曲线动画
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _animation = new Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          scale = _animation.value;
        });
      });
    _controller.forward();
  }

  // 根据是否选中来展示当前item动画样式
  Widget showItem() {
    if (widget.selected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            widget.bean.selectImg,
            height: 24.0,
            width: 24.0,
          ),
          SizedBox(height: 5.0*scale,),
          Text(
            widget.bean.title,
            style: TextStyle(
              fontSize: widget.bean.titleFont,
              color: widget.bean.selectColor,
            ),
          )
        ],
      );
    } else {
      return Image.asset(
        widget.bean.nomalImg,
        height: 24.0,
        width: 24.0,
      );
    }
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// 不规则裁剪
class BottomClipper extends CustomClipper<Path>{
  double topSpace;
  double scale;
  double firstNum = 0.05;
  double secondNum = 0.15;
  double thirdNum = 0.17;

  BottomClipper({Key key,
    this.topSpace,
    this.scale,
  });

  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, topSpace); //第1个点
    path.lineTo(size.width*firstNum, topSpace); //第2个点

    var firstControlPoint = Offset(size.width*secondNum, topSpace-scale*2.0);
    var firstEdnPoint = Offset(size.width*thirdNum, topSpace-scale*5.0);
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy
    );

    var thirdControlPoint = Offset(size.width/2, (1-scale*1.3)*topSpace);
    var thirdEdnPoint = Offset(size.width*(1-thirdNum), topSpace-scale*5.0);
    path.quadraticBezierTo(
        thirdControlPoint.dx,
        thirdControlPoint.dy,
        thirdEdnPoint.dx,
        thirdEdnPoint.dy
    );

    var fourControlPoint = Offset(size.width*(1-secondNum), topSpace-scale*2.0);
    var fourEdnPoint = Offset(size.width*(1-firstNum), topSpace);
    path.quadraticBezierTo(
        fourControlPoint.dx,
        fourControlPoint.dy,
        fourEdnPoint.dx,
        fourEdnPoint.dy
    );
    path.lineTo(size.width, topSpace); //第3个点
    path.lineTo(size.width, size.height); //第4个点
    path.lineTo(0, size.height); //第5个点
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
