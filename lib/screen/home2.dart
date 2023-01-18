import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/login.dart';
import 'package:flutter_app1/screen/register.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final Duration duration = const Duration(milliseconds: 800);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 232, 255, 1),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1500),
              child: Container(
                child: Image.asset("assets/images/firebase.png"),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            /// TITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1200),
              child: const Text(
                "Flutter & Firebases",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),

            ///
            const SizedBox(
              height: 10,
            ),

            /// SUBTITLE
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 800),
              child: const Text(
                "This application is registered and logged in with Firebase.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),

            const SizedBox(
              height: 40,
            ),
            FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 200),
                child: SizedBox(
                    width: double.infinity, //width of button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 233, 187,
                              255), //background color of button, //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                        },
                        child: Text(
                          "SING UP",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )))),

            FadeInUp(
                duration: duration,
                child: SizedBox(
                    width: double.infinity, //width of button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 211, 117,
                              255), //background color of button, //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )))),

            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class SButton extends StatelessWidget {
  const SButton({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.img,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;
  final String img;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const HomeScreen2()),
          ),
        );
      },
      child: Container(
        width: size.width / 1.2,
        height: size.height / 15,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
