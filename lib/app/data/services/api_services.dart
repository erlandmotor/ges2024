import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> post({
    required String endpoint,
    String? token,
    Map<String, dynamic>? request,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('${AppString.baseUrl}$endpoint'),
        headers: token != null
            ? {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token",
              }
            : {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
        body: request != null ? json.encode(request) : null,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<http.Response> get(
      {required String endpoint, String? parameter, String? token}) async {
    String url = parameter == null
        ? '${AppString.baseUrl}$endpoint'
        : '${AppString.baseUrl}$endpoint?$parameter';
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: token != null
            ? {
                "content-type": "application/json",
                "accept": "application/json",
                'authorization': 'Bearer $token',
              }
            : {
                "content-type": "application/json",
                "accept": "application/json",
              },
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
      throw Exception(e);
    }
  }

  static Future<Response> getData(
      {required String endpoint, required String token}) async {
    try {
      var response = await Dio().get(
        "${AppString.baseUrl}$endpoint",
        options: Options(
          headers: {
            // "Content-Type": "application/json",
            // "Accept": "application/json",
            'Authorization': "Bearer $token",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Message : ${e.message}");
        print("Error : ${e.error}");
        print("Response : ${e.response}");
        print("Type : ${e.type}");
        print("Request Options : ${e.requestOptions.responseType}");
      }
      // print("Stacktrace : ${e.stackTrace}");
      throw Exception(e.message);
    }
  }

  static Future<http.Response> delete(
      {required String endpoint, required String token}) async {
    try {
      var response = await http.delete(
        Uri.parse('${AppString.baseUrl}$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
