import 'package:argon_flutter/models/Visite.dart';
import 'package:argon_flutter/screens/editvisite.dart';
import 'package:argon_flutter/services/Visite_service.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:location/location.dart';

class DetailVisite extends StatefulWidget {
  DetailVisite(this.visit);

  final VisiteM visit;

  @override
  _DetailVisiteState createState() => _DetailVisiteState();
}

class _DetailVisiteState extends State<DetailVisite> {
  _DetailVisiteState();
  Location _location = Location();
  void activateLocation() async {
    await _location.requestPermission();
    if (await _location.hasPermission() == PermissionStatus.granted) {
      _navigateToEditScreen(context, widget.visit);
    } else {
      GFToast.showToast(
        'Il est nécessaire d\'activer la permission',
        context,
      );
    }
  }

  final ApiVisiteService api = ApiVisiteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
          title: "Detaille Visite",
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
                                      " Nom :" + widget.visit.NomDr,
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
                                Icon(Icons.list_alt,
                                    color: ArgonColors.success),
                                if (widget.visit.V1 == "2")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " Profile prescription  :" + "Princeps",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: ArgonColors.text),
                                      ),
                                    ),
                                  )
                                else if (widget.visit.V1 == "1")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " Profile prescription  :" +
                                            "Génériques_u",
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
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V2 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 2  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V2 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 2  :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V3 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 3  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V3 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 3 :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V4 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 4 :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V4 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 4  :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V5 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 5  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V5 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 5  :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V6 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 6  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V6 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 6 :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V7 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 7  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V7 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 7  :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,
                      //               color: ArgonColors.success),
                      //           if (widget.visit.V8 == "2")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 8  :" + "Faut",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //           else if (widget.visit.V8 == "1")
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 0.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Text(
                      //                   " Valeur 8  :" + "vrai",
                      //                   style: TextStyle(
                      //                       fontSize: 19,
                      //                       color: ArgonColors.text),
                      //                 ),
                      //               ),
                      //             )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.list_alt,
                                    color: ArgonColors.success),
                                if (widget.visit.V9 == "1")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " Etat de rapport :" + " Validé",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: ArgonColors.text),
                                      ),
                                    ),
                                  )
                                else if (widget.visit.V9 == "2")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " Etat de rapport  :" + " Non Validé",
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
                                Icon(Icons.list_alt,
                                    color: ArgonColors.success),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "  Observation  :" + widget.visit.Rapport,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontSize: 16,
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.list_alt,
                                    color: ArgonColors.success),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "  Objection  :" + widget.visit.ob,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontSize: 16,
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

  _navigateToEditScreen(BuildContext context, VisiteM visit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditVisite(visit)),
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
                api.deleteVisite(widget.visit.id);
                Navigator.pushReplacementNamed(context, '/Visite');
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
