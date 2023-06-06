import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/ui/NavBar.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
  }) : super(
            backgroundColor: Colors.purpleAccent,
            elevation: 5.0,
            leading: IconButton(
              onPressed: () {
                NavBar();
              },
              icon: Icon(Icons.menu),
              color: Colors.black,
            ));
}
