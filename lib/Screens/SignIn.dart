import 'dart:ui';
import 'dart:ui' as ui;
import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';

class SignIn extends StatefulWidget {
  static String id = 'SignIn';

  final Function toggleView;
  SignIn({this.toggleView});

  final greenAccent = const Color(0xff1ef6e3);
  final darkBlue = const Color(0xff1f1a30);
  final darkGray = const Color(0xff1e1e1e);
  final lightGray = const Color(0xff2b2f38);
  final blueGray = const Color(0xff172d44);
  final blue = const Color(0xff0052d2);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          backgroundColor: LightTheme.starWhite,
            body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Spacer(flex: 2),
                  Container(
                    height: 150,
                    child: Column(
                      children: [
                        Spacer(
                          flex: 4,
                        ),
                        Container(
                          alignment: Alignment(-1, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            'Please sign-in to continue',
                            style: TextStyle(
                                color: LightTheme.darkGray.withOpacity(0.6),
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2,),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                                color: LightTheme.darkGray
                                    .withOpacity(0.6),
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                          alignment: Alignment(-0.95,0),
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: LightTheme.darkGray,
                              fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Password',
                            style: TextStyle(
                                color: LightTheme.darkGray
                                    .withOpacity(0.6),
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                          alignment: Alignment(-0.95,0),
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: LightTheme.darkGray,
                              fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
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
                  Spacer(flex: 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment(0,0),
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
                                  .loginWithEmailAndPassword(
                                      email, password);
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
                              gradient: RadialGradient(
                                colors: [
                                  LightTheme.greenAccent,
                                  LightTheme.deepIndigoAccent,
                                ],
                                radius: 5,
                                center: Alignment.bottomLeft
                              )
                            ),
                            height: 50,
                            width: 150,
                            child: Center(
                              child: Text(
                                'SIGN IN',
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
                  Spacer(flex: 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: LightTheme.darkGray
                                    .withOpacity(0.7),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10,),
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
                                  "Register",
                                  style: TextStyle(
                                    decoration:
                                        TextDecoration.underline,
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
                  Spacer(flex: 2,)
                ],
              ),
            ),
          ),
        ));
  }
}
//return Scaffold(
//backgroundColor: LightTheme.white,
//body: Container(
//child: Center(
//child: ShaderMask(
//blendMode: BlendMode.srcIn,
//shaderCallback: (bounds){
//return LinearGradient(
//begin: Alignment.bottomLeft,
//end: Alignment.topRight,
//colors: [const Color(0xff00c9ff),const Color(0xff92fe9d)]
//).createShader(bounds);
//},
////            blendMode: BlendMode.colorBurn,
//child: Icon(
//Icons.shopping_bag,
//size: 300,
//),
//),
//),
//),
//);