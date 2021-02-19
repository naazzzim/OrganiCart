import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class AddNewMarket extends StatefulWidget {
  static String id = 'AddNewMarket';
  @override
  _AddNewMarketState createState() => _AddNewMarketState();
}

class _AddNewMarketState extends State<AddNewMarket> {

  String ownerName = "";
  String marketName;
  String location;
  bool loading = false;
  String error = "";

  TextEditingController marketNameController = TextEditingController();
  TextEditingController LocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ownerName = ModalRoute.of(context).settings.arguments;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return loading? Loading():SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add new Market'),
      ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              height: _height/1.5,
              width: _width,
              child:
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.blueAccent)),
                      height: _height / 1.5,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              height: 60,
                              width: 300,
                              color: LightTheme.darkGray.withOpacity(0.3),
                              padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                              child: TextFormField(
                                controller: marketNameController,
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  icon: Container(
                                    padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: LightTheme.darkGray,
                                      size: 20,
                                    ),
                                  ),
                                  hintText: 'Market Name',
                                  hintStyle: TextStyle(
                                      color: LightTheme.darkGray.withOpacity(0.7),
                                      fontFamily: "Montserrat"),
                                  filled: false,
                                ),
                                  validator: (val) => val.isEmpty? 'Field must be filled':null,
                                  onChanged: (value){
                                    setState(() {
                                      marketName = value;
                                    });
                                  }
                              ),
                            ),
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              height: 60,
                              width: 300,
                              color: LightTheme.darkGray.withOpacity(0.3),
                              padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                              child: TextFormField(
                                controller: LocationController,
                                style: TextStyle(
                                    color: LightTheme.darkGray, fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  icon: Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: LightTheme.darkGray,
                                      size: 20,
                                    ),
                                  ),
                                  hintText: 'Location',
                                  hintStyle: TextStyle(
                                      color: LightTheme.darkGray.withOpacity(0.7),
                                      fontFamily: "Montserrat"),
                                  filled: false,
                                ),
                                  validator: (val) => val.isEmpty? 'Field must be filled':null,
                                  onChanged: (value){
                                    setState(() {
                                      location = value;
                                    });
                                  }
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                              ],
                            ),
                          ),
                      ),
                    ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          if(_formKey.currentState.validate()){
            Navigator.pop(context);
            await MarketDatabase().addMarket(marketName,ownerName);
          }
          else{
            setState(() {
              loading = false;
              error =
              'Please enter a valid Email Id and corresponding Password';
            });
          }
        },
        child: Icon(
          Icons.done,
        ),
      ),
    ));
  }
}
