import 'package:flutter/cupertino.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: const Text("© Marius Spînu\n",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: 'Quote', fontSize: 20),)),
            Align(
                alignment: Alignment.topLeft,
                child: Linkify(
                  textAlign: TextAlign.start,
                  onOpen: (link) async {
                    if (await canLaunchUrl(Uri.parse(link.url))) {
                      await launchUrl(Uri.parse(link.url));
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: "Developer's homepage: https://sikbyte.com", style: TextStyle(fontFamily: 'Quote', fontSize: 20),))
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),)
      ],
    );
  }
}
