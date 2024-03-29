import 'dart:convert';

import 'package:apis/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      // Use 'List<dynamic>' instead of 'var' to explicitly specify the type.
      List<dynamic> data = jsonDecode(response.body.toString());

      for (Map<String, dynamic> i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      // If there's an error, you might want to throw an exception or handle it accordingly.
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableRow(title: 'Name: ', value: snapshot.data![index].name.toString()),
                              ReusableRow(title: 'UserName: ', value: snapshot.data![index].username.toString()),
                              ReusableRow(title: 'Email: ', value: snapshot.data![index].email.toString()),
                              ReusableRow(title: 'Address: ', value: snapshot.data![index].address.city.toString()),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({super.key, required this.title , required this.value});

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
