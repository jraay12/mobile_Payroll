import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_appdev_integrated/models/api_response.dart';


class Api {

  Api.privateConstructor();
  static final Api instance = Api.privateConstructor();

  var url = "";

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