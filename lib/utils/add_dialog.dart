import 'package:flutter/material.dart';

class AddDialog {
  TextEditingController textEditingController = TextEditingController();

  Future<AlertDialog?> buildDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Task'),
          content: TextField(
            onChanged: (value) {},
            controller: textEditingController,
            decoration: InputDecoration(hintText: "Type here your new task"),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}