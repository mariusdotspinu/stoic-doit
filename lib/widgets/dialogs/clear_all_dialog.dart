import 'package:ad_como/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:ad_como/shared_preferences/preferences.dart';

class ClearAllDialog extends StatelessWidget {
  ClearAllDialog(MainState mainState) {
    this.mainState = mainState;
  }

  late MainState mainState;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: const Text('Delete all items?'),
      actions: SharedPreferencesUtils.isAtLeastOneChecked() == true
          ? [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  mainState.clearAll();
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  mainState.clearFinishedItems();
                  Navigator.pop(context);
                },
                child: const Text('Delete just finished items'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ]
          : [
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
