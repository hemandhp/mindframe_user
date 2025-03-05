import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindframe_user/common_widget/custom_alert_dialog.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/categories_bloc/categories_bloc.dart';
import 'package:mindframe_user/features/project_view_screen/blocs/projects_bloc/projects_bloc.dart';
import 'package:mindframe_user/util/show_error_dialog.dart';
import 'package:mindframe_user/util/value_validator.dart';
import 'package:mindframe_user/values/countries.dart';

class AddProjectScreen extends StatefulWidget {
  final ProjectsBloc myProjectBloc;
  final Map<String, dynamic>? projectDetails;
  const AddProjectScreen({
    super.key,
    required this.myProjectBloc,
    this.projectDetails,
  });

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final CategoriesBloc _categoriesBloc = CategoriesBloc();
  final ProjectsBloc _projectsBloc = ProjectsBloc();

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fundController = TextEditingController();

  int? _selectedCategoryId;
  XFile? _coverImage;

  bool _fundingRequired = false;

  Map? country;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _categoriesBloc.add(CategoriesEvent());

    if (widget.projectDetails != null) {
      _projectNameController.text = widget.projectDetails!['title'];
      _descriptionController.text = widget.projectDetails!['description'];
      _selectedCategoryId = widget.projectDetails!['category_id'];
      _fundingRequired = widget.projectDetails!['fund_required'] != null;
      _fundController.text = widget.projectDetails!['fund_required'] != null
          ? widget.projectDetails!['fund_required'].toString()
          : '';
      country = {
        'country': widget.projectDetails!['country'],
        'state': widget.projectDetails!['state'],
        'district': widget.projectDetails!['district'],
        'city': widget.projectDetails!['city'],
      };
    }

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
            listener: (context, projectState) async {
              if (projectState is ProjectsFailureState) {
                showErrorDialog(context);
              } else if (projectState is ProjectsSuccessState) {
                widget.myProjectBloc.add(GetMyProjectsEvent());
                await showDialog(
                  context: context,
                  builder: (context) => const CustomAlertDialog(
                    title: 'Success',
                    description: 'Project Saved successfully',
                    primaryButton: 'Ok',
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            builder: (context, projectState) {
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Add Project'),
                  ),
                  body: ListView(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 50,
                    ),
                    children: [
                      Text(
                        'Select Cover Image',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                        child: InkWell(
                          onTap: () async {
                            _coverImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height:
                                (MediaQuery.of(context).size.width - 40) / 2,
                            width: double.maxFinite,
                            child: widget.projectDetails != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      widget.projectDetails!['image_url'],
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : _coverImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          File(
                                            _coverImage!.path,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(
                                        size: 50,
                                        Icons.add_photo_alternate,
                                        color: Colors.grey,
                                      ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _projectNameController,
                        validator: alphanumericWithSpecialCharsValidator,
                        decoration: const InputDecoration(
                          labelText: 'Project Name',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        minLines: 3,
                        maxLines: 5,
                        validator: alphanumericWithSpecialCharsValidator,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      const Divider(height: 30),
                      Text(
                        'Select Category',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 10),
                      if (categoryState is CategoriesSuccessState)
                        SizedBox(
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Material(
                              color: _selectedCategoryId ==
                                      categoryState.categories[index]['id']
                                  ? Colors.black87
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
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
                                borderRadius: BorderRadius.circular(15),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    top: 5,
                                    bottom: 5,
                                    right: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          categoryState.categories[index]
                                              ['image_url'],
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        categoryState.categories[index]['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: _selectedCategoryId ==
                                                      categoryState
                                                              .categories[index]
                                                          ['id']
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fund Required',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          CupertinoSwitch(
                            value: _fundingRequired,
                            onChanged: (value) {
                              setState(() {
                                _fundingRequired = value;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_fundingRequired)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: _fundController,
                            validator: numericValidator,
                            decoration: const InputDecoration(
                              labelText: 'Required Fund Amount',
                            ),
                          ),
                        ),
                      const Divider(height: 30),
                      CountrySelector(
                        counryStateDistrictCity: country,
                        onChanged: (selected) {
                          country = selected;
                          setState(() {});
                        },
                      ),
                      const Divider(height: 30),
                      CustomButton(
                        label: 'Save Project',
                        isLoading: projectState is ProjectsLoadingState,
                        inverse: true,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (country != null &&
                                _selectedCategoryId != null &&
                                (widget.projectDetails != null ||
                                    _coverImage != null)) {
                              if (widget.projectDetails != null) {
                                _projectsBloc.add(
                                  EditProjectEvent(
                                    projectId: widget.projectDetails!['id'],
                                    projectDetails: {
                                      'title': _projectNameController.text,
                                      'description':
                                          _descriptionController.text,
                                      'category_id': _selectedCategoryId,
                                      'image': _coverImage,
                                      'fund_required': _fundingRequired
                                          ? int.tryParse(_fundController.text
                                                  .trim()) ??
                                              0
                                          : null,
                                      ...country!
                                    },
                                  ),
                                );
                              } else {
                                _projectsBloc.add(
                                  AddProjectEvent(
                                    projectDetails: {
                                      'title': _projectNameController.text,
                                      'description':
                                          _descriptionController.text,
                                      'category_id': _selectedCategoryId,
                                      'image': _coverImage,
                                      'fund_required': _fundingRequired
                                          ? int.tryParse(_fundController.text
                                                  .trim()) ??
                                              0
                                          : null,
                                      ...country!
                                    },
                                  ),
                                );
                              }
                            } else {
                              showErrorDialog(
                                context,
                                title: 'Missing Fields',
                                message:
                                    'Please select a cover image, category, country, state, district and city to continue',
                              );
                            }
                          }
                        },
                      ),
                    ],
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
