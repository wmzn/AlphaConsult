import 'package:flutter/material.dart';
import 'dart:async';

import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/screens/adddatawidget.dart';
import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:argon_flutter/screens/caseslist.dart';
//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/table-cell.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:location/location.dart';

class Elements extends StatefulWidget {
  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  final ApiService api = ApiService();
  List<Cases> casesList;
  TextEditingController editingController = TextEditingController();
  Location _location = Location();

  bool switchValueOne;
  bool switchValueTwo;
  void activateLocation() async {
    await _location.requestPermission();
    if (await _location.hasPermission() == PermissionStatus.granted) {
      _navigateToAddScreen(context);
    } else {
      GFToast.showToast(
        'Il est nécessaire d\'activer la permission',
        context,
      );
    }
  }

  void initState() {
    setState(() {
      switchValueOne = true;
      switchValueTwo = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (casesList == null) {
      casesList = List<Cases>();
    }
    return Scaffold(
      appBar: Navbar(
        title: "Docteur",
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Elements"),
      body: new Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: ArgonColors.text,
                    ),
                    labelStyle: TextStyle(color: ArgonColors.success),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: ArgonColors.success,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: ArgonColors.success,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    labelText: "Recherche ",
                    hintText: "Recherche",
                    prefixIcon: Icon(
                      Icons.search,
                      color: ArgonColors.success,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: new Center(
                  child: new FutureBuilder(
                future: loadList(),
                builder: (context, snapshot) {
                  return casesList.length > 0
                      ? new CasesList(cases: casesList)
                      : new Center(
                          child: new Text('Pas d\information',
                              style: Theme.of(context).textTheme.title));
                },
              )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          activateLocation();
        },
        tooltip: 'Increment',
        backgroundColor: ArgonColors.success,
        child: Icon(Icons.add),
      ),
    );
  }

  void filterSearchResults(String query) {
    // print("\x1B[31mdouble\x1B[0m");

    // print("\x1B[31m$duplicateItems\x1B[0m");

    List<Cases> dummySearchList;
    dummySearchList = casesList;

    if (query.isNotEmpty) {
      List<Cases> dummyListData = List<Cases>();

      dummySearchList.forEach((item) {
        if (item.NomDr.contains(query)) {
          print("\x1B[31m$query\x1B[0m");

          dummyListData.add(item);
        }

        setState(() {
          this.casesList = dummyListData;

          // print("\x1B[31m$dummyListData\x1B[0m");
        });
      });
      print(dummyListData);
      return;
    } else {}
  }

  Future loadList() {
    Future<List<Cases>> futureCases = api.getCases();
    futureCases.then((casesList) {
      setState(() {
        this.casesList = casesList;
        filterSearchResults(editingController.text);
      });
    });
    return futureCases;
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
