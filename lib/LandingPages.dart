import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return user == null ? SignInPage() : Homepage();
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            OutlineButton(
              onPressed: () async {
                //await context.read<AuthenticationService>().loginGoogle();
              },
              child: Text("Sign In"),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text("Logged in")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
