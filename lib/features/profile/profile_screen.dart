import 'package:flutter/material.dart';
import 'package:mindframe_user/common_widget/change_password.dart';
import 'package:mindframe_user/features/profile/profile_edit_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.greenAccent,
                child: Icon(Icons.person, size: 40, color: Colors.black)),
            const SizedBox(height: 10),
            const Text("Prethvi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Prethvi@icloud.com",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEditPage(),
                      ));
                },
                child: const Text("Edit profile")),
            const SizedBox(height: 20),
            const Text("settings",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            ListTile(
                leading: const Icon(Icons.password, color: Colors.black),
                title: const Text("Change Password"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ChangePasswordDialog(),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => CustomAlertDialog(
                  //     title: "SIGN OUT",
                  //     content: const Text(
                  //       "Are you sure you want to Sign Out? Clicking 'Sign Out' will end your current session and require you to sign in again to access your account.",
                  //     ),
                  //     primaryButton: "SIGN OUT",
                  //     onPrimaryPressed: () {
                  //       Supabase.instance.client.auth.signOut();
                  //       Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const SigninScreen(),
                  //           ),
                  //           (route) => false);
                  //     },
                  //   ),
                  // );
                }),
          ],
        ),
      ),
    );
  }
}
