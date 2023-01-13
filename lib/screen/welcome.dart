import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/edituserprofile.dart';
import 'package:flutter_app1/screen/feedback.dart';
import 'package:flutter_app1/screen/home2.dart';
import 'package:flutter_app1/screen/showapi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen2();
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
              // Image.asset("assets/images/logo.png"),
              Text(
                "${auth.currentUser?.email}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "${auth.currentUser?.uid}",
                style: TextStyle(fontSize: 20),
              ),
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
                    )),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ShowapiScreen();
          }));
        },
        label: const Text('REST API'),
        icon: const Icon(Icons.article_outlined),
        backgroundColor: Color.fromARGB(255, 255, 162, 41),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: Color.fromARGB(255, 255, 153, 0),
              onPressed: () {},
            ),
            SizedBox(
              width: 40,
            ),
            IconButton(
              icon: Icon(Icons.manage_accounts),
              color: Colors.black,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return FeedbackScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
