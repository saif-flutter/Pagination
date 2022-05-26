import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/passenger_model.dart';

class PaginationRepo {
 // List<Data> passengers = [];
  static int currentPage = 10;
  // static int totalPages =0;

  static Future<PassengerModel?> getPassenger({bool isRefresh = true}) async {

    if(isRefresh == true) {
      currentPage = 10;
    }else{
      currentPage+=10;

    }
    var response = await http.get(Uri.parse(
        'https://api.instantwebtools.net/v1/passenger?page=0&size=$currentPage'));

    print('================<<<<<<<<+>>>>>>>>>>>>>>>');
    print('=========${response.body}');

    debugPrint("${response.statusCode}");

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);


      print('==========>> cp  $currentPage');

       //totalPages = currentPage;
      print(response.body);

      return PassengerModel.fromJson(jsonData);
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }
}
