import 'package:flutter/material.dart';

// this is the starting point of a Flutter app
// when you press the RUN button, the IDE will look inside this file and search for the 'main' method and run the code inside it
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          "I Am Rich",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: Center(
        child: Image(
          // image: NetworkImage(
          //     'https://static.vecteezy.com/system/resources/thumbnails/008/513/899/small_2x/blue-diamond-illustration-png.png'),
          image: AssetImage('images/diamond.png'),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    ),
  ));
}
