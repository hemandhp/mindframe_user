import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/common_widget/custom_search.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/categories_bloc/categories_bloc.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';
import 'package:mindframe_user/features/project_view_screen/project_card.dart';
import 'package:mindframe_user/theme/app_theme.dart';
import 'package:mindframe_user/util/show_error_dialog.dart';

class ProjectViewScreen extends StatefulWidget {
  const ProjectViewScreen({super.key});

  @override
  State<ProjectViewScreen> createState() => _ProjectViewScreenState();
}

class _ProjectViewScreenState extends State<ProjectViewScreen> {
  int? _selectedCategoryId;

  final CategoriesBloc _categoriesBloc = CategoriesBloc();
  final ProjectsBloc _projectsBloc = ProjectsBloc();

  List<Map<String, dynamic>> projects = [];

  @override
  void initState() {
    _categoriesBloc.add(CategoriesEvent());
    _projectsBloc.add(GetProjectsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>.value(
          value: _categoriesBloc,
        ),
        BlocProvider<ProjectsBloc>.value(
          value: _projectsBloc,
        ),
      ],
      child: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (context, categoryState) {
          if (categoryState is CategoriesFailureState) {
            showErrorDialog(context);
          }
        },
        builder: (context, categoryState) {
          return BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, projectState) {
              if (projectState is ProjectsFailureState) {
                showErrorDialog(context);
              } else if (projectState is ProjectsGetSuccessState) {
                projects = projectState.projects;
                setState(() {});
              }
            },
            builder: (context, projectState) {
              return Material(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Projects',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSearch(
                                onSearch: (query) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Categories',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        if (categoryState is CategoriesSuccessState)
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => CategoryButton(
                                isSelected: _selectedCategoryId ==
                                    categoryState.categories[index]['id'],
                                image: categoryState.categories[index]
                                    ['image_url'],
                                label: categoryState.categories[index]['name'],
                                onTap: () {
                                  if (_selectedCategoryId ==
                                      categoryState.categories[index]['id']) {
                                    _selectedCategoryId = null;
                                  } else {
                                    _selectedCategoryId =
                                        categoryState.categories[index]['id'];
                                  }
                                  setState(() {});
                                },
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 10,
                              ),
                              itemCount: categoryState.categories.length,
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        const SizedBox(height: 20),
                        Text(
                          'View Projects',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ProjectCard(
                            projectDetails: projects[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: projects.length,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
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
