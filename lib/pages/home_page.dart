// import 'package:flutter/material.dart';

// class HomePage {

// }
import 'package:flutter/material.dart';
import 'package:gm/components/bottom_nav_bar.dart';
import 'package:gm/pages/main_page.dart';
import 'package:gm/pages/rdv_patient_page_.dart';

import 'article/article_page.dart';
import 'help_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//selected index to control navbar
  int _selectedIndex = 0;

// method to update the selected index
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //page to display
  final List<Widget> _pages = [
    //doctor page
    //const DoctorPage(),
    const MainPage(),
    //rdv page
    const RDVPaientPage(),
    //help page
    const HelpPage(),
    //Article Page
    ArticlePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.green[300],
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.grey.shade100,
          child: Column(
            children: [
              // Logo
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                ),
              ),

              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Divider(
              //     color: Color.fromARGB(255, 15, 28, 63),
              //   ),
              // ),
              const SizedBox(height: 48),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 15, 28, 63),
                  ),
                  title: Text(
                    'H O M E',
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 28, 63),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 58),

              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    color: Color.fromARGB(255, 15, 28, 63),
                  ),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 28, 63),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 58),

              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 15, 28, 63),
                  ),
                  title: Text(
                    'S I G N   O U T',
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 28, 63),
                    ),
                  ),
                ),
              )
            ],
          )),
      body: _pages[_selectedIndex],
    );
  }
}
