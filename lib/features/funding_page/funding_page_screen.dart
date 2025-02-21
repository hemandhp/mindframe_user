import 'package:flutter/material.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/features/project_view_screen/project_detail_screen.dart';

class FundingPageScreen extends StatelessWidget {
  const FundingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            floating: true,
            backgroundColor: Colors.grey[200],
            elevation: 0,
            title: Text(
              'Need Funding',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProjectCard(
                    category: 'Tech',
                    image: 'asset/3350236.jpg',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectDetailScreen(),
                          ));
                    },
                    title: 'Project ${index + 1}',
                    subtitle: 'An innovative solution for modern challenges',
                    daysToGo: 100 - (index * 10),
                    totalDays: 250,
                  ),
                ),
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
