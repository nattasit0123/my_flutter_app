import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/add_student.dart';
import 'package:flutter_app1/screen/showapi.dart';
import 'package:flutter_app1/screen/student.dart';
import 'package:flutter_app1/screen/update_student.dart';
import 'package:flutter_app1/screen/welcome.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase CRUD'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          // Check for error
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          // if data received
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            // Convert data to List
            List<Student> students = documents
                .map((e) => Student(
                    id: e['id'],
                    rollno: e['rollno'],
                    name: e['name'],
                    marks: e['marks']))
                .toList();
            return _getBody(students);
          } else {
            // Show Loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        // child: _getBody()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudent(),
              ));
          //
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(204, 211, 117, 255),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: Color.fromARGB(255, 0, 0, 0),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }));
              },
            ),
            SizedBox(
              width: 40,
            ),
            IconButton(
              icon: Icon(Icons.manage_accounts),
              color: Color.fromARGB(204, 211, 117, 255),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(students) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No Data Yet\nClick + to start adding',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) => Card(
              color: students[index].marks < 33
                  ? Colors.red.shade100
                  : students[index].marks < 65
                      ? Colors.yellow.shade100
                      : Colors.green.shade100,
              child: ListTile(
                title: Text(students[index].name),
                subtitle: Text('Rollno: ${students[index].rollno}'),
                leading: CircleAvatar(
                  radius: 25,
                  child: Text('${students[index].marks}'),
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.black.withOpacity(0.75),
                        ),
                        onTap: () {
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateStudent(student: students[index]),
                              ));
                        },
                      ),
                      InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          //
                          _reference.doc(students[index].id).delete();
                          // To refresh
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));

                          //
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
