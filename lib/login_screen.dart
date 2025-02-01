import 'package:flutter/material.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/astronaut_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay for text readability
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    'MINDFRAME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Innovation Platform',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Join Mindframe Now to connect, collaborate, and create groundbreaking ideas.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Log In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Log In →',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Create New Account Link
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
