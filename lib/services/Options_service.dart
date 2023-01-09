import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:argon_flutter/models/Options.dart';
import 'package:http/http.dart';

class OptionsService {
  final apiUrl = "https://1.1.1.1/";
  Future<List<Options>> getOptions() async {
    Response res = await get(Uri.parse(apiUrl + "getoption"));
    print("response");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Options> cases =
          body.map((dynamic item) => Options.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }
}
