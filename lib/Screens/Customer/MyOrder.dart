import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/AuthenticationSystem/Wrapper.dart';
import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Location/SetLocation.dart';
import 'package:farmerApp/Screens/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  final List<dynamic> order;
  final MarketClass market;
  MyOrder({this.order,this.market});
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool loading = true;
  UserClass user;
  GeoLocation location;
  @override
  void initState() {
    UserDatabase().getUsers().then((value){
      setState(() {
        user = value;
        loading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    double width = MediaQuery.of(context).size.width;
    for(Map<dynamic,dynamic> element in widget.order){
      totalPrice += double.parse(element['TotalPrice']);
    }
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(location != null) {
            Navigator.popUntil(context, ModalRoute.withName(Wrapper.id));
            await MarketDatabase().placeOrder(widget.market.uid, OrderClass(
                customerName: user.name,
                order: widget.order,
                timeStamp: Timestamp.now(),
                isCompleted: false,
                marketName: widget.market.marketName,geohash:location.geohash,geopoint:location.geopoint));
          }
        },
        child: Icon(
          Icons.chevron_right_sharp
        ),
      ),
      body: ListView.builder(
        itemCount: widget.order.length + 2,
          itemBuilder: (context,index){

          if(index == 0)
            return Container(
              child: Column(
                children: [
                  SizedBox(height: 30.0,),
                  Container(
                    child: Text(
                      'Location',
                      style: TextStyle(
                          color: LightTheme.darkGray
                              .withOpacity(0.6),
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: width - 30,
                    child: FlatButton(onPressed: () async{
                      Navigator.push(context,MaterialPageRoute(builder: (context) => SetLocation(geoLocation: location))).then((value){
                        setState(() {
                          location = value;
                        });
                      });

                    },
                        color: LightTheme.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 10.0,),
                              Text('Choose Delivery Location',
                                style: TextStyle(
                                    color: LightTheme.darkGray,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14) ,),
                            ],
                          ),
                        )
                    ),
                  ),
                    SizedBox(height: 20,),
                  Center(
                    child: Text(
                      location == null? '' : "Location has been selected",
                      style: TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 10,)



                ],
              ),
            );

          index = index - 1;
          if(index == widget.order.length)
            return Container(
              child: Column(
                children: [
                  Divider(
                    color: LightTheme.greenAccent,
                    thickness: 4,
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width-60,
                    child: Row(
                      children: [
                        Spacer(flex: 2,),
                        Text(
                          'Total :',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Rs. ' +totalPrice.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Spacer(flex: 2,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          return ListTile(
            title: Text(widget.order[index]['ProductName']),
            subtitle: Text('Rs. ' + widget.order[index]['TotalPrice']),
          );
          }),
    );
  }
}
