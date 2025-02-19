import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/features/home/home_screen.dart';
import 'package:mindframe_user/features/signup/signup_screen.dart';
import 'package:mindframe_user/util/value_validator.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(height: 300, width: 300, 'asset/3350236.jpg'),
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
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
                      label: 'Login',
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
                                  builder: (context) => const SignupScreen(),
                                ));
                          },
                          child: const Text('''Don't have account! Signup?''')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
