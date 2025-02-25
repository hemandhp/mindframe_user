import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_search.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/features/project_view_screen/project_detail_screen.dart';
import 'package:mindframe_user/theme/app_theme.dart';

class ProjectViewScreen extends StatefulWidget {
  const ProjectViewScreen({super.key});

  @override
  State<ProjectViewScreen> createState() => _ProjectViewScreenState();
}

class _ProjectViewScreenState extends State<ProjectViewScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSearch(
                      onSearch: (query) {},
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: outlineColor)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.tune),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CategoryButton(
                    isSelected: _selectedIndex == index,
                    image:
                        'https://plus.unsplash.com/premium_photo-1666529072120-4c5d9f36c74e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    label: "Tech",
                    onTap: () {
                      _selectedIndex = index;
                      setState(() {});
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: 4,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'View Projects',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.separated(
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
  final String image;
  final Function() onTap;

  const CategoryButton({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: outlineColor)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                shape: isSelected
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white))
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
