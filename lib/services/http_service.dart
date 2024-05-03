import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

@immutable
sealed class NetworkService {
  static const String _baseUrl = "dummyjson.com";
  static const String apiLogin = "/auth/login";
  static const String apiAllProducts = "/products";
  static const String apiSearchProducts = "/products/search";
  static const Map<String, String> _headers = {"Content-Type": "application/json"};
  static Map<String, dynamic> searchParam(String text) => <String, dynamic> {"q": text};

  static Future<String?> getDate({required String api, Map<String, dynamic>? param}) async {
    Uri url = Uri.https(_baseUrl, api, param ?? const <String, dynamic> {});

    try{
      Response response = await get(url, headers: _headers);
      if([200, 201].contains(response.statusCode)) return response.body;
    } catch(e){
      return null;
    }
    return null;
  }

  static Future<String?> postDate({required String api, required Map<String, dynamic> body, Map<String, dynamic>? param}) async {
    Uri url = Uri.https(_baseUrl, api, param ?? const <String, dynamic> {});

    try{
      Response response = await post(url, body: json.encode(body), headers: _headers);
      if([200, 201].contains(response.statusCode)) return response.body;
    } catch(e){
      return null;
    }
    return null;
  }

  static Future<String?> updateDate({required String api, required Map<String, dynamic> body, Map<String, dynamic>? param}) async {
    Uri url = Uri.https(_baseUrl, api, param ?? const <String, dynamic> {});

    try{
      Response response = await put(url, body: json.encode(body), headers: _headers);
      if([200, 201].contains(response.statusCode)) return response.body;
    } catch(e){
      return null;
    }
    return null;
  }
}