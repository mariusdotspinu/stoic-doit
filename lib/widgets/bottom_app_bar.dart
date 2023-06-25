import 'package:flutter/material.dart';

class BottomAppBarWithItems extends StatefulWidget {
  BottomAppBarWithItems({required List<Widget> widgets}) {
    this.widgets = widgets;
  }
  late List<Widget> widgets;

  @override
  State<StatefulWidget> createState() => BottomAppBarWithItemsState(widgets);
}

class BottomAppBarWithItemsState extends State<BottomAppBarWithItems> {
  BottomAppBarWithItemsState(List<Widget> widgets) {
    this.widgets = widgets;
  }
  late List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      ),
    );
  }
}