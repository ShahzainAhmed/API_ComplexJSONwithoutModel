// Building List with Complex JSON Data without Model

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body
          .toString()); // providing data from postman, here body is all the data in postman
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex JSON without Model"),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(
                              title: 'Name',
                              value: data[index]['name'].toString(),
                            ),
                            ReusableRow(
                              title: 'Username',
                              value: data[index]['username'].toString(),
                            ),
                            ReusableRow(
                              title: 'Website',
                              value: data[index]['website'].toString(),
                            ),
                            ReusableRow(
                              title: 'Address',
                              value:
                                  data[index]['address']['street'].toString(),
                            ),
                            ReusableRow(
                              // for all 'geo'
                              title: 'Geo',
                              value: data[index]['address']['geo'].toString(),
                            ),
                            ReusableRow(
                              // for only geos 'lat'
                              title: 'Only Lat',
                              value: data[index]['address']['geo']['lat']
                                  .toString(),
                            ),
                            ReusableRow(
                              // for only geos 'lat'
                              title: 'Only Lng',
                              value: data[index]['address']['geo']['lng']
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
