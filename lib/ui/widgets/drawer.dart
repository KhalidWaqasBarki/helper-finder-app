import 'package:flutter/material.dart';
import 'about-us.dart';
import 'contact-us.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
           
            child: DrawerHeader(
              child: Center(
                child: Text(
                  'Helper Finder',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: const Text(
              'Contact Us ',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => Navigator.of(context).push(contact()),
          ),
          ListTile(
            leading: Icon(Icons.arrow_upward),
            title: const Text(
              'About us ',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => Navigator.of(context).push(about()),
          ),
         
          ListTile(
            leading: Icon(Icons.file_copy),
            title: const Text(
              'Version ',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: const Text("1.0.0"),
          ),
        ],
      ),
    );
  }
}
