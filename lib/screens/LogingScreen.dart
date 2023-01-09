import 'dart:ui';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/customtextfield.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/services/LoginService.dart';
import 'package:argon_flutter/models/LoginModel.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';

import 'elements.dart';
import 'progressHUD.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  Loginscreenn createState() => Loginscreenn();
}

class Loginscreenn extends State<LoginPage> {
  LoginRequestModel loginRequestModel;
  TextEditingController user = new TextEditingController();
  TextEditingController passwd = new TextEditingController();
  bool isApiCallProcess = false;
  static String token;
  static String id;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(2),
                width: 440,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/onboard-background.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      0, 40, 0, MediaQuery.of(context).size.height / 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.height / 10, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text("Gestion visite",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.height / 25, 0, 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text("Connectez-vous avec votre Compte",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 25, right: 25),
                              child: Input(
                                min: 1,
                                controller: user,
                                placeholder: "utilisateur",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, left: 25, right: 25),
                              child: Input(
                                min: 1,
                                controller: passwd,
                                placeholder: "Mot de pass",
                                issecured: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ButtonTheme(
                            buttonColor: Colors.white,
                            minWidth: MediaQuery.of(context).size.width,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              textColor: ArgonColors.text,
                              color: ArgonColors.secondary,
                              onPressed: () {
                                setState(() {
                                  isApiCallProcess = true;
                                });

                                loginRequestModel.password =
                                    passwd.text.toString();
                                loginRequestModel.Username =
                                    user.text.toString();
                                print(loginRequestModel.toJson());
                                print("testa");
                                APIService apiService = new APIService();
                                apiService
                                    .login(loginRequestModel)
                                    .then((value) {
                                  print("the value ");
                                  if (value != null) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });

                                    if (value.token.isNotEmpty) {
                                      token = value.token;
                                      id = value.id;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Elements()));
                                    } else {
                                      print("false check");
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      GFToast.showToast(
                                        'Information incorrect',
                                        context,
                                        toastPosition: GFToastPosition.TOP,
                                      );
                                    }
                                  } else {
                                    print("value of test");
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                    final snackBar = SnackBar(
                                        content: Text(
                                            "username of password inccorect"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                });
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text("connexion",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0))),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          // child: Text(
                          //   'OR',
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/1.png'), fit: BoxFit.cover),
              gradient: LinearGradient(
                  colors: [Color(0xff25B1FB), Color(0xff25B1FB)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Virtugoo Visiteur',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Sign in with your account',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  CustomTextField(
                      issecured: false, hint: '    Email/Phone', maxline: 1),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      hint: '   Password', issecured: true, maxline: 1),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: ButtonTheme(
                        buttonColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width,
                        height: 55,
                        child: RaisedButton(
                          onPressed: () {
                            print("ok");
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage('images/fb.png')),
                        SizedBox(
                          width: 20,
                        ),
                        Image(image: AssetImage('images/google.png'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
