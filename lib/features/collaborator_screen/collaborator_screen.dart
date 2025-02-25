import 'package:flutter/material.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/features/project_view_screen/project_detail_screen.dart';

class CollaboratorScreen extends StatelessWidget {
  const CollaboratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => ProjectCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectDetailScreen(),
              ),
            );
          },
          image: 'asset/54187.jpg',
          title: "Tesla",
          subtitle: 'Innovative electric car project',
          daysToGo: 33,
          totalDays: 50,
          needCollab: true,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: 4,
      ),
    );
  }
}
