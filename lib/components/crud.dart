import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// String _basicAuth = 'Basic ' + base64Encode(utf8.encode('bh:123456bh'));
// Map<String, String> myheaders = {'authorization': _basicAuth};

mixin class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
        // final jsonData = utf8.decode(response.bodyBytes);
        // final decodedData = json.decode(jsonData);
        // return decodedData;
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Catch : $e");
      }
    }
  }

  postRequest(String url, Map data) async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      // var response = await http.post(Uri.parse(url), body: data);
      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));
      //json.encode(data) jsonEncode(data)
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        //print("responseBody Add :- " + responseBody.toString());
        return responseBody;
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
        return jsonDecode(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Catch : $e");
      }
    }
  }

  putRequest(String url, Map data) async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      // var response = await http.post(Uri.parse(url), body: data);
      var response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        //print("responseBody edit :- " + responseBody.toString());
        return responseBody;
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Catch : $e");
      }
    }
  }

  deleteRequest(String url) async {
    //await Future.delayed(const Duration(seconds: 3));
    try {
      // var response = await http.post(Uri.parse(url), body: data);
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        //print("responseBody delete :- " + responseBody.toString());
        return responseBody;
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Catch : $e");
      }
    }
  }

/*
  Future<List<ValueId>> getResponse(String serviceName) async {
    List<ValueId> data = [];
    final response =
        // await http.get(Uri.parse(MyConstants.getUrl(serviceName)),
        //     headers: {'Content-Type': 'application/json; charset=utf-8'});

        await http.get(Uri.parse("MyConstants.getUrl(serviceName)"),
            headers: {'Content-Type': 'application/json; charset=utf-8'});

    if (response.statusCode == 200) {
      final jsonData = utf8.decode(response.bodyBytes);
      final decodedData = json.decode(jsonData);

      data =
          List<ValueId>.from(decodedData.map((data) => ValueId.fromJson(data)));
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }*/
}

// class ValueId {
//   final int? id;
//   final String? name;

//   ValueId({this.id, this.name});

//   factory ValueId.fromJson(Map<String, dynamic> json) {
//     return ValueId(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }
