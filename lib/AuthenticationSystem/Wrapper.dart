import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:flutter/material.dart';
import 'package:farmerApp/Screens/Page1.dart';

import 'package:farmerApp/Screens/SignIn.dart';
import 'package:farmerApp/Screens/SignUp.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool hasAccount = true;

  void toggleView(){
    setState(() => hasAccount = !hasAccount);
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthServices().user,
      builder: (context, user){
        if(user.hasData) {
          return Page1();
        }
        else {
          if(hasAccount)
            return SignIn(toggleView: toggleView);
          else
            return SignUp(toggleView: toggleView);
        }
      },
    );
  }
}