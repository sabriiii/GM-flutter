import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        //activeColor: Colors.grey.shade700,
        activeColor: Colors.green[300],
        //tabActiveBorder: Border.all(color: Colors.white),
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.calendar_month_rounded,
            text: 'RDV',
          ),
          GButton(
            icon: Icons.help_rounded,
            text: 'Help',
          ),
          GButton(
            icon: Icons.newspaper_rounded,
            text: 'Articles',
          ),
        ],
      ),
    );
  }
}
