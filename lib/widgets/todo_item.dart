import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: Icon(Icons.check_box, color: Colors.lightBlueAccent),
        title: Text("Check somth", style: TextStyle(fontSize: 15, decoration: TextDecoration.lineThrough)),
      )
    );
  }

}