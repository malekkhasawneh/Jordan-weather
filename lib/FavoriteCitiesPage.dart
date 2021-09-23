import 'package:citiesweather/FavoriteMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteCitiesPage extends StatelessWidget {
  final Favorite favoriteCities = Favorite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context)
          ;
        }, icon: Icon(Icons.arrow_back_sharp, size: 30, color: Colors.black,)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Favorite Cities',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cities').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              var cityInfo = snapshot.data!.docs;
              return ListView(
                children: cityInfo.map((favoriteCitiesInfo) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        favoriteCitiesInfo.reference.delete();
                                        removeCityToast(favoriteCitiesInfo);
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                '${favoriteCitiesInfo['name']}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: favoriteCitiesInfo['weather'] == 'Clear' ? Icon(Icons.wb_sunny,size:100,color:Colors.yellow) :
                              Icon(Icons.cloud,size:100,color:Colors.grey),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                'Weather : ${favoriteCitiesInfo['weather']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Weather Description : ${favoriteCitiesInfo['weatherDescription']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Temperature : ${(favoriteCitiesInfo['temperature'] -
                                    273.15).round()}°',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 50),
                              child: Text(
                                'Wind Speed: ${favoriteCitiesInfo['windSpeeed']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 15, left: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Saved in : ${favoriteCitiesInfo['saveDate']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                  );
            }
          }
          return Center(
            child: Column(children: [
              Text(
                'You don\'t added cities to favorite yet',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ], mainAxisAlignment: MainAxisAlignment.center),
          );
        },
      ),
    );
  }

  void removeCityToast(QueryDocumentSnapshot<Object?> favoriteCitiesInfo) {
     Fluttertoast.showToast(
        msg: '${favoriteCitiesInfo['name']} Deleted',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }
}
