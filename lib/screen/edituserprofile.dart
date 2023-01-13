import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app1/screen/welcome.dart';

class EdituserprofileScreen extends StatelessWidget {
  const EdituserprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return WelcomeScreen();
          }));
        },
        label: const Text(
          'SAVE',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        icon: const Icon(
          Icons.cloud_upload,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Color.fromARGB(255, 46, 197, 26),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.black,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }));
              },
            ),
            SizedBox(
              width: 40,
            ),
            IconButton(
              icon: Icon(Icons.manage_accounts),
              color: Color.fromARGB(255, 255, 153, 0),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
