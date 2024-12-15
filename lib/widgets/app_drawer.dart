import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<MenuItem> menuItems = [
    MenuItem('/todolist', 'TODO list'), 
    MenuItem('/calculator', 'Calculator'), 
    MenuItem('/settings', 'Settings'), 
  ];

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView.builder(
        restorationId: 'ListViewPage',
        itemCount: menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = menuItems[index];
          return ListTile(
            title: Text(item.itemName),
            leading: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                item.routeName,
              );
            }
          );
        },
      ),
    );
  }
}