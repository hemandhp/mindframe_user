import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindframe_user/features/profile/profile_edit_page.dart';
import 'package:mindframe_user/theme/app_theme.dart';
import 'package:mindframe_user/util/format_function.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widget/change_password.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import '../confirmation_screen/confirmation_screen.dart';
import 'profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();
  Map _profile = {};

  @override
  void initState() {
    getProfile();
    checkLogin(context);
    super.initState();
  }

  void getProfile() {
    _profileBloc.add(GetAllProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getProfile();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ProfileGetSuccessState) {
            _profile = state.profile;
            setState(() {});
          } else if (state is ProfileSuccessState) {
            getProfile();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Material(
            color: Colors.white,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                ProfilePicture(
                  image: _profile['photo'],
                ),
                const SizedBox(height: 20),
                ProfileDetails(
                  profileDetails: _profile,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _profileBloc,
                          child: ProfileEditPage(
                            profileDetails: _profile,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String? image;
  const ProfilePicture({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(
        side: BorderSide(color: outlineColor, width: 2),
      ),
      elevation: 4,
      shadowColor: outlineColor,
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: image != null
              ? Image.network(
                  image!,
                  fit: BoxFit.cover,
                  width: 140,
                  height: 140,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 50, color: Colors.red),
                )
              : Icon(Icons.person, size: 50, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}

// Profile Details Section
class ProfileDetails extends StatelessWidget {
  final Function() onEdit;
  final Map profileDetails;
  const ProfileDetails(
      {super.key, required this.profileDetails, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileCard(
          icon: Icons.person,
          label: "Name",
          value: formatValue(profileDetails['name']),
        ),
        ProfileCard(
          icon: Icons.info,
          label: "Bio",
          value: formatValue(profileDetails['bio']),
        ),
        ProfileCard(
          icon: Icons.work,
          label: "Designation",
          value: formatValue(profileDetails['designation']),
        ),
        ProfileCard(
          icon: Icons.email,
          label: "Email",
          value: formatValue(profileDetails['email']),
        ),
        ProfileCard(
            icon: Icons.phone,
            label: "Phone",
            value: "+91 ${formatValue(profileDetails['phone'])}"),
        ProfileCard(
          onTap: onEdit,
          icon: Icons.edit,
          value: "Edit Profile",
        ),
        ProfileCard(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const ChangePasswordDialog(),
            );
          },
          icon: Icons.lock,
          value: "Change Password",
        ),
        ProfileCard(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: "SIGN OUT",
                content: const Text(
                  "Are you sure you want to Sign Out? Clicking 'Sign Out' will end your current session and require you to sign in again to access your account.",
                ),
                primaryButton: "SIGN OUT",
                onPrimaryPressed: () {
                  Supabase.instance.client.auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfirmationScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            );
          },
          icon: Icons.logout,
          value: "Sign Out",
        ),
      ],
    );
  }
}

// Reusable Profile Info Card
class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String value;
  final Function()? onTap;

  const ProfileCard({
    super.key,
    required this.icon,
    this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: outlineColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(label!,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12)),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
