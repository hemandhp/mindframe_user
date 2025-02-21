import 'package:flutter/material.dart';

class MyProjectScreen extends StatelessWidget {
  const MyProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('MyProjectScreen')],
      ),
    );
  }
}
