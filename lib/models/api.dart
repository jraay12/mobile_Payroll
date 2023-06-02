import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mobile_appdev_integrated/models/api_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {

  Api.privateConstructor();
  static final Api instance = Api.privateConstructor();

  var baseURL = "${dotenv.env['API_URL']}";

  Future login(var data) async {
    try {
      var url = Uri.parse("$baseURL/login");

      var response = await http.post(url, body: convert.jsonEncode(data),
          headers: {"Content-type" : "application/json"});

      var jsonResponse = await convert.jsonDecode(response.body);

      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data']['token'] ?? {}
      );

      return apiResponse;
    }
    catch (error) {
      ApiResponse apiResponse = ApiResponse(
          status: 'fail',
          message: "Request Error: $error",
          data: ""
      );
      return apiResponse;
    }
  }

  Future logout(var data) async {
    try {
      var url = Uri.parse("$baseURL/logout");

      var response = await http.post(url, body: convert.jsonEncode(data),
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
      ApiResponse apiResponse = ApiResponse(
          status: 'fail',
          message: "Request Error: $error",
          data: ""
      );
      return apiResponse;
    }
  }

  Future addUser(var data) async {

  }

  Future getUser(String token) async {
    try {
      var url = Uri.parse("$baseURL/getUser");

      var response = await http.get(url, headers: {'Authorization' : 'Bearer $token'});

      var jsonResponse = await convert.jsonDecode(response.body);

      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {}
      );
      return apiResponse;
    }
    catch(error) {
      ApiResponse apiResponse = ApiResponse(
          status: 'fail',
          message: "Request Error: $error",
          data: ""
      );
      return apiResponse;
    }
  }


}