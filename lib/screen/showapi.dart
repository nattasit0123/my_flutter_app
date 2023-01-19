import 'package:flutter/material.dart';
import 'package:flutter_app1/model/post.dart';
import 'package:flutter_app1/screen/ProfilePage1.dart';
import 'package:flutter_app1/services/remote_service.dart';
import 'package:http/http.dart';

class ShowapiScreen extends StatefulWidget {
  const ShowapiScreen({super.key});

  @override
  State<ShowapiScreen> createState() => _ShowapiScreenState();
}

class _ShowapiScreenState extends State<ShowapiScreen> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    posts = (await RemoteService().getPosts())?.cast<Post>();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API on Github Pages'),
      ),
      body: Visibility(
        visible: isLoaded,
        // ignore: sort_child_properties_last
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('${posts![index].pic}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(204, 238, 202, 255),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${posts![index].title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${posts![index].body}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ProfilePage1();
          }));
        },
        label: const Text(
          'Back',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: Color.fromARGB(255, 255, 212, 18),
      ),
    );
  }
}
