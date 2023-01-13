import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_app1/model/profile.dart';
import 'package:flutter_app1/screen/home.dart';
import 'package:flutter_app1/screen/home2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final Duration duration = const Duration(milliseconds: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Create User"),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("email", style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Please enter your email",
                                  border: OutlineInputBorder()),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter your email"),
                                EmailValidator(
                                    errorText: "Invalid email format")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("password", style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Please enter your password",
                                    border: OutlineInputBorder()),
                                validator: RequiredValidator(
                                    errorText: "Please enter your password"),
                                obscureText: true,
                                onSaved: (String? password) {
                                  profile.password = password!;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            FadeInUp(
                                duration: duration,
                                delay: const Duration(milliseconds: 0),
                                child: SizedBox(
                                    width: double.infinity, //width of button
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 176, 58),
                                          elevation: 3, //elevation of button
                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState?.save();
                                            try {
                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: profile.email,
                                                      password:
                                                          profile.password)
                                                  .then((value) {
                                                formKey.currentState?.reset();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "User created successfully",
                                                    textColor: Color.fromARGB(
                                                        255, 11, 160, 73),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 255, 255, 255),
                                                    gravity: ToastGravity.TOP);
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return HomeScreen2();
                                                }));
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  textColor: Color.fromARGB(
                                                      255, 255, 60, 0),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          }
                                        },
                                        child: Text(
                                          "SING UP",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )))),
                            FadeInUp(
                                duration: duration,
                                // delay: const Duration(milliseconds: 200),
                                child: SizedBox(
                                    width: double.infinity, //width of button
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 65, 18),
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeScreen2();
                                          }));
                                        },
                                        child: Text(
                                          "BACK",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )))),
                          ],
                        )),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
