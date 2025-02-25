import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/features/home/home_screen.dart';
import 'package:mindframe_user/features/signin/signin_screen.dart';
import 'package:mindframe_user/features/signup/signup_second_screen.dart';
import 'package:mindframe_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widget/custom_alert_dialog.dart';
import 'sign_up_bloc/sign_up_bloc.dart';

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
  bool isObscure = true;

  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignupSecondScreen(
                  signupDetails: {
                    'email': _emailController.text.trim(),
                    'name': _nameController.text.trim(),
                    'phone': _phoneController.text.trim(),
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
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
                            isLoading: state is SignUpLoadingState,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            labelText: 'Email',
                            controller: _emailController,
                            validator: emailValidator,
                            isLoading: state is SignUpLoadingState,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              enabled: state is! SignUpLoadingState,
                              controller: _passwordController,
                              obscureText: isObscure,
                              validator: passwordValidator,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure = !isObscure;
                                      setState(() {});
                                    },
                                    icon: Icon(isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                border: const OutlineInputBorder(),
                                hintText: 'Password',
                              )),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: 'Phone No.',
                            controller: _phoneController,
                            validator: phoneNumberValidator,
                            isLoading: state is SignUpLoadingState,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            isLoading: state is SignUpLoadingState,
                            inverse: true,
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpUserEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
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
                                        builder: (context) =>
                                            const SigninScreen(),
                                      ));
                                },
                                child: const Text(
                                    '''Already have Account! Login ?''')),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
