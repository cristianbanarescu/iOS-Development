import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("I Am Poor"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Image(
          image: AssetImage(
            'images/coal.png',
          ),
        ),
      ),
    ),
  ));
}
