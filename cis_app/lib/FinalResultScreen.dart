import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FinalResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Result'),
      ),
      body: SingleChildScrollView(
        // Makes the screen scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Before and After',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),

            // 'Before' image section with grassy background
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/grass.jpg'), // Background image of grass
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Before',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0,
                              0), // Text color for visibility on grass
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Image.asset(
                        'assets/first.png', // Placeholder for before image
                        width: 300.0, // Fixed width
                        height: 300.0, // Fixed height
                        fit: BoxFit.cover, // Maintains aspect ratio
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),

            // 'After' image section with grassy background
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/grass.jpg'), // Background image of grass
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'After',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0,
                              0), // Text color for visibility on grass
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Image.asset(
                        'assets/final.png', // Placeholder for after image
                        width: 300.0, // Fixed width
                        height: 300.0, // Fixed height
                        fit: BoxFit.cover, // Maintains aspect ratio
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
