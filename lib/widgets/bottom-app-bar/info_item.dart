import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  InfoItem(GestureTapCallback gestureTapCallback) {
    this.gestureTapCallback = gestureTapCallback;
  }
  late GestureTapCallback gestureTapCallback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: gestureTapCallback,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.info, size: 26),
                Text("About")
              ],
            ),
          ),
        ),
      ),
    );
  }

}