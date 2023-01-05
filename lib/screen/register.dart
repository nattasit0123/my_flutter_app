import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_app1/model/profile.dart';
import 'package:flutter_app1/screen/home.dart';
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
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

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
                            TextFormField(
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
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText: "Please enter your password"),
                                obscureText: true,
                                onSaved: (String? password) {
                                  profile.password = password!;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedButton(
                                // height: 70,
                                width: double.infinity,
                                text: 'Sing up',
                                isReverse: true,
                                selectedTextColor:
                                    Color.fromARGB(255, 5, 184, 255),
                                transitionType: TransitionType.CENTER_ROUNDER,
                                // textStyle: submitTextStyle,
                                backgroundColor:
                                    Color.fromARGB(255, 5, 184, 255),
                                borderColor: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: 50,
                                borderWidth: 2,
                                onPress: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) {
                                        formKey.currentState?.reset();
                                        Fluttertoast.showToast(
                                            msg: "User created successfully",
                                            textColor: Color.fromARGB(
                                                255, 11, 160, 73),
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            gravity: ToastGravity.TOP);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HomeScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: "${e.message}",
                                          textColor:
                                              Color.fromARGB(255, 255, 60, 0),
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: AnimatedButton(
                                width: double.infinity,
                                text: 'Back',
                                isReverse: true,
                                selectedTextColor:
                                    Color.fromARGB(255, 255, 82, 82),
                                transitionType: TransitionType.LEFT_TO_RIGHT,
                                // textStyle: submitTextStyle,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 82, 82),
                                borderColor: Colors.white,
                                borderRadius: 50,
                                borderWidth: 2,
                                onPress: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                },
                              ),
                            ),
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
