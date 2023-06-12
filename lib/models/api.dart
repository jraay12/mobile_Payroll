import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mobile_appdev_integrated/models/api_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  Api.privateConstructor();
  static final Api instance = Api.privateConstructor();
  
  
  

  var url = "";

  Future login(var data) async {
    try {
      var url = Uri.parse("http://10.170.2.38:8000/login");
      var response = await http.post(
        url,
        body: convert.jsonEncode(data),
        headers: {"Content-type": "application/json"},
      );
      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data']['token'] ?? {},
      );
      return apiResponse;
    } catch (error) {
      return error;
    }
  }

  Future addUser(var data) async {
    // Implement the logic to add a user
  }

  Future getUser(String token) async {
    try {
      var url = Uri.parse("http://10.170.2.38:8000/getUser");
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {},
      );
      return apiResponse;
    } catch (error) {
      ApiResponse apiResponse = ApiResponse(
        status: 'fail',
        message: "Request Error: $error",
        data: "",
      );
      return apiResponse;
    }
  }

  Future getProfileData(String token) async {
    try {
      var url = Uri.parse("http://10.170.2.38:8000/profile");
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {},
      );
      return apiResponse;
    } catch (error) {
      ApiResponse apiResponse = ApiResponse(
        status: 'fail',
        message: "Request Error: $error",
        data: "",
      );
      return apiResponse;
    }
  }

  Future getPayrollData(String token) async {
    try {
      var url = Uri.parse("http://10.170.2.38:8000/payroll");
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      var jsonResponse = await convert.jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse(
        status: jsonResponse['status'],
        message: jsonResponse['message'],
        data: jsonResponse['data'] ?? {},
      );
      return apiResponse;
    } catch (error) {
      ApiResponse apiResponse = ApiResponse(
        status: 'fail',
        message: "Request Error: $error",
        data: "",
      );
      return apiResponse;
    }
  }
}
