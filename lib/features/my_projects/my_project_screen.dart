import 'package:flutter/material.dart';
import 'package:mindframe_user/features/my_projects/add_project_screen.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';

class MyProjectScreen extends StatefulWidget {
  const MyProjectScreen({super.key});

  @override
  State<MyProjectScreen> createState() => _MyProjectScreenState();
}

class _MyProjectScreenState extends State<MyProjectScreen> {
  final ProjectsBloc _projectsBloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 17,
          right: 17,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Projects',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddProjectScreen(
                          myProjectBloc: _projectsBloc,
                        ),
                      ),
                    );
                  },
                  iconAlignment: IconAlignment.end,
                  label: const Text(
                    'Add Project',
                  ),
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
