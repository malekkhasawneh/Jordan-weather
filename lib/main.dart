import 'package:citiesweather/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'CityWitherInformation.dart';
import 'FavoriteCitiesPage.dart';
import 'JordanianCitiesApi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cites Weather',
      home: SplachScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoriteCitiesPage()));},
                  icon: Icon(Icons.favorite,color: Colors.blue,),
                ),
                title: Text('All Cities',style: TextStyle(color: Colors.blue),),
                centerTitle: true,
                elevation: 20,
                floating: true,
                snap: true,
              )
            ];
          },
          body: Center(
            child: FutureBuilder(
              future: getCityInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<City> citiesInfo = snapshot.data as List<City>;
                  return Container(
                    width: size.width*0.99,
                    child: ListView.builder(
                        itemCount: citiesInfo.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CityInformation(
                                            id: citiesInfo[index].id,
                                          )),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              selected: true,
                              selectedTileColor: Colors.grey[300],
                              title: Text('${citiesInfo[index].name}'),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      'longitude : ${citiesInfo[index].coord.lon}',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        'latitude : ${citiesInfo[index].coord.lat}',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          );
                        }),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}
