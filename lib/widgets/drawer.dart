import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildMenuItems(context)
              ],
            )
        )
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 15,
          children: [
            // ListTile(
            //   leading: const Checkbox(value: value, onChanged: onChanged),
            //   title: const Text('Home'),
            //   onTap: () {},
            // ),
            const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('About'),
              onTap: () {},
            )
          ],
        ),
    );
  }
}