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
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xff88bef5),
          elevation: 0,
        ),
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
  }

  @override
  build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return FutureBuilder<JokeModelTwoPart>(
      future: getPostInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                height: deviceSize.width / 8,
                width: deviceSize.width / 8,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  snapshot.error.toString(),
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 24 * curScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.hasData) {
              JokeModelTwoPart _jokeModel = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text(
                      'Jokely',
                      style: TextStyle(
                        fontSize: 28 * curScaleFactor,
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
                          fontSize: 22 * curScaleFactor,
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
                          fontSize: 22 * curScaleFactor,
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
                        color: Color(0xfff88bef5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: MaterialButton(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 24 * curScaleFactor,
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
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text(
                    'No Data',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24 * curScaleFactor,
                      fontWeight: FontWeight.bold,
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
