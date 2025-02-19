import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_search.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set background color to white

      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Prithvi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome to Mindframe',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
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
                  onSearch: (p0) {},
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'View Upcoming Projects',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              CategoryButton(label: "Tech", isSelected: true),
              CategoryButton(label: "Tea shop"),
              CategoryButton(label: "Realestate"),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.450,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ProjectCard(
                  image: 'asset/54187.jpg',
                  location: "Brazil",
                  title: "Tesla",
                  rating: 5.0,
                  reviews: 143,
                ),
                ProjectCard(
                  image: 'asset/3081627.jpg',
                  location: "Peru",
                  title: "Machu Picchu",
                  rating: 4.9,
                  reviews: 120,
                ),
              ],
            ),
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.black : Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
