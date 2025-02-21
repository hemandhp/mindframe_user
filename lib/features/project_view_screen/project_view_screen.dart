import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_search.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/features/project_view_screen/project_detail_screen.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Prithvi',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Welcome to Mindframe',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomSearch(
                      onSearch: (query) {},
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'View Upcoming Projects',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryButton(label: "Tech", isSelected: true),
                    CategoryButton(label: "Tea Shop"),
                    CategoryButton(label: "Real Estate"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 420,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProjectCard(
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
                    ProjectCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectDetailScreen(),
                          ),
                        );
                      },
                      image: 'asset/3081627.jpg',
                      title: "Machu Picchu",
                      subtitle: 'Historic restoration project',
                      daysToGo: 45,
                      totalDays: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isSelected) // Only show the Container if isSelected is true
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  const DecorationImage(image: AssetImage('asset/54187.jpg')),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Chip(
            label: Text(label),
            backgroundColor: isSelected ? Colors.black : Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
