import 'package:flutter/material.dart';

import '../../screens/main_screen.dart';

class AddItem extends StatelessWidget {
  late MainState mainState;

  AddItem(MainState mainState) {
    this.mainState = mainState;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => mainState.addItem(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add_box_rounded, size: 26),
                Text("Task")
              ],
            ),
          ),
        ),
      ),
    );
  }
}