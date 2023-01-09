import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/api_service.dart';
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

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  final Set<Marker> _markers = {};
  final selectedPlace = {};
  _handleTap(LatLng point) {
    setState(() {
      var _markers;
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    print("ok2");
    print(latlang);
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId("12"),
      position: latlang,
      infoWindow: InfoWindow(

          //  snippet: '5 Star Rating',
          ),
      icon: BitmapDescriptor.defaultMarker,
    ));
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
  _AddDataWidgetState();
  final ApiService api = ApiService();
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
  bool selectedmap = false;
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
        title: "Ajouter medcien",
        rightOptions: false,
        backButton: true,
        transparent: false,
      ),
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
                                child: Text("Nom Dr",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _nameController,
                                  placeholder: "Nom Dr",
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
                                child: Text("Nom Vm",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _nameController,
                                  placeholder: "Nom Vm",
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
                                child: Text("Nom Contact",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _nameController,
                                  placeholder: "Nom Contact",
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
                                child: Text("Telephone",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: InputN(
                                  controller: _ageController,
                                  placeholder: "Telephone",
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
                                child: Text("specialité",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: InputN(
                                  controller: _ageController,
                                  placeholder: "specialité",
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
                                child: Text("Secteur",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              ListTile(
                                title: const Text('Public'),
                                leading: Radio(
                                  value: Status.positive,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = 'positive';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Privé'),
                                leading: Radio(
                                  value: Status.dead,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = 'dead';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Column(children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5 -
                                          25,
                                  child: GoogleMap(
                                    gestureRecognizers: Set()
                                      ..add(
                                          Factory<OneSequenceGestureRecognizer>(
                                              () => EagerGestureRecognizer())),
                                    initialCameraPosition: CameraPosition(
                                        target: _initialcameraposition),
                                    mapType: MapType.normal,
                                    onMapCreated: _onMapCreated,
                                    myLocationEnabled: true,
                                    onTap: (latlang) {
                                      print("ok");
                                      if (_markers.length >= 1) {
                                        _markers.clear();
                                      }
                                      setState(() async {
                                        final coordinates = new Coordinates(
                                            latlang.latitude,
                                            latlang.longitude);
                                        var selectedPlace1 = await Geocoder
                                            .local
                                            .findAddressesFromCoordinates(
                                                coordinates);
                                        var selectedPlace =
                                            selectedPlace1.first;
                                        print(selectedPlace);
                                        // for (var i = 0;
                                        //                                                           i <
                                        //                                                               selectedPlace
                                        //                                                                   .addressComponents
                                        //                                                                   .length;
                                        //                                                           i++) {
                                        //                                                         for (var j = 0;
                                        //                                                             j <
                                        //                                                                 selectedPlace
                                        //                                                                     .addressComponents[
                                        //                                                                         i]
                                        //                                                                     .types
                                        //                                                                     .length;
                                        //                                                             j++) {
                                        //                                                           print(
                                        //                                                               "_*******************_");
                                        //                                                           print(
                                        //                                                               selectedPlace
                                        //                                                                   .types);
                                        //                                                           if (selectedPlace
                                        //                                                                   .addressComponents[
                                        //                                                                       i]
                                        //                                                                   .types[j] ==
                                        //                                                               "administrative_area_level_1") {
                                        //                                                             _Wilaya = selectedPlace
                                        //                                                                 .addressComponents[
                                        //                                                                     i]
                                        //                                                                 .longName;
                                        //                                                           } else if (selectedPlace
                                        //                                                                   .addressComponents[
                                        //                                                                       i]
                                        //                                                                   .types[j] ==
                                        //                                                               "administrative_area_level_2") {
                                        //                                                             _Commune =
                                        //                                                                 selectedPlace
                                        //                                                                     .addressComponents[
                                        //                                                                         i]
                                        //                                                                     .longName;
                                        //                                                           } else if (selectedPlace
                                        //                                                                   .addressComponents[
                                        //                                                                       i]
                                        //                                                                   .types[j] ==
                                        //                                                               "locality") {
                                        //                                                             _Daira = selectedPlace
                                        //                                                                 .addressComponents[
                                        //                                                                     i]
                                        //                                                                 .longName;
                                        //                                                           } else if (selectedPlace
                                        //                                                                   .addressComponents[
                                        //                                                                       i]
                                        //                                                                   .types[0] ==
                                        //                                                               "postal_code") {
                                        //                                                             _Pcode = selectedPlace
                                        //                                                                 .addressComponents[
                                        //                                                                     i]
                                        //                                                                 .longName;
                                        //                                                           } else if (selectedPlace
                                        //                                                                   .addressComponents[
                                        //                                                                       i]
                                        //                                                                   .types[j] ==
                                        //                                                               "route") {
                                        //                                                             _Route = selectedPlace
                                        //                                                                 .addressComponents[
                                        //                                                                     i]
                                        //                                                                 .longName;
                                        //                                                           }
                                        //                                                         }
                                        //                                                       }
                                        _onAddMarkerButtonPressed(latlang);
                                      });
                                    },
                                    markers: _markers,
                                  ),
                                ),
                                if (selectedmap)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("selection sur la map",
                                        style: TextStyle(
                                            color: ArgonColors.error,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ),
                              ])),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Wilaya : " + _Wilaya,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Commune :" + _Commune,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Daira :" + _Daira,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Code postal :" + _Pcode,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Route :" + _Route,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: ArgonColors.text)),
                                ),
                              )
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
                                    setState(() {
                                      selectedmap = false;
                                    });
                                    if (_addFormKey.currentState.validate()) {
                                      _addFormKey.currentState.save();
                                      api.createCase(Cases(
                                        name: _nameController.text,
                                        gender: gender,
                                        age: _ageController.text,
                                        address: _addressController.text,
                                        city: _cityController.text,
                                        country: _countryController.text,
                                        status: status,
                                        // Lng: selectedPlace
                                        //     .geometry.location.lng
                                        //     .toString(),
                                        // Lat: selectedPlace
                                        //     .geometry.location.lat
                                        //     .toString()
                                      ));

                                      Navigator.pop(context);
                                    }
                                  } else {
                                    setState(() {
                                      selectedmap = true;
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
