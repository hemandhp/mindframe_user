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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAddPressed() {
    // Handle the add button press
    // For example, navigate to a new screen or show a dialog
    print('Add button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SpotlightBottomNav(
        spotlightColor: Colors.yellow,
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
        onPageChanged:
            _onPageChanged, // Use onPageChanged to handle page changes
      ),
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: _onAddPressed,
              backgroundColor: Colors.yellow,
              child: const Icon(IconlyLight.plus), // Match the spotlight color
            )
          : null, // Set to null when index is not 2
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
