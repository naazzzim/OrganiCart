import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Theme.dart';

class Loading extends StatelessWidget {
  static String id = 'Loading';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: LightTheme.starWhite,
          body: Center(
              child: SpinKitRotatingCircle(
            color: LightTheme.greenAccent,
            size: 50.0,
          ))),
    );
  }
}
