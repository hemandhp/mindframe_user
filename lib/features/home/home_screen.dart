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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'MindFrame',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
      ),
      body: const SpotlightBottomNav(
        spotlightColor: Colors.white,
        bottomNavCount: 4,
        icons: [
          IconlyLight.home,
          IconlyLight.activity,
          IconlyLight.plus,
          // IconlyLight.info_square,
          IconlyLight.profile,
        ],
        pages: [
          ProjectViewScreen(),
          FundingPageScreen(),
          MyProjectScreen(),
          // CollaboratorScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
