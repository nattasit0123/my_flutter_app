import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future createUser({required String name}) async {
      final docUser = FirebaseFirestore.instance.collection('users').doc();

      final user = User(
        id: docUser.id,
        name: name,
        age: 21,
        birthday: DateTime(1998, 12, 3),
      );
      final json = user.toJson();

      await docUser.set(json);
    }

    return Scaffold(
        appBar: AppBar(
          title: TextField(controller: controller),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final name = controller.text;

                createUser(name: name);
              },
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ));
  }
}
