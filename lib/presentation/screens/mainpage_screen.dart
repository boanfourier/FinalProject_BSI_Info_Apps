import 'package:bsi_info_apps/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bsi_info_apps/presentation/screens/notes_screen.dart';
import 'package:bsi_info_apps/presentation/screens/events_screen.dart';
import 'package:bsi_info_apps/presentation/screens/homepage_screen.dart';
import 'package:bsi_info_apps/presentation/screens/tasks_screen.dart'; // Import halaman profil
import 'package:bsi_info_apps/presentation/theme/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    NotesPage(),
    EventsPage(),
    TasksPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget customBottomNavbar() {
      return BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: currentIndex,
        onTap: onTabTapped, // Panggil fungsi onTabTapped saat item ditekan
        selectedLabelStyle: orangeTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: greyTextStyle.copyWith(
          fontSize: 10,
          fontWeight: medium,
        ),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ic_home.png',
              width: 24,
              color: currentIndex == 0 ? Colors.lightBlueAccent : greyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ic_ticket.png',
              width: 24,
              color: currentIndex == 1 ? Colors.lightBlueAccent : greyColor,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ic_favorite.png',
              width: 24,
              color: currentIndex == 2 ? Colors.lightBlueAccent : greyColor,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ic_ticket.png',
              width: 24,
              color: currentIndex == 3 ? Colors.lightBlueAccent : greyColor,
            ),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ic_profile.png',
              width: 24,
              color: currentIndex == 4 ? Colors.lightBlueAccent : greyColor,
            ),
            label: 'Profile',
          ),
        ],
      );
    }

    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: customBottomNavbar(),
    );
  }
}
