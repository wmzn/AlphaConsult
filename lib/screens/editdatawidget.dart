import 'package:argon_flutter/models/Options.dart';
import 'package:argon_flutter/models/spec.dart';
import 'package:argon_flutter/services/Options_service.dart';
import 'package:argon_flutter/services/Spec_service.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/api_service.dart';
import 'package:argon_flutter/models/cases.dart';
import 'package:argon_flutter/widgets/card-horizontal.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/screens/editdatawidget.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/inputNumber.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:search_choices/search_choices.dart';

enum Gender { male, female }
enum Status { positive, dead, recovered }

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.cases);

  final Cases cases;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  var _NomVm = TextEditingController();
  var _NomContact = TextEditingController();
  var _Phone = TextEditingController();
  var _Spicialite = TextEditingController();
  var _Secteur = TextEditingController();
  var _NomDr = TextEditingController();
  var _prenom = TextEditingController();
  var _email = TextEditingController();
  var _option = TextEditingController();
  String option;

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String gender = 'male';
  int groupValue = 0;
  int groupValuePotentielPatient = 0;
  int groupValuePotentielProduit = 0;
  static String selectedValueSingleDialog;
  static String selectedValueSingleDialog2;
  static String selectedValueSingleDialog3;
  static String selectedValueSingleDialogOptions;
  static String selectedValueSingleDialogOptions2;
  static String selectedValueSingleDialogOptions3;
  Gender _gender = Gender.male;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final Set<Marker> _markers = {};
  String Spicialite;
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
  List<Spec> specList;
  final List<DropdownMenuItem> items = [];
  final List<DropdownMenuItem> optionsItems = [];

  final SpecService apiSpec = SpecService();
  var kInitialPosition = LatLng(-33.8567844, 151.213108);
  String _Commune = '';
  String status = 'positive';
  Status _status = Status.positive;
  Future loadListSpec() {
    Future<List<Spec>> futureCases = apiSpec.getCases2();
    futureCases.then((specList) {
      setState(() {
        this.specList = specList;
      });
      specList.forEach((word) {
        items.add(DropdownMenuItem(
          child: Text(word.titel),
          value: word.titel,
        ));
      });
    });
    return futureCases;
  }

  final OptionsService apiOptions = OptionsService();
  List<Options> optionsList;

  Future loadListOptions() {
    Future<List<Options>> futureOptions = apiOptions.getOptions();
    futureOptions.then((options) {
      setState(() {
        this.optionsList = options;
      });
      optionsList.forEach((word) {
        optionsItems.add(DropdownMenuItem(
          child: Text(word.titre),
          value: word.titre,
        ));
      });
    });
    return futureOptions;
  }

  @override
  void initState() {
    loadListSpec();
    loadListOptions();
    id = widget.cases.id;
    _prenom.text = widget.cases.prenom;
    _email.text = widget.cases.email;
    groupValuePotentielPatient = int.parse(widget.cases.potentielPation);
    groupValuePotentielProduit = int.parse(widget.cases.potentielProduit);
    selectedValueSingleDialogOptions3 = widget.cases.option;
    _NomDr.text = widget.cases.NomDr;
    _NomVm.text = widget.cases.NomVm;
    _NomContact.text = widget.cases.NomContact;
    _Phone.text = widget.cases.Phone;
    _Wilaya = widget.cases.Wilaya;
    _Daira = widget.cases.Daira;
    _Pcode = widget.cases.CodeP;
    _Route = widget.cases.Route;
    groupValue = int.parse(widget.cases.Secteur);
    selectedValueSingleDialog3 = widget.cases.Spicialite;
    _Commune = widget.cases.Commun;
    _onAddMarkerButtonPressed(
        LatLng(double.parse(widget.cases.Lat), double.parse(widget.cases.Lng)));
    status = widget.cases.Secteur;
    _Spicialite.text = widget.cases.Spicialite;
    gender = widget.cases.gender;
    if (widget.cases.gender == 'male') {
      _gender = Gender.male;
    } else {
      _gender = Gender.female;
    }
    _ageController.text = widget.cases.age.toString();
    _addressController.text = widget.cases.address;
    _cityController.text = widget.cases.city;
    _countryController.text = widget.cases.country;
    status = widget.cases.status;
    if (widget.cases.status == 'positive') {
      _status = Status.positive;
    } else if (widget.cases.status == 'dead') {
      _status = Status.dead;
    } else {
      _status = Status.recovered;
    }
    void initmapValue() async {
      final coordinates2 = new Coordinates(
          double.parse(widget.cases.Lat), double.parse(widget.cases.Lng));

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
          title: "Modification  médecin",
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
                                child: Text("Nom",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _NomDr,
                                  placeholder: "Nom",
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
                                child: Text("Prénom",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _prenom,
                                  placeholder: "Prénom",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Option",
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
                                  items: optionsItems,
                                  value: selectedValueSingleDialogOptions3,
                                  hint: "Sélectionner une Option",
                                  searchHint: "Sélectionner une Option",
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
                                    selectedValueSingleDialogOptions3 = value;
                                    setState(() {
                                      selectedValueSingleDialogOptions = value;
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
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Specialité",
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
                                  hint: "sélectionner un Specialité",
                                  searchHint: "sélectionner un Specialité",
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
                                      selectedValueSingleDialog = value;
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
                                child: Text("E-mail",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Input(
                                  controller: _email,
                                  placeholder: "E-mail",
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
                                child: Text("Téléphone",
                                    style: TextStyle(
                                        color: ArgonColors.text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: InputN(
                                  controller: _Phone,
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
                                child: Text("Secteur",
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
                                    Text("Public",
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
                                    Text("Privé",
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
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Potentiel patient",
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
                                    Text("A",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 1,
                                      groupValue: groupValuePotentielPatient,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielPatient = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("B",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 2,
                                      groupValue: groupValuePotentielPatient,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielPatient = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("C",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 3,
                                      groupValue: groupValuePotentielPatient,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielPatient = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Potentiel Produit",
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
                                    Text("A",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 1,
                                      groupValue: groupValuePotentielProduit,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielProduit = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("B",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 2,
                                      groupValue: groupValuePotentielProduit,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielProduit = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
                                    ),
                                    Text("C",
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                    GFRadio(
                                      type: GFRadioType.square,
                                      size: GFSize.LARGE,
                                      value: 3,
                                      groupValue: groupValuePotentielProduit,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValuePotentielProduit = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: GFColors.SUCCESS,
                                      radioColor: GFColors.SUCCESS,
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
                        //         child: Text("Nom Vm",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: Input(
                        //           controller: _NomVm,
                        //           placeholder: "Nom Vm",
                        //         ),
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
                        //         child: Text("Nom Contact",
                        //             style: TextStyle(
                        //                 color: ArgonColors.text,
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 16)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 12.0),
                        //         child: Input(
                        //           controller: _NomContact,
                        //           placeholder: "Nom Contact",
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

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
                                    onTap: (latlang) async {
                                      print("ok");
                                      if (_markers.length >= 1) {
                                        _markers.clear();
                                      }
                                      selectedmap = true;
                                      _onAddMarkerButtonPressed(latlang);

                                      final coordinates = new Coordinates(
                                          latlang.latitude, latlang.longitude);
                                      var selectedPlace1 = await Geocoder.local
                                          .findAddressesFromCoordinates(
                                              coordinates);
                                      var selectedPlace = selectedPlace1.first;
                                      print(
                                          selectedPlace.coordinates.longitude);
                                      setState(() {
                                        _selectedPlace = selectedPlace;
                                        _Daira = selectedPlace.locality;
                                        _Wilaya = selectedPlace.adminArea;
                                        _Commune = selectedPlace.subAdminArea;
                                        _Route = selectedPlace.addressLine;
                                        if (selectedPlace.postalCode != null) {
                                          _Pcode = selectedPlace.postalCode;
                                        } else {
                                          _Pcode = '';
                                        }
                                      });
                                    },
                                    markers: _markers,
                                  ),
                                ),
                                if (selectedmap2)
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
                                      selectedmap2 = false;
                                    });
                                    if (_addFormKey.currentState.validate()) {
                                      _addFormKey.currentState.save();
                                      api.updateCases(Cases(
                                        id: id,
                                        name: _nameController.text,
                                        gender: gender,
                                        age: _ageController.text,
                                        address: _addressController.text,
                                        city: _cityController.text,
                                        country: _countryController.text,
                                        status: status,
                                        Lng: _selectedPlace.coordinates.latitude
                                            .toString(),
                                        Lat: _selectedPlace
                                            .coordinates.longitude
                                            .toString(),
                                        NomDr: _NomDr.text,
                                        prenom: _prenom.text,
                                        email: _email.text,
                                        option:
                                            selectedValueSingleDialogOptions,
                                        potentielPation:
                                            groupValuePotentielPatient
                                                .toString(),
                                        potentielProduit:
                                            groupValuePotentielProduit
                                                .toString(),
                                        NomVm: _NomVm.text,
                                        NomContact: _NomContact.text,
                                        Phone: _Phone.text,
                                        Spicialite: selectedValueSingleDialog,
                                        Secteur: groupValue.toString(),
                                        Wilaya: _Wilaya,
                                        Commun: _Commune,
                                        Daira: _Daira,
                                        CodeP: _Pcode,
                                        Route: _Route,
                                      ));

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

// class _EditDataWidgetState extends State<EditDataWidget> {
//   _EditDataWidgetState();

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
