import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mindframe_user/features/project_view_screen/project_view_screen.dart';
import 'package:spotlight_bottom_navbar/spotlight_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SpotlightBottomNav(
        spotlightColor: Colors.yellow,
        bottomNavCount: 4,
        icons: const [
          IconlyLight.home,
          IconlyLight.activity,
          IconlyLight.info_square,
          IconlyLight.profile,
        ],
        pages: [
          const ProjectViewScreen(),
          Container(
            color: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Funding Page',
                    style: TextStyle(color: Colors.black, fontSize: 24)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Collaborator Page',
                    style: TextStyle(color: Colors.black, fontSize: 24)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profile Page',
                    style: TextStyle(color: Colors.black, fontSize: 24)),
              ],
            ),
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            _onItemTapped(index);
          });
        }, // Ensure this is correctly updating the state
      ),
      // floatingActionButton: _selectedIndex == 0
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           // Add your FAB functionality here
      //         },
      //         backgroundColor: Colors.yellow,
      //         child: const Icon(Icons.add),
      //       )
      //     : null,
    );
  }
}
