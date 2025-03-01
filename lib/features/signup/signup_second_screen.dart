import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_image_picker_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/features/home/home_screen.dart';
import 'package:mindframe_user/util/value_validator.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/permission_handler.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

class SignupSecondScreen extends StatefulWidget {
  final Map signupDetails;
  const SignupSecondScreen({super.key, required this.signupDetails});

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? profile;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      requestStoragePermission();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is SignUpSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Image.asset('asset/3081627.jpg'),
                    const Text(
                      'Add profile image:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomImagePickerButton(
                      height: 150,
                      width: 150,
                      onPick: (file) {
                        profile = file;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Add  designation:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      labelText: 'Designation',
                      controller: _designationController,
                      validator: notEmptyValidator,
                      isLoading: state is SignUpLoadingState,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add  Bio:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      labelText: 'Bio',
                      controller: _bioController,
                      validator: notEmptyValidator,
                      isLoading: state is SignUpLoadingState,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      inverse: true,
                      isLoading: state is SignUpLoadingState,
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            profile != null) {
                          Map<String, dynamic> details = {
                            'name': widget.signupDetails['name'],
                            'email': widget.signupDetails['email'],
                            'phone': widget.signupDetails['phone'],
                            'bio': _bioController.text.trim(),
                            'designation': _designationController.text.trim(),
                          };

                          if (profile != null) {
                            details['profile_file'] = profile!;
                            details['profile_name'] = profile!.path;
                          }
                          BlocProvider.of<SignUpBloc>(context).add(
                            InsertUserDataEvent(
                              userDetails: details,
                            ),
                          );
                        }
                      },
                      label: 'Signup',
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
