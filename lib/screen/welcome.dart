import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/ProfilePage1.dart';

import 'package:flutter_app1/screen/home2.dart';
import 'package:flutter_app1/screen/home_page.dart';
import 'package:flutter_app1/screen/showapi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
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
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfilePage1();
                        }));
                      },
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
        icon: const Icon(Icons.art_track),
        backgroundColor: Color.fromARGB(255, 255, 183, 75),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: Color.fromARGB(204, 211, 117, 255),
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
                  return HomePage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
