import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mindframe_user/features/collaborator_screen/collaborator_screen.dart';
import 'package:mindframe_user/features/funding_page/funding_page_screen.dart';
import 'package:mindframe_user/features/my_projects/my_project_screen.dart';
import 'package:mindframe_user/features/profile/profile_screen.dart';
import 'package:mindframe_user/features/project_view_screen/project_view_screen.dart';
import 'package:spotlight_bottom_navbar/spotlight_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String titleName(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Funding';
      case 2:
        return 'My Projects';
      case 3:
        return 'Collabs';
      case 4:
        return 'Profile';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          titleName(_selectedIndex),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
      ),
      body: SpotlightBottomNav(
        spotlightColor: Colors.white,
        bottomNavCount: 5,
        icons: const [
          IconlyLight.home,
          IconlyLight.activity,
          IconlyLight.plus,
          IconlyLight.info_square,
          IconlyLight.profile,
        ],
        pages: const [
          ProjectViewScreen(),
          FundingPageScreen(),
          MyProjectScreen(),
          CollaboratorScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
