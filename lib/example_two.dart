// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APIs Photos"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            // Expanded widget = to occupy entire screen
            child: FutureBuilder(
                future: getPhotos(),
                builder: ((context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString(),
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![index].title.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          title: Text(
                            'Shahzain id :' +
                                snapshot.data![index].id.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }));
                })),
          ),
        ],
      ),
    );
  }
}

// Photos = Model
class Photos {
  String title, url;
  int id;

  Photos(
      {required this.title,
      required this.url,
      required this.id}); // Constructor Creation
}
