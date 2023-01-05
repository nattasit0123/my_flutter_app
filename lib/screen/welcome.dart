import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class WelcomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color.fromARGB(255, 248, 13, 13),
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "${auth.currentUser?.email}",
                style: TextStyle(fontSize: 20),
              ),
              // ElevatedButton(
              //   child: Text("Logout"),
              //   onPressed: () {
              //     auth.signOut().then((value) {
              //       Navigator.pushReplacement(context,
              //           MaterialPageRoute(builder: (context) {
              //         return HomeScreen();
              //       }));
              //     });
              //   },
              // ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Elevated Button with Border Radius"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.person),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      //border radius equal to or more than 50% of width
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
