import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/features/signin/signin_screen.dart';
import 'package:mindframe_user/features/signup/signup_second_screen.dart';
import 'package:mindframe_user/util/value_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('asset/3081627.jpg'),
                    const Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        labelText: 'Username',
                        controller: _nameController,
                        validator: notEmptyValidator,
                        isLoading: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        labelText: 'Email',
                        controller: _emailController,
                        validator: emailValidator,
                        isLoading: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        labelText: 'Password',
                        controller: _passwordController,
                        validator: passwordValidator,
                        isLoading: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        labelText: 'Phone No.',
                        controller: _phoneController,
                        validator: phoneNumberValidator,
                        isLoading: false),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupSecondScreen(),
                            ));
                      },
                      label: 'Next',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ));
                          },
                          child:
                              const Text('''Already have Account! Login ?''')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
