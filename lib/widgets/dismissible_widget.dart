import 'package:ad_como/widgets/todo/todo_widget.dart';
import 'package:flutter/material.dart';

class DismissibleWidget extends StatelessWidget {
  final TodoWidget todoWidget;
  final int todoItemIndex;
  final DismissDirectionCallback dismissDirectionCallback;

  DismissibleWidget(
      {required this.dismissDirectionCallback,
      required this.todoWidget,
      required this.todoItemIndex});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(todoWidget.todoModel.id),
        onDismissed: dismissDirectionCallback,
        background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDeletePaddingColumn(),
                buildDeletePaddingColumn()
              ],
            )),
        child: todoWidget);
  }

  Padding buildDeletePaddingColumn() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.delete_sharp),
          ],
        ));
  }
}
