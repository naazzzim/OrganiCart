import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Customer/CustomerHome.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/ProducerHome.dart';
import 'package:flutter/material.dart';

class DirectToHome extends StatefulWidget {
  @override
  _DirectToHomeState createState() => _DirectToHomeState();
}

class _DirectToHomeState extends State<DirectToHome> {
  UserClass user;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    UserDatabase().getUsers().then((value){
      setState(() {
        print('hi');
        user = value;
        loading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(loading)
      return Loading();
    else{
      if(user.userType == 'Customer')
         return CustomerHome(user: user,);
      else
        return ProducerHome(user: user,);
    }
  }
}
