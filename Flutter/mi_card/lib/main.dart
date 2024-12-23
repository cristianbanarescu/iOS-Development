import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          // SafeArea - widget to use in order to not place content inside the top notch, or bottom bar, etc
          child: Column(
            // arrange widgets vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/developer.png'),
              ),
              Text(
                "Cristian Banarescu",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DancingScript-VariableFont_wght',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                'Aspiring Flutter developer'.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'SourceSans3-VariableFont_wght',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 200,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  // padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+40 111 223 999'),
                  )),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  // padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('images/github.png'),
                      width: 25,
                    ),
                    title: Text(
                        'https://github.com/cristianbanarescu/iOS-Development'),
                  )),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  // padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('images/linkedin.png'),
                      width: 25,
                    ),
                    title: Text(
                        'https://www.linkedin.com/in/cristian-alexandru-banarescu/'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// Image(image: AssetImage('images/developer.png')

/*
Container(
            // Container - single child widget
            color: Colors.white,
            margin: EdgeInsets.all(
                80), // there are multiple options from EdgeInsets
            padding: EdgeInsets.all(30),
            child: Text('Hello Cristian!'), // distance inside a widget,
            // so inside the Container (the distance between Text and Container)
          )
 */

/*
some mock code here; to use as reference/demo

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          // SafeArea - widget to use in order to not place content inside the top notch, or bottom bar, etc
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.yellow,
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      color: Colors.lightGreen,
                      width: 100,
                      height: 100,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


 */
