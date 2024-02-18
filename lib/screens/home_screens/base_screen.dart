import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/screens/home_screens/bookmark_screen.dart';
import 'package:blog/screens/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key,}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;

    return BackgroundWidget(
      hasAppBar: false,
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: selectedIndex,
            children: const [
              HomeScreen(),
              BookmarkScreen(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallet.white,
        elevation: 0,
        items: [
          bottomNavWidget(
            icon: Icons.home,
            iconActive: Icons.home,
            label: 'Home',
            //largeIcon: true
          ),
          bottomNavWidget(
              icon: Icons.bookmark,
              iconActive: Icons.bookmark_outlined,
              label: 'Bookmarks'
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Pallet.white,
        showSelectedLabels: true,
        unselectedItemColor: Pallet.hintColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    if (mounted) setState(() {});
  }

  BottomNavigationBarItem bottomNavWidget(
      {String label = '',
        required IconData icon,
        required IconData iconActive,
        bool largeIcon = false}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(
        icon,
        size: 32.w,
        color: Pallet.grey,
      ),
      activeIcon: Icon(
        iconActive,
        size: 32.w,
        color: Pallet.blue
      ),
    );
  }
}