import 'dart:convert';

import 'package:apis/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}
var data;
class _ExampleFourState extends State<ExampleFour> {
  Future<void> getUserApi()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode==200){
      data = jsonDecode(response.body.toString());
    }else{

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
                builder: (context, snapshot){
                  if (snapshot.connectionState== ConnectionState.waiting){
                   return Text('loading');
                  }
                  else{
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          children: [
                           ReusableRow(title: 'name',value: data[index]['name'].toString()),
                            ReusableRow(title: 'username',value: data[index]['username'].toString()),
                            ReusableRow(title: 'address',value: data[index]['address']['street'].toString()),

                          ],
                        ),
                      );
                    });
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