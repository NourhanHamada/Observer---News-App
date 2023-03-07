import 'package:flutter/material.dart';
import 'package:observer/constants/colors.dart';
import 'package:observer/constants/images.dart';
import 'package:observer/view/screens/home_screen.dart';
import '../screens/bookmark_screen.dart';
import '../screens/explore_screen.dart';

class LayOut extends StatefulWidget {
  const LayOut({Key? key}) : super(key: key);

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  var _selectedIndex = 0;
  List pages = [
    HomeScreen(),
    ExploreScreen(),
    BookmarkScreen(),
  ];

  _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image(image: AssetImage(homeDisable),
              ),
            activeIcon: Image(image: AssetImage(homeActive),
            ),
            label: ''
          ),
          BottomNavigationBarItem(
              icon: Image(image: AssetImage(exploreDisable),
              ),
              activeIcon: Image(image: AssetImage(exploreActive),
              ),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Image(image: AssetImage(bookmarkDisable),
              ),
              activeIcon: Image(image: AssetImage(bookmarkActive),
              ),
              label: ''
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        iconSize: 25,
        backgroundColor: whiteColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
