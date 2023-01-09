import 'package:argon_flutter/models/LoginModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://1.1.1.1/loginreparation";
    print(requestModel.toJson());
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    print("not enter ");
    print(response.body);
    print("not enter 2");

    if (response.statusCode == 200 || response.statusCode == 400) {
      print("enter ");
      print(json.decode(response.body));

      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      if (response.body == '"Username incorrect"') {
        print("yessssssssssssssss");
        return LoginResponseModel.fromJson(
          json.decode(
              '{"success":false,"msg":"Authentication failed, wrong password"}'),
        );
      }
      print("response.body");

      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    }
  }
}
