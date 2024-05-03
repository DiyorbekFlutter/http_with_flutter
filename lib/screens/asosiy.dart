import 'package:d_navigation_bar/d_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'found_data.dart';
import 'home.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  static final List<Widget> _pages =  [const Home(), const Center(child: Text('Saved')), const Center(child: Text('Searching')), const Center(child: Text('Call center')), const Center(child: Text('Profile'))];
  static final DNavigationBarController _dNavigationBarController = DNavigationBarController(pages: _pages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _dNavigationBarController.page,
      drawer: const Drawer(
        shape: RoundedRectangleBorder(),
        child: Center(child: Text('Hello drawer')),
      ),
      bottomNavigationBar: DNavigationBar(
        onChanged: (index) => setState(() {}),
        controller: _dNavigationBarController,
        items: [
          DNavigationBarItem(
            label: 'Asosiy',
            icon: SvgPicture.asset('assets/icons/home_border.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/icons/home.svg', width: 20, height: 20),
          ),
          DNavigationBarItem(
            label: 'Saqlangan',
            icon: SvgPicture.asset('assets/icons/bookmark_border.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/icons/bookmark.svg', width: 20, height: 20),
          ),
          DNavigationBarItem(
            label: 'Qidirish',
            icon: SvgPicture.asset('assets/icons/search_border.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/icons/search.svg', width: 20, height: 20),
          ),
          DNavigationBarItem(
            label: 'Call center',
            icon: SvgPicture.asset('assets/icons/call_center_border.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/icons/call_center.svg', width: 20, height: 20),
          ),
          DNavigationBarItem(
            label: 'Profil',
            icon: SvgPicture.asset('assets/icons/person_border.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/icons/person.svg', width: 20, height: 20),
          )
        ],
      ),
    );
  }
}
