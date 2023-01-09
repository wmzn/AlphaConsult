import 'package:argon_flutter/widgets/card-horizontal.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:argon_flutter/screens/editdatawidget.dart';
import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:location/location.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.cases);

  final Cases cases;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();
  Location _location = Location();
  void activateLocation() async {
    await _location.requestPermission();
    if (await _location.hasPermission() == PermissionStatus.granted) {
      _navigateToEditScreen(context, widget.cases);
    } else {
      GFToast.showToast(
        'Il est nécessaire d\'activer la permission',
        context,
      );
    }
  }

  final ApiService api = ApiService();
  String pPation = "";
  String pProduit = "";
  String Secteur = "";
  String option = "";

  @override
  Widget build(BuildContext context) {
    if (widget.cases.potentielPation == "1") {
      pPation = "A";
    } else if (widget.cases.potentielPation == "2") {
      pPation = "B";
    } else if (widget.cases.potentielPation == "3") {
      pPation = "C";
    }
    if (widget.cases.potentielProduit == "1") {
      pProduit = "A";
    } else if (widget.cases.potentielProduit == "2") {
      pProduit = "B";
    } else if (widget.cases.potentielProduit == "3") {
      pProduit = "C";
    }
    if (widget.cases.Secteur == "1") {
      Secteur = "Public";
    } else {
      Secteur = "Privé";
    }
    return Scaffold(
      appBar: Navbar(
          title: "Detaille médecin",
          rightOptions: false,
          backButton: true,
          bgColor: ArgonColors.success),
      backgroundColor: ArgonColors.bgColorScreen,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(1.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(25.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.account_circle,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Nom  :" + widget.cases.NomDr,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Prénom :" + widget.cases.prenom,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.sticky_note_2_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Spécialité :" +
                                          ((widget.cases.Spicialite != null)
                                              ? widget.cases.Spicialite
                                              : " "),
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Option :" +
                                          (widget.cases.option != null
                                              ? widget.cases.option
                                              : " "),
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.call_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Téléphone :" + widget.cases.Phone,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " E-mail :" + widget.cases.email,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Secteur :" + Secteur,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Potentiel Pation :" + pPation,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.domain_outlined,
                                    color: ArgonColors.success),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Potentiel Produit :" + pProduit,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_on_outlined,
                                    color: ArgonColors.success),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " Adresse :" +
                                          widget.cases.Wilaya +
                                          " " +
                                          widget.cases.Commun +
                                          " " +
                                          widget.cases.Daira +
                                          " " +
                                          widget.cases.Route,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text),
                                    ),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: RaisedButton(
                                textColor: ArgonColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                onPressed: () {
                                  activateLocation();
                                },
                                child: Text('Modification',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                                color: Colors.blue,
                              ),
                            ),
                            RaisedButton(
                              textColor: ArgonColors.white,
                              color: ArgonColors.warning,
                              onPressed: () {
                                _confirmDialog();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text('Suppression',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Cases cases) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(cases)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                api.deleteCase(widget.cases.id);
                Navigator.pushReplacementNamed(context, '/elements');
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
