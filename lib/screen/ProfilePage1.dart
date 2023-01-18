import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/home2.dart';
import 'package:flutter_app1/screen/home_page.dart';
import 'package:flutter_app1/screen/showapi.dart';
import 'package:flutter_app1/screen/welcome.dart';

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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'email',
                        elevation: 1,
                        label: const Text("nattasit.work@gmail.com"),
                        icon: const Icon(Icons.email),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _ProfileInfoRow()
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
      width: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://nattasit0123.github.io/pic/3332.png'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12),
        // color: Color.fromARGB(204, 238, 202, 255),
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
          // Container(
          //   height: 50,
          //   width: 50,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: NetworkImage(
          //             'https://nattasit0123.github.io/pic/api.png'),
          //         fit: BoxFit.cover),
          //     borderRadius: BorderRadius.circular(12),
          //     color: Color.fromARGB(204, 238, 202, 255),
          //   ),
          // ),
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
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 99, 64, 255),
                    // Color.fromARGB(255, 255, 88, 247),
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
