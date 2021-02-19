import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class AddNewProduct extends StatefulWidget {
  static String id = 'AddNewProduct';
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {

  String productName = "";
  int productPrice;
  String additionalInfo = "";
  String market_uid;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    market_uid = ModalRoute.of(context).settings.arguments;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return loading? Loading():SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add a Product'),
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
                            hintText: 'Product Name',
                            hintStyle: TextStyle(
                                color: LightTheme.darkGray.withOpacity(0.7),
                                fontFamily: "Montserrat"),
                            filled: false,
                          ),
                          validator: (val) => val.isEmpty? 'Field must be filled':null,
                          onChanged: (value){
                            setState(() {
                              productName = value;
                            });
                          },
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
                            hintText: 'Product Price',
                            hintStyle: TextStyle(
                                color: LightTheme.darkGray.withOpacity(0.7),
                                fontFamily: "Montserrat"),
                            filled: false,
                          ),
                          validator: (val) => val.isEmpty? 'Field must be filled':null,
                          onChanged: (value){
                            setState(() {
                              productPrice = int.parse(value);
                            });
                          },
                          keyboardType: TextInputType.number,
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
                            hintText: 'Additional Info',
                            hintStyle: TextStyle(
                                color: LightTheme.darkGray.withOpacity(0.7),
                                fontFamily: "Montserrat"),
                            filled: false,
                          ),
                          onChanged: (value){
                            setState(() {
                              additionalInfo = value;
                            });
                          },
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
            await MarketDatabase().addProductToMarket(market_uid, ProductClass(name: productName,price: productPrice,additionalInfo: additionalInfo));
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
