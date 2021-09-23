import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'FavoriteCitiesPage.dart';
import 'FavoriteMethods.dart';
import 'WitherApi.dart';

class CityInformation extends StatefulWidget {
  final int id;

  CityInformation({required this.id});

  @override
  _CityInformationState createState() => _CityInformationState();
}

class _CityInformationState extends State<CityInformation> {
  Favorite addToFavorite = Favorite();
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
            future: getCityWeather(widget.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text('Can\'t View Data Now'),
                );
              else if (snapshot.hasData) {
                final Weather weatherInfo = snapshot.data as Weather;
                return ListView.builder(
                    itemCount: weatherInfo.weather!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            height: 445,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "images/cityInformationBackground.jpg"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Center(
                              child: Stack(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_sharp,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, top: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FavoriteCitiesPage()));
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      )),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 100,
                                      ),
                                      child: Text(
                                        weatherInfo.name!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        '${_date.toString().split(' ')[0]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: weatherInfo.weather![index].main ==
                                              'Clear'
                                          ? Icon(
                                              Icons.wb_sunny,
                                              size: 120,
                                              color: Colors.yellow,
                                            )
                                          : Icon(
                                              Icons.cloud,
                                              size: 120,
                                              color: Colors.white,
                                            ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 17, left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${(weatherInfo.main!.temp! - 273.15).round()}°',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 45),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Max',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '${(weatherInfo.main!.tempMax! - 273.15).round()}°',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  ' | ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Min',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '${(weatherInfo.main!.tempMin! - 273.15).round()}°',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 470),
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width * 0.73,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, left: 15),
                                      child: Text(
                                        'Weather : ${weatherInfo.weather![index].main}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: size.width * 0.73,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 15, left: 15),
                                        child: Text(
                                          'Description : ${weatherInfo.weather![index].description}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: size.width * 0.73,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 15, left: 15),
                                        child: Text(
                                          'Wind Speed : ${weatherInfo.wind!.speed}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 7,right: 10),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                          onPressed: () {
                                            addCityToFavorite(
                                                weatherInfo, index);
                                            addCityToast(weatherInfo);
                                          },
                                          icon: Icon(
                                            Icons.favorite_border,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  void addCityToast(Weather weatherInfo) {
    Fluttertoast.showToast(
        msg: '${weatherInfo.name.toString()} Added To Favorite',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }

  void addCityToFavorite(Weather weatherInfo, int index) {
    addToFavorite.addCityToFavorite(
        name: weatherInfo.name.toString(),
        weather: weatherInfo.weather![index].main.toString(),
        windSpeed: weatherInfo.wind!.speed,
        temperature: weatherInfo.main!.temp!.toDouble(),
        weatherDescription: weatherInfo.weather![index].description.toString(),
        saveDate: _date.toString().split(' ')[0] +
            '  At  ' +
            _date.hour.toString() +
            ':' +
            _date.minute.toString());
  }
}
