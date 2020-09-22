import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'joke_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<JokeModel> getPostInfo() async {
    String url = 'https://sv443.net/jokeapi/v2/joke/Any?type=twopart';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Data Found');
      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Cant Load Data');
    }
  }

  @override
  build(BuildContext context) {
    return FutureBuilder<JokeModel>(
      future: getPostInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print('Data');
          if(snapshot.data !=null) {
            JokeModel _jokeModel = snapshot.data;
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: <Widget>[
                    Text('${_jokeModel.setup.toString()}'),
                    Text('${_jokeModel.delivery.toString()}'),
                  ],
                ),
              ),
            );
          } else {
            print('No Data');
          }
        } else {
          // return SafeArea(
          //   child: Scaffold(
          //     body: Center(
          //       child: Text('No Data'),
          //     ),
          //   ),
          // );
        }
      },
    );
  }
}
