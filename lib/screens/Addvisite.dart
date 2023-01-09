import 'package:argon_flutter/models/Visite.dart';
import 'package:argon_flutter/models/spec.dart';
import 'package:argon_flutter/services/Spec_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/Visite_service.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:search_choices/search_choices.dart';
import 'package:getwidget/getwidget.dart';
import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/inputNumber.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

enum Gender { male, female }
enum Status { positive, dead, recovered }

class AddVisite extends StatefulWidget {
  AddVisite();

  @override
  _AddVisiteState createState() => _AddVisiteState();
}

class _AddVisiteState extends State<AddVisite> {
  final ApiService api2 = ApiService();
  final ApiVisiteService api = ApiVisiteService();
  final SpecService apiSpec = SpecService();

  List<Cases> casesList;
  List<Spec> specList;

  static String selectedValueSingleDialog;
  static String selectedValueSingleDialog2;
  static String selectedValueSingleDialog3;

  int groupValue = 0;
  int groupValue2 = 0;
  var _rapport = TextEditingController();
  var _ob = TextEditingController();

  int groupValue3 = 0;
  int groupValue4 = 0;
  int groupValue5 = 0;
  int groupValue6 = 0;
  int groupValue7 = 0;
  int groupValue8 = 0;
  int groupValue9 = 0;

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  Future loadList() {
    Future<List<Cases>> futureCases = api2.getCases();
    futureCases.then((casesList) {
      setState(() {
        this.casesList = casesList;
      });
      casesList.forEach((word) {
        items.add(DropdownMenuItem(
          child: Text(word.NomDr + " " + word.prenom),
          value: word.id + "," + word.NomDr + " " + word.prenom,
        ));
      });
    });
    return futureCases;
  }

  @override
  void initState() {
    current();
    loadList();
    super.initState();
  }

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  final List<DropdownMenuItem> items = [];
  var _NomVm = TextEditingController();
  var _NomContact = TextEditingController();
  var _Phone = TextEditingController();
  var _Spicialite = TextEditingController();
  var _Secteur = TextEditingController();
  var _NomDr = TextEditingController();
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      current();
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  bool _serviceEnabled;

  String _lat;
  String _lng;
  void current() async {
    _serviceEnabled = await _location.serviceEnabled();
    print(_serviceEnabled);
    await _location.getLocation();
    _location.onLocationChanged.listen((l) {
      _lat = l.latitude.toString();
      _lng = l.longitude.toString();
    });
  }

  final Set<Marker> _markers = {};
  var _selectedPlace;

  void _onAddMarkerButtonPressed(LatLng latlang) {
    print("ok2");
    print(latlang);
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("12"),
        position: latlang,
        infoWindow: InfoWindow(

            //  snippet: '5 Star Rating',
            ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('marker_id_1'): Marker(
      markerId: MarkerId('marker_id_1'),
      position: LatLng(30.0444, 31.235),
      infoWindow: InfoWindow(title: 'marker_id_1', snippet: '*'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },
    )
  };
  _AddVisiteState();
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String gender = 'male';
  Gender _gender = Gender.male;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  Key Header1;

  String _mapController = 'false';
  bool selectedmap = true;
  bool selectedmap2 = false;

  String _Wilaya = '';
  String _Daira = '';
  String _Route = '';
  String _Pcode = '';

  var kInitialPosition = LatLng(-33.8567844, 151.213108);

  String _Commune = '';

  String status = 'positive';
  Status _status = Status.positive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
          title: "Ajouter Visite ",
          rightOptions: false,
          backButton: true,
          transparent: false,
          bgColor: ArgonColors.success),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Elements"),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Docteur",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: SearchChoices.single(
                                  style: TextStyle(
                                      height: 0.85,
                                      fontSize: 14.0,
                                      color: ArgonColors.initial),
                                  items: items,
                                  value: selectedValueSingleDialog3,
                                  hint: "Sélectionner un Docteur",
                                  searchHint: "Sélectionner un Docteur",
                                  underline: Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.teal,
                                                width: 3.0))),
                                  ),
                                  iconEnabledColor: Colors.indigo,
                                  onChanged: (value) {
                                    print("hy");
                                    print(value.split(",")[0]);
                                    selectedValueSingleDialog3 = value;
                                    setState(() {
                                      selectedValueSingleDialog =
                                          value.split(",")[0];
                                      selectedValueSingleDialog2 =
                                          value.split(",")[1];
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Observation",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  min: 5,
                                  max: 3000,
                                  controller: _rapport,
                                  placeholder: "Observation",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Objection",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  min: 5,
                                  max: 3000,
                                  controller: _ob,
                                  placeholder: "Objection",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Profile prescription",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: GFCard(
                                    content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("Princeps",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 1,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("Génériques",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 2,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.DANGER,
                                      radioColor: GFColors.DANGER,
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 2",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue2,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue2 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue2,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue2 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 3",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue3,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue3 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue3,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue3 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 4",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue4,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue4 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue4,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue4 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 5",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue5,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue5 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue5,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue5 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 6",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue6,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue6 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue6,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue6 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 7",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue7,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue7 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue7,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue7 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Valeur 8",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: GFCard(
                        //             content: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("Vrai",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 1,
                        //               groupValue: groupValue8,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue8 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.SUCCESS,
                        //               radioColor: GFColors.SUCCESS,
                        //             ),
                        //             Text("Faut",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.text,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //             GFRadio(
                        //               type: GFRadioType.square,
                        //               size: GFSize.LARGE,
                        //               value: 2,
                        //               groupValue: groupValue8,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   groupValue8 = value;
                        //                 });
                        //               },
                        //               inactiveIcon: null,
                        //               activeBorderColor: GFColors.DANGER,
                        //               radioColor: GFColors.DANGER,
                        //             ),
                        //           ],
                        //         )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Etat ",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: GFCard(
                                    content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("validé",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 1,
                                      groupValue: groupValue9,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue9 = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("Non validé ",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 2,
                                      groupValue: groupValue9,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue9 = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.DANGER,
                                      radioColor: GFColors.DANGER,
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (selectedmap) {
                                    print("test");
                                    print(selectedValueSingleDialog);
                                    print(_addFormKey.currentState);
                                    if (_addFormKey.currentState.validate()) {
                                      _addFormKey.currentState.save();

                                      api.createVisite(VisiteM(
                                          NomDr: selectedValueSingleDialog2,
                                          NomDrid: selectedValueSingleDialog,
                                          V1: groupValue.toString(),
                                          V2: groupValue2.toString(),
                                          V3: groupValue3.toString(),
                                          V4: groupValue4.toString(),
                                          V5: groupValue5.toString(),
                                          V6: groupValue6.toString(),
                                          V7: groupValue7.toString(),
                                          V8: groupValue8.toString(),
                                          V9: groupValue9.toString(),
                                          Lat: _lat,
                                          Lng: _lng,
                                          Rapport: _rapport.text,
                                          ob: _ob.text));

                                      if (selectedValueSingleDialog2==null){
                                        GFToast.showToast(
                                          'Veuillez Selectionner un Docteur',
                                          context,
                                          toastPosition: GFToastPosition.TOP,
                                        );
                                      }
                                      else{
                                        Navigator.pop(context);
                                      }

                                    }
                                  } else {
                                    setState(() {
                                      selectedmap2 = true;
                                    });
                                  }
                                },
                                child: Text('Enregistrer',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: ArgonColors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
