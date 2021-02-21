import 'dart:ui';
import 'dart:ui' as ui;
import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';

  final Function toggleView;
  SignUp({this.toggleView});

  final greenAccent = const Color(0xff1ef6e3);
  final darkBlue = const Color(0xff1f1a30);
  final darkGray = const Color(0xff1e1e1e);
  final lightGray = const Color(0xff2b2f38);
  final blueGray = const Color(0xff172d44);
  final blue = const Color(0xff0052d2);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  String error = "";
  bool isFarmer = false;
  bool loading = false;
  String userType = "Customer"; //Default

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                backgroundColor: LightTheme.starWhite,
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child: Column(
                            children: [
                              Spacer(
                                flex: 4,
                              ),
                              Container(
                                alignment: Alignment(-1, 0),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'OrganiCart',
                                      style: TextStyle(
                                          color: LightTheme.darkGray,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 36),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return ui.Gradient.linear(
                                          Offset(4.0, 24.0),
                                          Offset(24.0, 4.0),
                                          [
                                            LightTheme.greenAccent,
                                            LightTheme.deepIndigoAccent,
                                          ],
                                        );
                                      },
                                      child: Icon(
                                        Icons.shopping_bag,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment(-1, 0),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Text(
                                  'Please sign-up to continue',
                                  style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  'User Name',
                                  style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                alignment: Alignment(-0.95, 0),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  filled: false,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                validator: (val) =>
                                    val.isEmpty ? 'Enter your name' : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  'Email Address',
                                  style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                alignment: Alignment(-0.95, 0),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  filled: false,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                validator: (val) => val.isEmpty
                                    ? 'Please enter a valid email'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                alignment: Alignment(-0.95, 0),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  filled: false,
                                ),
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                validator: (val) => val.length < 6
                                    ? 'Password must be 6+ characters'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                                alignment: Alignment(-0.95, 0),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  filled: false,
                                ),
                                obscureText: true,
                                onChanged: (val) {},
                                validator: (val) => val != password
                                    ? "Passwords don't match"
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  'Are you a Producer',
                                  style: TextStyle(
                                    color: LightTheme.darkGray
                                        .withOpacity(0.7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                                Checkbox(value: isFarmer, onChanged: (value){
                                  setState(() {
                                    isFarmer = value;
                                  });
                                }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Align(
                            alignment: Alignment(-1, 0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await AuthServices()
                                        .registerWithEmailAndPassword(
                                            name, email, password, userType);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Please enter a valid Email Id and corresponding Password';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Please enter a valid Email Id and corresponding Password';
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: RadialGradient(colors: [
                                    LightTheme.greenAccent,
                                    LightTheme.deepIndigoAccent,
                                  ], radius: 5, center: Alignment.bottomLeft)),
                                  height: 50,
                                  width: 150,
                                  child: Center(
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        color: LightTheme.starWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color:
                                          LightTheme.darkGray.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.toggleView();
                                    },
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return ui.Gradient.linear(
                                          Offset(4.0, 24.0),
                                          Offset(24.0, 4.0),
                                          [
                                            LightTheme.greenAccent,
                                            LightTheme.deepIndigoAccent,
                                          ],
                                        );
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
