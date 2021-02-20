import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Theme.dart';

class Loading extends StatelessWidget {
  static String id = 'Loading';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: DarkTheme.darkGray,
          body: Center(
              child: SpinKitRotatingCircle(
                color: DarkTheme.deepIndigoAccent,
                size: 50.0,
              )
          )
      ),
    );
  }
}
