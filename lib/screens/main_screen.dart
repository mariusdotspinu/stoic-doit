import 'package:ad_como/utils/add_dialog.dart';
import 'package:ad_como/widgets/todo_item.dart';
import 'package:flutter/material.dart';

import '../utils/quote_utils.dart';
import 'package:ad_como/widgets/quote_widget.dart';

import '../widgets/drawer.dart';

class Primary extends StatelessWidget {
  late Future<Quote> quote;

  Primary({required Future<Quote> quote}) {
    this.quote = quote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: buildAppBar(),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          AddDialog().buildDialog(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            QuoteWidget(quote: quote).build(context),
            Expanded(
                child: ListView(
              children: [
                Todo(),
              ],
            ))
          ])),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white10,
  );
}
