import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/features/my_projects/add_project_screen.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/util/show_error_dialog.dart';

class MyProjectScreen extends StatefulWidget {
  const MyProjectScreen({super.key});

  @override
  State<MyProjectScreen> createState() => _MyProjectScreenState();
}

class _MyProjectScreenState extends State<MyProjectScreen> {
  final ProjectsBloc _projectsBloc = ProjectsBloc();

  @override
  void initState() {
    _projectsBloc.add(GetMyProjectsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _projectsBloc,
      child: BlocConsumer<ProjectsBloc, ProjectsState>(
        listener: (context, projectsState) {
          if (projectsState is ProjectsFailureState) {
            showErrorDialog(context);
          }
        },
        builder: (context, projectsState) {
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
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
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
                  const SizedBox(height: 10),
                  if (projectsState is ProjectsGetSuccessState &&
                      projectsState.projects.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 100,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ProjectCard(
                          projectDetails: projectsState.projects[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: projectsState.projects.length,
                      ),
                    )
                  else if (projectsState is ProjectsGetSuccessState &&
                      projectsState.projects.isEmpty)
                    const Center(
                      child: Text(
                        'No projects found',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CupertinoActivityIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
