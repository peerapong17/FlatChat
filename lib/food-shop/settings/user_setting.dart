import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';

class UserSetting extends StatefulWidget {
  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  bool isDarkTheme = false;

  bool isThaiLanguage = false;

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map((e) {
                if (e.isLoggedIn != null) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedOut: true,
                  );
                }
                return DrawerList(
                  icon: e.icon,
                  title: e.title,
                  page: e.page,
                );
              })
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your settings',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  "Dark Theme",
                  "Change to dark themem to protect your eye",
                  isDarkTheme,
                  (value) {
                    setState(
                      () {
                        isDarkTheme = value;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                    "Thai Language", "Change to thai language", isThaiLanguage,
                    (value) {
                  setState(() {
                    isThaiLanguage = value;
                  });
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
