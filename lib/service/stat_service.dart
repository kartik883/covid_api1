import 'dart:convert';

import 'package:covid_tracker/utilities/appurl.dart';
import 'package:covid_tracker/worlddatamodel.dart';
import 'package:http/http.dart' as http;

class statesService {
  Future<Worlddatamodel> fetchworldstat() async {
    final response = await http.get(Uri.parse(AppUrl.worldstateapi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Worlddatamodel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countrieslist() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countrieslist));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
