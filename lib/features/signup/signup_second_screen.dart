import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_image_picker_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/features/home/home_screen.dart';
import 'package:mindframe_user/util/value_validator.dart';

class SignupSecondScreen extends StatefulWidget {
  const SignupSecondScreen({super.key});

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                onPick: (file) {},
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
                  isLoading: false),
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
                  validator: passwordValidator,
                  isLoading: false),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                inverse: true,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                label: 'Signup',
              )
            ],
          ),
        ),
      ),
    );
  }
}
