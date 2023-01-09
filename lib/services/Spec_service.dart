import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:argon_flutter/models/spec.dart';
import 'package:http/http.dart';

class SpecService {
  final apiUrl = "https://1.1.1.1/";
  Future<List<Spec>> getCases2() async {
    Response res = await get(Uri.parse(apiUrl + "getSpec"));
    print("response");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Spec> cases =
          body.map((dynamic item) => Spec.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }
}
