import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/home2.dart';
import 'package:flutter_app1/screen/home_page.dart';
import 'package:flutter_app1/screen/showapi.dart';

final auth = FirebaseAuth.instance;

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login by ' + '${auth.currentUser?.email}'),
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
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Nattasit Janwiset",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Computer Science",
                  ),
                  SizedBox(height: 8),
                  Text(
                    "🎯 My first flutter application 🎯",
                  ),
                  SizedBox(height: 6),
                  Text(
                    "What I'm currently learning",
                  ),
                  const SizedBox(height: 13),
                  const _ProfileInfoRow(),
                  SizedBox(height: 13),
                  Text(
                    "Contact",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  FloatingActionButton.extended(
                    heroTag: "btn1",
                    label: Text(
                      'nattasit.work@gmail.com',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ), // <-- Text
                    backgroundColor: Color.fromARGB(255, 75, 75, 75),
                    icon: Icon(
                      Icons.email,
                      size: 24.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
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
        icon: const Icon(Icons.list),
        backgroundColor: Color.fromARGB(255, 255, 187, 0),
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

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://nattasit0123.github.io/pic/3332.png'),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://nattasit0123.github.io/flutter/pic/icon.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 99, 64, 255),
                    Color.fromARGB(204, 211, 117, 255)
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://nattasit0123.github.io/flutter/pic/profile01.jpg')),
                    // 'https://nattasit0123.github.io/pic/ruby.png')),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
