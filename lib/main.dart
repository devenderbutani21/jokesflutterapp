import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './models/joke_model_two_part.dart';

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
  Future<JokeModelTwoPart> getPostInfo() async {
    String url = 'https://sv443.net/jokeapi/v2/joke/Any?type=twopart';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return JokeModelTwoPart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Cant Load Data');
    }
  }

  @override
  void initState() {
    super.initState();
    // getPostInfo();
  }

  @override
  build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<JokeModelTwoPart>(
      future: getPostInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  height: deviceSize.width / 8,
                  width: deviceSize.width / 8,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return SafeArea(
              child: Scaffold(
                body: Center(
                  child: Text(
                    snapshot.error.toString(),
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.hasData) {
              JokeModelTwoPart _jokeModel = snapshot.data;
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Center(
                      child: Text(
                        'What The Joke',
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
                        height: deviceSize.height * 1 / 8,
                        width: deviceSize.width * 0.9,
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
                        height: deviceSize.height * 1 / 8,
                        width: deviceSize.width * 0.9,
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
            } else {
              return SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Text(
                      'No Data',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        }
      },
    );
  }
}
