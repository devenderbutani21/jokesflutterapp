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
        primarySwatch: Colors.orange,
        // scaffoldBackgroundColor: Colors.deepOrangeAccent,
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
      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Cant Load Data');
    }
  }

  @override
  void initState() {
    super.initState();
    getPostInfo();
  }

  @override
  build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<JokeModel>(
      future: getPostInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          CircularProgressIndicator();
        }
        JokeModel _jokeModel = snapshot.data;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'What The Joke?',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  // height: deviceSize.height * 1/8,
                  // width: deviceSize.width * 0.9,
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    '${_jokeModel.setup.toString()}',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  // height: deviceSize.height * 1/8,
                  // width: deviceSize.width * 0.9,
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    '${_jokeModel.delivery.toString()}',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceSize.height * 1 / 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: MaterialButton(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        getPostInfo();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
