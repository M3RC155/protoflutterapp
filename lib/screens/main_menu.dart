import 'package:flutter/material.dart';
import 'package:proto_app/widgets/app_drawer.dart';


class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Main Menu',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
  
}