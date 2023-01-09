import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/screens/LogingScreen.dart';
import 'package:http/http.dart';

class ApiService {
  final apiUrl = "https://1.1.1.1/";
  Future<List<Cases>> getCases2() async {
    Response res = await get(Uri.parse(apiUrl + "gethuman"));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();

      return cases.reversed.toList();
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<List<Cases>> getCases() async {
    Map data = {
      "id": Loginscreenn.id,
    };
    Response res = await post(Uri.parse(apiUrl + "gethuman/id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Cases> getCaseById(String id) async {
    final response = await get(Uri.parse('$apiUrl/$id'));
    Map data = {
      "NomContact": Loginscreenn.id,
    };
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      "Lng": cases.Lng,
      "Lat": cases.Lat,
      "NomDr": cases.NomDr,
      "NomVm": cases.NomVm,
      "NomContact": Loginscreenn.id,
      "Phone": cases.Phone,
      "Spicialite": cases.Spicialite,
      "Secteur": cases.Secteur,
      "Wilaya": cases.Wilaya,
      "Commun": cases.Commun,
      "Daira": cases.Daira,
      "CodeP": cases.CodeP,
      "Route": cases.Route,
      "prenom": cases.prenom,
      "email": cases.email,
      "option": cases.option,
      "potentielPation": cases.potentielPation,
      "potentielProduit": cases.potentielProduit,
    };

    final Response response = await post(
      Uri.parse(apiUrl + "Ajouterhuman"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print("ok2");

    if (response.statusCode == 200) {
      print("ok");
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Cases> updateCases(Cases cases) async {
    Map data = {
      'id': cases.id,
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      "Lng": cases.Lng,
      "Lat": cases.Lat,
      "NomDr": cases.NomDr,
      "NomVm": cases.NomVm,
      "NomContact": Loginscreenn.id,
      "Phone": cases.Phone,
      "Spicialite": cases.Spicialite,
      "Secteur": cases.Secteur,
      "Wilaya": cases.Wilaya,
      "Commun": cases.Commun,
      "Daira": cases.Daira,
      "CodeP": cases.CodeP,
      "Route": cases.Route,
      "prenom": cases.prenom,
      "email": cases.email,
      "option": cases.option,
      "potentielPation": cases.potentielPation,
      "potentielProduit": cases.potentielProduit,
    };
    print('\x1B[33m okokokok\x1B[0m');
    print(data);
    final Response response = await post(
      Uri.parse('$apiUrl' + "modificationhuman"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print("update3");
    if (response.statusCode == 200) {
      print(response.body);

      print("update4");

      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String id) async {
    Map data = {
      'id': id,
    };
    Response res = await post(
      Uri.parse('$apiUrl' + "deletehuman"),
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
