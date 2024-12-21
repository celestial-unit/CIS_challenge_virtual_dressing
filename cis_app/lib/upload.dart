import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cis_app/FinalResultScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  Uint8List? _imageFile; // Store image as Uint8List

  // Function to pick an image using the html package (Web only)
  Future<void> _pickImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement();
      uploadInput.accept = 'image/*'; // Allow only images

      // Trigger file picker
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0] as html.File);

        // Listen for the load event when the file is loaded
        reader.onLoadEnd.listen((e) {
          setState(() {
            // Convert the result to Uint8List
            _imageFile = reader.result as Uint8List;
          });
        });
      });
    }
  }

  // Function to show the processing popup and navigate after 10 seconds
  void _onSubmit() {
    if (_imageFile == null) return;

    // Show dialog with processing message
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AI is processing your image'),
          content: CircularProgressIndicator(), // Show loading spinner
        );
      },
    );

    // Wait for 10 seconds then close the dialog and navigate to the final result screen
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pop(context); // Close the dialog
      // Navigate to the Final Result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FinalResultScreen()),
      );
    });

    // Wait for 10 seconds then close the dialog and navigate to market screen
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pop(context); // Close the dialog
      // Navigate to market (replace with actual navigation logic)
      Navigator.pushReplacementNamed(context, '/final');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgzen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'UPLOAD YOUR PICTURES',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Upload a photo of yourself for a more personalized shopping experience.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.0),
                  // Display the selected image or default image
                  Container(
                    width: 250.0,
                    height: 250.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: _imageFile != null
                            ? MemoryImage(_imageFile!) // Display picked image
                            : AssetImage('assets/face.jpg')
                                as ImageProvider, // Default image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Button to pick an image
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSubmit, // Trigger submit function
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'UPLOAD',
                        style: TextStyle(color: Colors.white),
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
