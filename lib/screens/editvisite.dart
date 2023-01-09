import 'package:argon_flutter/models/Visite.dart';
import 'package:argon_flutter/services/Visite_service.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/widgets/card-horizontal.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/screens/EditVisite.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/inputNumber.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:search_choices/search_choices.dart';
import 'package:getwidget/getwidget.dart';

enum Gender { male, female }
enum Status { positive, dead, recovered }

class EditVisite extends StatefulWidget {
  EditVisite(this.visit);

  final VisiteM visit;

  @override
  _EditVisiteState createState() => _EditVisiteState();
}

class _EditVisiteState extends State<EditVisite> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  var _NomVm = TextEditingController();
  var _NomContact = TextEditingController();
  var _Phone = TextEditingController();
  var _Spicialite = TextEditingController();
  var _Secteur = TextEditingController();
  var _NomDr = TextEditingController();
  final ApiVisiteService api = ApiVisiteService();
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String gender = 'male';
  Gender _gender = Gender.male;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final Set<Marker> _markers = {};

  var _selectedPlace;
  Key Header1;
  String _mapController = 'false';
  bool selectedmap = true;
  bool selectedmap2 = false;
  String _Wilaya = '';
  String _Daira = '';
  String _Route = '';
  String _Pcode = '';
  String id = '';

  var kInitialPosition = LatLng(-33.8567844, 151.213108);
  String _Commune = '';
  String status = 'positive';
  Status _status = Status.positive;
  static String selectedValueSingleDialog;
  static String selectedValueSingleDialog2;
  static String selectedValueSingleDialog3;

  final ApiService api2 = ApiService();

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
  List<Cases> casesList;
  final List<DropdownMenuItem> items = [];

  Future loadList() {
    Future<List<Cases>> futureCases = api2.getCases();
    futureCases.then((casesList) {
      setState(() {
        this.casesList = casesList;
      });
      casesList.forEach((word) {
        items.add(DropdownMenuItem(
          child: Text(word.NomDr),
          value: word.id + "," + word.NomDr,
        ));
      });
    });
    return futureCases;
  }

  String _lat = "0";
  String _lng = "0";

  @override
  void initState() {
    print("lat");
    print(widget.visit.Lat);
    id = widget.visit.id;
    _NomDr.text = widget.visit.NomDr;
    selectedValueSingleDialog3 = widget.visit.NomDr;
    selectedValueSingleDialog2 = widget.visit.NomDr;
    selectedValueSingleDialog = widget.visit.NomDrid;
    _lat = widget.visit.Lat;
    _lng = widget.visit.Lng;
    groupValue = int.parse(widget.visit.V1);
    groupValue2 = int.parse(widget.visit.V2);
    groupValue3 = int.parse(widget.visit.V3);
    groupValue4 = int.parse(widget.visit.V4);
    groupValue5 = int.parse(widget.visit.V5);
    groupValue6 = int.parse(widget.visit.V6);
    groupValue7 = int.parse(widget.visit.V7);
    groupValue8 = int.parse(widget.visit.V8);
    groupValue9 = int.parse(widget.visit.V9);
    _rapport.text = widget.visit.Rapport;
    _ob.text = widget.visit.ob;

    _NomContact.text = widget.visit.V2;
    _Phone.text = widget.visit.V3;

    _onAddMarkerButtonPressed(LatLng(double.parse("0.0"), double.parse("0.0")));

    void initmapValue() async {
      final coordinates2 = new Coordinates(
          double.parse(widget.visit.Lat), double.parse(widget.visit.Lng));

      var _selectedPlace5 =
          await Geocoder.local.findAddressesFromCoordinates(coordinates2);
      _selectedPlace = _selectedPlace5.first;
    }

    initmapValue();
    super.initState();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      setState(() {
        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("12"),
          position: LatLng(double.parse(_lat), double.parse(_lng)),
          infoWindow: InfoWindow(

              //  snippet: '5 Star Rating',
              ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
          title: "Modification  Visite",
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
                        /********************************************* */
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Médecin",
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
                                  hint: " Non autorisé",
                                  searchHint: "non autorisé",
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
                                    selectedValueSingleDialog3 = value;
                                    print(value.split(",")[0]);
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
                                child: Text("Etat",
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
                                    Text("Validé",
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
                                    Text("Non validé",
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
                        // Padding(
                        //   padding: EdgeInsets.only(top: 50.0),
                        //   child: Container(
                        //       height: MediaQuery.of(context).size.height / 1.5,
                        //       child: Column(children: <Widget>[
                        //         Container(
                        //           height:
                        //               MediaQuery.of(context).size.height / 1.5 -
                        //                   25,
                        //           child: GoogleMap(
                        //             gestureRecognizers: Set()
                        //               ..add(
                        //                   Factory<OneSequenceGestureRecognizer>(
                        //                       () => EagerGestureRecognizer())),
                        //             initialCameraPosition: CameraPosition(
                        //                 target: _initialcameraposition),
                        //             mapType: MapType.normal,
                        //             onMapCreated: _onMapCreated,
                        //             myLocationEnabled: true,
                        //             onTap: (latlang) async {
                        //               print("ok");
                        //               if (_markers.length >= 1) {
                        //                 _markers.clear();
                        //               }
                        //               selectedmap = true;
                        //               _onAddMarkerButtonPressed(latlang);
                        //
                        //               final coordinates = new Coordinates(
                        //                   latlang.latitude, latlang.longitude);
                        //               var selectedPlace1 = await Geocoder.local
                        //                   .findAddressesFromCoordinates(
                        //                       coordinates);
                        //               var selectedPlace = selectedPlace1.first;
                        //               print(
                        //                   selectedPlace.coordinates.longitude);
                        //               setState(() {
                        //                 _selectedPlace = selectedPlace;
                        //                 _Daira = selectedPlace.locality;
                        //                 _Wilaya = selectedPlace.adminArea;
                        //                 _Commune = selectedPlace.subAdminArea;
                        //                 _Route = selectedPlace.addressLine;
                        //                 if (selectedPlace.postalCode != null) {
                        //                   _Pcode = selectedPlace.postalCode;
                        //                 } else {
                        //                   _Pcode = '';
                        //                 }
                        //               });
                        //             },
                        //             markers: _markers,
                        //           ),
                        //         ),
                        //         if (selectedmap2)
                        //           Align(
                        //             alignment: Alignment.centerLeft,
                        //             child: Text("selection sur la map",
                        //                 style: TextStyle(
                        //                     color: ArgonColors.error,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 12)),
                        //           ),
                        //       ])),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (selectedmap) {
                                    setState(() {
                                      selectedmap2 = false;
                                    });
                                    if (_addFormKey.currentState.validate()) {
                                      _addFormKey.currentState.save();
                                      api.updateVisite(VisiteM(
                                          id: id,
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
                                          Rapport: _rapport.text,
                                          ob: _ob.text));

                                      Navigator.pop(context);
                                    }
                                  } else {
                                    setState(() {
                                      selectedmap2 = true;
                                    });
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
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

// class _EditVisiteState extends State<EditVisite> {
//   _EditVisiteState();

//   final ApiService api = ApiService();
//   final _addFormKey = GlobalKey<FormState>();
//   String id = '';
//   final _nameController = TextEditingController();
//   String gender = 'male';
//   Gender _gender = Gender.male;
//   final _ageController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _countryController = TextEditingController();
//   String status = 'positive';
//   Status _status = Status.positive;

//   @override
//   void initState() {
//     id = widget.cases.id;
//     _nameController.text = widget.cases.name;
//     gender = widget.cases.gender;
//     if (widget.cases.gender == 'male') {
//       _gender = Gender.male;
//     } else {
//       _gender = Gender.female;
//     }
//     _ageController.text = widget.cases.age.toString();
//     _addressController.text = widget.cases.address;
//     _cityController.text = widget.cases.city;
//     _countryController.text = widget.cases.country;
//     status = widget.cases.status;
//     if (widget.cases.status == 'positive') {
//       _status = Status.positive;
//     } else if (widget.cases.status == 'dead') {
//       _status = Status.dead;
//     } else {
//       _status = Status.recovered;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Cases'),
//       ),
//       body: Form(
//         key: _addFormKey,
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Card(
//                 child: Container(
//                     padding: EdgeInsets.all(10.0),
//                     width: 440,
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Full Name'),
//                               TextFormField(
//                                 controller: _nameController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Full Name',
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please enter full name';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Gender'),
//                               ListTile(
//                                 title: const Text('Male'),
//                                 leading: Radio(
//                                   value: Gender.male,
//                                   groupValue: _gender,
//                                   onChanged: (Gender value) {
//                                     setState(() {
//                                       _gender = value;
//                                       gender = 'male';
//                                     });
//                                   },
//                                 ),
//                               ),
//                               ListTile(
//                                 title: const Text('Female'),
//                                 leading: Radio(
//                                   value: Gender.female,
//                                   groupValue: _gender,
//                                   onChanged: (Gender value) {
//                                     setState(() {
//                                       _gender = value;
//                                       gender = 'female';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Age'),
//                               TextFormField(
//                                 controller: _ageController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Age',
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please enter age';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Address'),
//                               TextFormField(
//                                 controller: _addressController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Address',
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please enter address';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('City'),
//                               TextFormField(
//                                 controller: _cityController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'City',
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please enter city';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Country'),
//                               TextFormField(
//                                 controller: _countryController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Country',
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please enter country';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               Text('Status'),
//                               ListTile(
//                                 title: const Text('Positive'),
//                                 leading: Radio(
//                                   value: Status.positive,
//                                   groupValue: _status,
//                                   onChanged: (Status value) {
//                                     setState(() {
//                                       _status = value;
//                                       status = 'positive';
//                                     });
//                                   },
//                                 ),
//                               ),
//                               ListTile(
//                                 title: const Text('Dead'),
//                                 leading: Radio(
//                                   value: Status.dead,
//                                   groupValue: _status,
//                                   onChanged: (Status value) {
//                                     setState(() {
//                                       _status = value;
//                                       status = 'dead';
//                                     });
//                                   },
//                                 ),
//                               ),
//                               ListTile(
//                                 title: const Text('Recovered'),
//                                 leading: Radio(
//                                   value: Status.recovered,
//                                   groupValue: _status,
//                                   onChanged: (Status value) {
//                                     setState(() {
//                                       _status = value;
//                                       status = 'recovered';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Column(
//                             children: <Widget>[
//                               RaisedButton(
//                                 splashColor: Colors.red,
//                                 onPressed: () {
//                                   if (_addFormKey.currentState.validate()) {
//                                     _addFormKey.currentState.save();
//                                     api.updateCases(Cases(
//                                         id: id,
//                                         name: _nameController.text,
//                                         gender: gender,
//                                         age: _ageController.text,
//                                         address: _addressController.text,
//                                         city: _cityController.text,
//                                         country: _countryController.text,
//                                         status: status));

//                                     Navigator.pop(context);
//                                   }
//                                 },
//                                 child: Text('Save',
//                                     style: TextStyle(color: Colors.white)),
//                                 color: Colors.blue,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ))),
//           ),
//         ),
//       ),
//     );
//   }
// }
