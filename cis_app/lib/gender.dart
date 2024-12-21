import 'package:flutter/material.dart';

class GenderSelectionScreen extends StatefulWidget {
  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  bool isNextSelected = true; // Track which button is selected
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/bgzen.png', // Replace with your background image path
            fit: BoxFit.cover,
          ),
          // Title Content
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Select',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' your gender',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Buttons at the bottom
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Male option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Male';
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedGender == 'Male' ? Colors.black : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/male.png', // Replace with your male image path
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Male',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // Female option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Female';
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedGender == 'Female' ? Colors.black : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/female.png', // Replace with your female image path
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Female',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isNextSelected = true; // Set Next as selected
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isNextSelected ? Colors.black : Colors.white,
                        side: BorderSide(color: Colors.black), // Border for the white button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: isNextSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isNextSelected = false; // Set Back as selected
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isNextSelected ? Colors.white : Colors.black,
                        side: BorderSide(color: Colors.black), // Border for the white button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: isNextSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
