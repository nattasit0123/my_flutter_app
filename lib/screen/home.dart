import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/login.dart';
import 'package:flutter_app1/screen/register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test_App01"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset("assets/images/logo.png"),
            // const Image(
            //     image: NetworkImage(
            //         'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }));
                  },
                  icon: Icon(Icons.add),
                  label: Text("Sing up", style: TextStyle(fontSize: 20))),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  icon: Icon(Icons.login),
                  label: Text("Login", style: TextStyle(fontSize: 20))),
            )
          ]),
        ),
      ),
    );
  }
}
