import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  void addCityToFavorite({
    required String name,
    required String weather,
    required double windSpeed,
    required double temperature,
    required String weatherDescription,
  required String saveDate}) async {
    await FirebaseFirestore.instance.collection('cities').doc().set({
      'name': name,
      'weather': weather,
      'windSpeeed': windSpeed,
      'temperature': temperature,
      'weatherDescription': weatherDescription,
      'saveDate':saveDate,
    });
  }
}


