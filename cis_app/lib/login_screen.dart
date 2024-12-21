import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  // Define controllers for the text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to handle user login
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost:5000/login'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Successful login
        print('Login successful!');
        Navigator.pushNamed(context, '/market'); // Navigate to dashboard
      } else {
        // Error: Display message from backend
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(responseData['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text('Something went wrong. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.asset(
                  'assets/bckg.png',
                  fit: BoxFit.fill, // Adjust the fit as needed
                ),
                Center(
                  child: Image.asset(
                    'assets/ZEN.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // White background container
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Google Button
                        SizedBox(
                          width: fieldWidth,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/google_icon.png',
                                height: 24,
                                width: 24,
                              ),
                              label: const Text(
                                'Log in - Google Account',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email TextField
                        SizedBox(
                          width: fieldWidth,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email / Username',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Password TextField
                        SizedBox(
                          width: fieldWidth,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(Icons.visibility,
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        SizedBox(
                          width: fieldWidth,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Get email and password from the text fields
                                final email = emailController.text;
                                final password = passwordController.text;

                                // Call the login function
                                loginUser(email, password, context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/dashboard');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Go to Dashboard',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Sign Up and Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/market');
                          },
                          child: const Text(
                            "Forgot password",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
