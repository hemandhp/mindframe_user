import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_image_picker_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/theme/app_theme.dart';
import 'package:mindframe_user/util/value_validator.dart';

import 'profile_bloc/profile_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  final Map? profileDetails;
  const ProfileEditPage({super.key, required this.profileDetails});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? file;

  @override
  void initState() {
    if (widget.profileDetails != null) {
      _nameController.text = widget.profileDetails!['name'];
      _phoneController.text = widget.profileDetails!['phone'];
      _designationController.text = widget.profileDetails!['designation'];
      _bioController.text = widget.profileDetails!['bio'];
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'EDIT PROFILE',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 18),
              ),
              elevation: 0,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Image Picker
                    Center(
                      child: CustomImagePickerButton(
                        selectedImage: widget.profileDetails?['photo'],
                        height: 150,
                        width: 150,
                        borderRadius: 100,
                        onPick: (pick) {
                          file = pick;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Name Field
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      isLoading: state is ProfileLoadingState,
                      controller: _nameController,
                      validator: alphabeticWithSpaceValidator,
                      labelText: 'Enter your name',
                    ),
                    const SizedBox(height: 20),

                    // Phone Field
                    Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      isLoading: state is ProfileLoadingState,
                      controller: _phoneController,
                      validator: phoneNumberValidator,
                      labelText: 'Enter your phone number',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Designation',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      labelText: 'Designation',
                      controller: _designationController,
                      validator: notEmptyValidator,
                      isLoading: state is ProfileLoadingState,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bio',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      labelText: 'Bio',
                      controller: _bioController,
                      validator: notEmptyValidator,
                      isLoading: state is ProfileLoadingState,
                    ),
                    const SizedBox(height: 40),

                    CustomButton(
                      inverse: true,
                      isLoading: state is ProfileLoadingState,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> details = {
                            'name': _nameController.text.trim(),
                            'phone': _phoneController.text.trim(),
                            'bio': _bioController.text.trim(),
                            'designation': _designationController.text.trim(),
                          };

                          if (file != null) {
                            details['profile_file'] = file!;
                            details['profile_name'] = file!.path;
                          }
                          BlocProvider.of<ProfileBloc>(context).add(
                            EditProfileEvent(
                              profile: details,
                              profileId: widget.profileDetails!['id'],
                            ),
                          );
                        }
                      },
                      label: 'Save Changes',
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
