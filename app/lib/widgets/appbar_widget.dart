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
      // leading: IconButton(
      //   onPressed: (){},
      //   icon: Image.asset("./SnapIcon.png")
      // ),

        leading:  Navigator.canPop(context)
        ? null // If can pop, let Flutter handle the back button
        : IconButton(
            // If cannot pop, show your logo
            onPressed: () {
              // Action when logo is pressed (if any)
            },
            icon: Image.asset(
                "./SnapIcon.png"), // Replace with your logo's asset path
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
