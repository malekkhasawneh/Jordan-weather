import 'dart:async';
import 'package:citiesweather/main.dart';
import 'package:flutter/material.dart';


class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 220),
              child: Container(
                width: 190,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/splachLogo.png'), fit: BoxFit.fill),
                ),
              ),
            ),
             Text(
                'Jordan Weather',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 220),
              child: Text(
                'Done By malek Khasawneh',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}