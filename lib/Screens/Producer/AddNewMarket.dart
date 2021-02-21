import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/MapPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class AddNewMarket extends StatefulWidget {
  static String id = 'AddNewMarket';
  @override
  _AddNewMarketState createState() => _AddNewMarketState();
}

class _AddNewMarketState extends State<AddNewMarket> {
  final _formKey = GlobalKey<FormState>();

  String ownerName = "";
  String marketName;
  String location;
  bool loading = false;
  String error = "";

//  TextEditingController marketNameController = TextEditingController();
//  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ownerName = ModalRoute.of(context).settings.arguments;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return loading? Loading():Scaffold(
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
                      height: _height / 1.5,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Market Name',
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
                                        marketName = value;
                                      });
                                    }
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Location',
                                    style: TextStyle(
                                        color: LightTheme.darkGray
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  alignment: Alignment(-0.95,0),
                                ),
                               SizedBox(height: 15,),
                               Center(
                                 child: Text(
                                   location == null? '' : location,
                                   style: TextStyle(
                                       color: LightTheme.darkGray,
                                       fontWeight: FontWeight.w300,
                                       fontSize: 14),
                                 ),
                               ),
                                SizedBox(height: 20,),
                                FlatButton(onPressed: (){
                                  Navigator.pushNamed(context, FireMap.id);
                                },
                                    color: LightTheme.greenAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.location_on),
                                          SizedBox(width: 10.0,),
                                          Text('Choose Market Location',
                                          style: TextStyle(
                                              color: LightTheme.darkGray,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14) ,),
                                        ],
                                      ),
                                    )
                                )
//                                 TextFormField(
// //                                  controller: locationController,
//                                   style: TextStyle(
//                                       color: LightTheme.darkGray, fontSize: 14),
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.symmetric(
//                                         vertical: 10.0, horizontal: 10.0),
//                                     filled: false,
//                                   ),
//                                     validator: (val) => val.isEmpty? 'Field must be filled':null,
//                                     onChanged: (value){
//                                       setState(() {
//                                         location = value;
//                                       });
//                                     }
//                                 ),
                              ],
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
    );
  }
}
