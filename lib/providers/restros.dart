import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/restros.dart';

class RestroProvider with ChangeNotifier {
  List<Restro> _restros = [];
  List<Restro> get restros {
    return [..._restros];
  }

  Future<dynamic> getRestros(context) async {
    try {
      dynamic uri = Uri.parse("https://run.mocky.io/v3/dc974d1e-2c0d-4d79-a60d-158916102299");
      final response = await http.get(uri, headers: {});
      print(json.decode(response.body));

      var profileData = json.decode(response.body);
      final List<Restro> loadedRestros = [];
      var content = profileData['content'] as Map;
      final List<dynamic> data = content['data'];

      for (int i = 0; i < data.length; i++) {
        loadedRestros.add(
          Restro(
            name: data[i]['name']??"",
            address: data[i]['address']??"",
            cost: data[i]['cost_for_two']??800,
            rating: data[i]['rating']??4.0,
            hours: data[i]['hours']??"",
            imageUrl: data[i]['imageUrl']??"",
            phone: data[i]['phone']??""
          )
          );

        _restros = loadedRestros.toList();

        notifyListeners();
      }
    } catch (e) {
      print(e);

    }
  }
}
