import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add new'),
      ),
        body: Center(
          child: Form(
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
                                obscureText: true,
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
        onPressed: (){

        },
        child: Icon(
          Icons.done,
        ),
      ),
    ));
  }
}
