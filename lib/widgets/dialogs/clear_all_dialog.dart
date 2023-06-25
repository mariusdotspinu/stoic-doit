import 'package:ad_como/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';

class ClearAllDialog extends StatelessWidget {
  ClearAllDialog(MainState mainState) {
    this.mainState = mainState;
  }
  late MainState mainState;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: const Text('Delete all items?'),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            mainState.clearAll();
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

}