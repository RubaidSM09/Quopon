import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../common/app_constant/app_constant.dart';
import '../../common/helper/local_store.dart';
import '../modules/login/views/login_view.dart';

class BaseClient {
  static const _storage = FlutterSecureStorage();

  // Retrieve access token from secure storage
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Retrieve refresh token from secure storage
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  static Future<Map<String, String>> authHeaders() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  static Future<Map<String, String>> get basicHeaders async => {
    'Content-Type': 'application/json',
  };

  static getRequest({required String api, Map<String, String>? params, Map<String, String>? headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("Header: $headers");

    final resolvedHeaders = headers != null ? await headers : null;

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: resolvedHeaders,
    );
    return response;
  }

  static postRequest({required String api, body, headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    debugPrint("headers: $headers");
    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    debugPrint("<================= response ====== ${response.body} ===========>");

    return response;
  }
  static patchRequest({required String api, body,headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.patch(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static putRequest({required String api, body,headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }


  static deleteRequest({required String api, body,headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.delete(
      Uri.parse(api),
      headers: headers,
    );
    return response;
  }



  static handleResponse(http.Response response) async {
    try {
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        debugPrint('SuccessCode: ${response.statusCode}');
        debugPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {

        String msg = "Unauthorized";
        if (response.body.isNotEmpty) {
          if(json.decode(response.body)['errors'] != null){
            msg = json.decode(response.body)['errors'];
          }
        }
        throw msg;
      } else if (response.statusCode == 404) {
        print(response.body);
      }
      else if (response.statusCode == 400) {
        SnackBar(content: Text(json.decode(response.body)['message'].toString()));
        debugPrint('Response: ${response.body}');
      }
      else if(response.statusCode == 403){
        SnackBar(content: Text(json.decode(response.body)['message'].toString()));

      } else if(response.statusCode == 406){
        SnackBar(content: Text(json.decode(response.body)['message'].toString()));

      }
      else if(response.statusCode == 409){
        SnackBar(content: Text(json.decode(response.body)['message'].toString()));

      }else if (response.statusCode == 500) {
        SnackBar(content: Text(json.decode(response.body)['message'].toString()));
        throw "Server Error";
      } else {
        debugPrint('ErrorCode: ${response.statusCode}');
        debugPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body)['errors'];
          if(data == null){
            msg = jsonDecode(response.body)['message'] ?? msg;
          }
          else if (data is String) {
            msg = data;
          } else if (data is Map) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException catch (_) {
      throw "noInternetMessage";
    } on FormatException catch (e) {
      print(e);
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  static void logout() {
    LocalStorage.removeData(key: AppConstant.token);
    Get.offAll(()=> LoginView());
  }
}