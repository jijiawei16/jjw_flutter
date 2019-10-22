import 'package:flutter/material.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  List<String> titles;

  Widget widgetForRow(int index) {
    return Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titles = ['1111111','22222222'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return widgetForRow(index);
      },
    );
  }
}

/*
JWaterfall(lines: 3,margin: 20.0,color: Colors.blue,height: 700.0,width: 414.0,count: 10,item: (index) {
                return Container(
                  height: (index+1)*50.0,
                  child: Text('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
                );
              },),
*/