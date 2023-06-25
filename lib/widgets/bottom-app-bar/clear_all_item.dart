import 'package:ad_como/screens/main_screen.dart';
import 'package:ad_como/widgets/dialogs/clear_all_dialog.dart';
import 'package:flutter/material.dart';

class ClearAllItem extends StatelessWidget {
  ClearAllItem(MainState mainState) {
    this.mainState = mainState;
  }
  late MainState mainState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: (() => {
              mainState.todoItems.length > 0 ? (
            showDialog<String>(
            context: context,
            builder: (BuildContext context) => ClearAllDialog(mainState))) : null
            }),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.delete_rounded, color: Colors.red.shade800, size: 26),
                Text("Clear")
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}