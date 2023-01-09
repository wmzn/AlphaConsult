import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:argon_flutter/models/Visite.dart';
import 'package:argon_flutter/screens/LogingScreen.dart';
import 'package:http/http.dart';

class ApiVisiteService {
  final apiUrl = "https://1.1.1.1/";
  Map data = {
    "id": Loginscreenn.id,
  };
  Future<List<VisiteM>> getVisites() async {
    Response res = await post(Uri.parse(apiUrl + "getVisite/id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<VisiteM> Visites =
          body.map((dynamic item) => VisiteM.fromJson(item)).toList();
      return Visites.reversed.toList();
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<VisiteM> getCaseById(String id) async {
    final response = await get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return VisiteM.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<VisiteM> createVisite(VisiteM Visites) async {
    Map data = {
      "NomDr": Visites.NomDr,
      "NomDrid": Visites.NomDrid,
      "V1": Visites.V1,
      "V2": Visites.V2,
      "V3": Visites.V3,
      "V4": Visites.V4,
      "id": Loginscreenn.id,
      "V5": Visites.V5,
      "V6": Visites.V6,
      "V7": Visites.V7,
      "V8": Visites.V8,
      "V9": Visites.V9,
      "Rapport": Visites.Rapport,
      "Lat": Visites.Lat,
      "Lng": Visites.Lng,
      "ob": Visites.ob
    };
    print('\x1B[33m $data\x1B[0m');
    final Response response = await post(
      Uri.parse(apiUrl + "AjouterVisite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print("ok");
      return VisiteM.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<VisiteM> updateVisite(VisiteM Visites) async {
    Map data = {
      'id': Visites.id,
      "NomDrid": Visites.NomDrid,
      "NomDr": Visites.NomDr,
      "V1": Visites.V1,
      "V2": Visites.V2,
      "V3": Visites.V3,
      "V4": Visites.V4,
      "V5": Visites.V5,
      "V6": Visites.V6,
      "V7": Visites.V7,
      "V8": Visites.V8,
      "V9": Visites.V9,
      "NomContact": Loginscreenn.id,
      "Rapport": Visites.Rapport,
      //"Lat": Visites.Lat,
      //"Lng": Visites.Lng,
      "ob": Visites.ob
    };
    print('\x1B[33m okokokok\x1B[0m');
    print(data);
    final Response response = await post(
      Uri.parse('$apiUrl' + "modificationVisite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print("update3");
    if (response.statusCode == 200) {
      print(response.body);

      print("update4");

      return VisiteM.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteVisite(String id) async {
    Map data = {
      'id': id,
    };
    Response res = await post(
      Uri.parse('$apiUrl' + "deleteVisite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}
