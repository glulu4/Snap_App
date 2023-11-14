import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo[200],
      elevation: 4.0,
      title: Text('Snap, The Productivity App'),
      leading: IconButton(
        onPressed: (){},
        icon: Image.asset("./SnapIcon.png")
      ),
      actions: [
        IconButton(
          onPressed: () {

          }, icon: Icon(
            Icons.menu,
          ),
        ), 
        IconButton(
          onPressed: () {

          },
          icon: Icon(
            Icons.wine_bar

          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.access_time_filled_rounded),
        ),
        // Add any actions you need here
      ],
    );
  }
}
