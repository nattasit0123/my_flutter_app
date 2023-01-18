import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/ProfilePage1.dart';
import 'package:flutter_app1/screen/home2.dart';
import 'package:flutter_app1/screen/welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final Duration duration = const Duration(milliseconds: 0);
  final auth = FirebaseAuth.instance;

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
                title: Text("Login "),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("email", style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 15,
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
                              height: 15,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Please enter your email",
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
                                // delay: const Duration(milliseconds: 200),
                                child: SizedBox(
                                    width: double.infinity, //width of button
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              204, 211, 117, 255),
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
                                                  .signInWithEmailAndPassword(
                                                      email: profile.email,
                                                      password:
                                                          profile.password)
                                                  .then((value) {
                                                formKey.currentState?.reset();
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return ProfilePage1();
                                                }));
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Login with ${auth.currentUser?.email} successfully",
                                                    textColor: Color.fromARGB(
                                                        255, 1, 160, 67),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 255, 255, 255),
                                                    gravity: ToastGravity.TOP);
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  textColor: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          }
                                        },
                                        child: Text(
                                          "LOGIN",
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
                                              Color.fromARGB(255, 255, 212, 18),
                                          elevation: 3, //elevation of button
                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
