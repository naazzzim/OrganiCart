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
  String productPrice = "";
  String additionalInfo = "";
  String marketUid;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    marketUid = ModalRoute.of(context).settings.arguments;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    if (loading) {
      return Loading();
    } else {
      return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add a Product'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Product Name',
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
                            color: LightTheme.darkGray, fontSize: 14),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: false,
                        ),
                        validator: (val) => val.isEmpty? 'Field must be filled':null,
                        onChanged: (value){
                          setState(() {
                            productName = value;
                          });
                        },
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
                      child :Text(
                    'Product Price',
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
                            color: LightTheme.darkGray, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: false,
                        ),
                        validator: (val) => val.isEmpty? 'Field must be filled':null,
                        onChanged: (value){
                          setState(() {
                            productPrice = value;
                          });
                        },
                        keyboardType: TextInputType.number,
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
                          'Additional Info',
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
                            color: LightTheme.darkGray, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: false,
                        ),
                        onChanged: (value){
                          setState(() {
                            additionalInfo = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
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
            await MarketDatabase().addProductToMarket(marketUid, ProductClass(name: productName,price: productPrice,additionalInfo: additionalInfo));
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
}
