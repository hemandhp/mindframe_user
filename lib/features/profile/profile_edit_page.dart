import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/custom_button.dart';
import 'package:mindframe_user/common_widget/custom_image_picker_button.dart';
import 'package:mindframe_user/common_widget/custom_text_formfield.dart';
import 'package:mindframe_user/theme/app_theme.dart';
import 'package:mindframe_user/util/value_validator.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
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
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomImagePickerButton(
                        // selectedImage: widget.profileDetails['photo'],
                        height: 150,
                        width: 150,
                        borderRadius: 100,
                        onPick: (pick) {
                          // file = pick;
                          setState(() {});
                        },
                      ),
                      // if (file != null)
                      //   Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: IconButton(
                      //       icon: const Icon(Icons.close, color: Colors.white),
                      //       onPressed: () {
                      //         setState(() {
                      //           file = null;
                      //         });
                      //       },
                      //     ),
                      //   ),
                    ],
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
                  // isLoading: state is ProfileLoadingState,
                  controller: _nameController,
                  validator: alphabeticWithSpaceValidator,
                  labelText: 'Enter your name', isLoading: false,
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
                  // isLoading: state is ProfileLoadingState,
                  controller: _phoneController,
                  validator: percentageValidator,
                  labelText: 'Enter your phone number', isLoading: false,
                  // keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 40),

                CustomButton(
                  inverse: true,
                  // isLoading: state is ProfileLoadingState,
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   Map<String, dynamic> details = {
                    //     'name': _nameController.text.trim(),
                    //     'phone': _phoneController.text.trim(),
                    //   };

                    //   if (file != null) {
                    //     details['photo_file'] = file!;
                    //     details['photo_name'] = file!.path;
                    //   }
                    //   BlocProvider.of<ProfileBloc>(context).add(
                    //     EditProfileEvent(
                    //       profile: details,
                    //       profileId: widget.profileDetails['id'],
                    //     ),
                    //   );
                    // }
                  },
                  label: 'Save Changes',
                ),
              ],
            ),
          ),
        ));
  }
}
