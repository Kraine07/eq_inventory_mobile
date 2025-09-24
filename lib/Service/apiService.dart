import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService extends ChangeNotifier {

  // final String baseURL = "http://10.0.2.2:3000";
  final String baseURL = "http://127.0.0.1:3000";
  // final String baseURL = "https://domestic-anderea-kraine-inc-7fd764af.koyeb.app";


  Future<Response> get( String endpoint, Map<String, String?> params) async {
    final response = await http.get(
      Uri.parse('$baseURL/$endpoint').replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    ).timeout(Duration(seconds: 10));

    return response;
  }







  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic> params = const {},
    int retries = 3,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    int attempt = 0;
    late http.Response response;

    while (attempt < retries) {
      try {
        response = await http
            .post(
          Uri.parse('$baseURL/$endpoint').replace(queryParameters: params),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        )
            .timeout(timeout);

        return response; // success, return immediately
      } on TimeoutException {
        attempt++;
        if (attempt >= retries) rethrow; // give up after retries
        await Future.delayed(const Duration(seconds: 2)); // backoff before retry
      } catch (e) {
        rethrow; // for other exceptions, don't retry
      }
    }

    return response;
  }




// Future<Response> post(
  //     {required String endpoint,
  //       required Map<String, dynamic> data,
  //       Map<String, dynamic> params = const {}}) async {
  //
  //   final response = await http.post(
  //     Uri.parse('$baseURL/$endpoint')
  //         .replace(queryParameters: params),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8'
  //     },
  //     body: jsonEncode(data),
  //   ).timeout(Duration(seconds: 30));
  //
  //   return response;
  // }
}
