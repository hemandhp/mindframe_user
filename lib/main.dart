import 'package:flutter/material.dart';
import 'package:mindframe_user/features/confirmation_screen/confirmation_screen.dart';
import 'package:mindframe_user/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: 'https://neliaksvowuhlldpfyhn.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5lbGlha3N2b3d1aGxsZHBmeWhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4NTczMzcsImV4cCI6MjA0ODQzMzMzN30.a3UYGFvRzGADTkW78dWHZU2KWfHUPBdBkf7gVWGGe9Q');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const ConfirmationScreen(),
    );
  }
}
