import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stadium_app/model/stadium.dart';

class StadiumRepo {
  List<Stadium> stadiums = [];

  Future<List<Stadium>> getStadiums() async {
    // load json from assets

    var jsonString = await rootBundle.loadString('assets/data/stadiums.json');
    var jsonData = jsonDecode(jsonString);
    for (var item in jsonData) {
      stadiums.add(Stadium.fromJson(item));
    }
    return stadiums;
  }

  List<Stadium> filterStadiums(String query) {
    //optimize the below code using switch method
    return stadiums
        .where((stadium) =>
            stadium.city.toLowerCase().contains(query.toLowerCase()) ||
            stadium.status.toLowerCase().contains(query.toLowerCase()) ||
            stadium.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
