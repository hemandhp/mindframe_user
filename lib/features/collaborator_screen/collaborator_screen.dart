import 'package:flutter/material.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';
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
          projectDetails: {},
          myProjectBloc: ProjectsBloc(),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: 4,
      ),
    );
  }
}
