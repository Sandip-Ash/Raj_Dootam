import 'package:flutter/material.dart';

import '../auth/auth_services.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void logout(){
    final authService = AuthServices();
    authService.SignOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo
              DrawerHeader(
                  child: Icon(
                    Icons.message,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  onTap: (){
                    // pop the drawer
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    // size: 35,
                  ),
                  title: Text(
                    'HOME',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      // fontSize: 30,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),

              // setting list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  onTap: (){
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage())
                    );
                  },
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    // size: 35,
                  ),
                  title: Text(
                    'SETTINGS',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      // fontSize: 30,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              onTap: logout,
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
                // size: 35,
              ),
              title: Text(
                'LOGOUT',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  // fontSize: 30,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
