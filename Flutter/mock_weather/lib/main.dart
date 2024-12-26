import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  'Timisoara',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
          ),
          leading: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.blur_circular,
              color: Colors.white,
              size: 30,
            ),
          ),
          actions: [
            Icon(
              Icons.more_vert_sharp,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
          ],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Text(
                  '• Updating',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(
                'Image taken from Vecteezy.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Image(
                image: AssetImage('images/sun_clouds.jpg'),
                width: 200,
                height: 200,
              ),
              Text(
                '10º',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Cloudy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              Text(
                'Thursday, 26 Dec',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  thickness: 0.3,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage('images/wind.png'),
                        color: Colors.white,
                      ),
                      Text(
                        '25 km/h',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Windy',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                          image: AssetImage('images/water_drop.png'),
                          color: Colors.white),
                      Text(
                        '80%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Humidity',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                          image: AssetImage('images/snowflake.png'),
                          color: Colors.white),
                      Text(
                        '67%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Chance of snow',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
