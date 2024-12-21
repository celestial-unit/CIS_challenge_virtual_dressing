import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding JSON
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _genderController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final gender = _genderController.text.trim();

    final url = Uri.parse('http://localhost:5000/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'gender': gender,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up successful!')),
        );
        Navigator.pushNamed(context, '/login');
      } else {
        // Error
        final error =
            json.decode(response.body)['message'] ?? 'Sign-up failed.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with background image
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/bckg.png',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Form fields
                    const SizedBox(height: 20),
                    buildTextField('Username', _usernameController),
                    const SizedBox(height: 15),
                    buildTextField('Email', _emailController),
                    const SizedBox(height: 15),
                    buildTextField('Password', _passwordController,
                        obscureText: true),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Confirm Password', _confirmPasswordController,
                        obscureText: true),
                    const SizedBox(height: 15),
                    buildTextField('Gender (optional)', _genderController),
                    const SizedBox(height: 20),
                    // Sign-up button
                    SizedBox(
                      width: fieldWidth,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Redirect to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
