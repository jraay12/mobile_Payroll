import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_appdev_integrated/models/api_response.dart';


import 'package:http/http.dart' as http;


class Api {

  Api.privateConstructor();
  static final Api instance = Api.privateConstructor();

  var url = "[http://192.168.95.215:8000/login].";

  Future login(var data) async {
    try {
      var response = await http.post(Uri.parse(url), body: convert.jsonEncode(data),
          headers: {"Content-type" : "application/json"});

      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {}
      );
      return apiResponse;
    }
    catch (error) {
      return error;
    } 
     //var response = await http.post()

  }

  Future addUser(var data) async {

  }

  Future getUser(String token) async {
    try {
      var response = await http.post(Uri.parse(url), headers: {'Authorization' : 'Bearer $token'});
      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {}
      );
      return apiResponse;
    }
    catch(error) {
      return error;
    }
  }


}