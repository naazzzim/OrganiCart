import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Location/ViewLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Theme.dart';

class CustomerOrderDetails extends StatefulWidget {
  static String id = 'CustomerOrderDetails';
  @override
  _CustomerOrderDetailsState createState() => _CustomerOrderDetailsState();
}

class _CustomerOrderDetailsState extends State<CustomerOrderDetails> {
  OrderClass order;
  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    order = ModalRoute.of(context).settings.arguments;
    for(Map<dynamic,dynamic> element in order.order){
      totalPrice += double.parse(element['TotalPrice']);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),

      ),

      body: Container(
        child: ListView.builder(
            itemCount: order.order.length + 4,
            itemBuilder: (context,index){
              if(index == 0)
                return ListTile(
                  title: Text('MarketName : ' + order.marketName),
                );
              if(index == 1)
                return Center(
                  child: SizedBox(
                    width: width - 30,
                    child: FlatButton(onPressed: (){
                      Navigator.pushNamed(context, ViewLocation.id,
                          arguments: Marker(
                              position: LatLng(order.geopoint.latitude, order.geopoint.longitude),
                              icon: BitmapDescriptor.defaultMarker,
                              markerId: MarkerId(order.geohash),
                              infoWindow: InfoWindow(title: order.marketName))
                      );
                    },
                        color: LightTheme.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 10.0,),
                              Text('View Delivery Location',
                                style: TextStyle(
                                    color: LightTheme.darkGray,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14) ,),
                            ],
                          ),
                        )
                    ),
                  ),
                );
              if(index == 2)
                return  Container(
                  height: 100,
                  child: Column(
                    children: [
                      Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,0,0),
                          child: Text('Products',
                            style: TextStyle(
                                fontSize: 20
                            ),),
                        ),
                      ),
                      Spacer(),
                      Divider(
                        color: LightTheme.greenAccent,
                        thickness: 4,
                      ),
                      Spacer(),
                    ],
                  ),
                );
              index = index-3;

              if(index == order.order.length)
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
                              'Rs. ' + totalPrice.toString(),
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
                title: Text(order.order[index]['ProductName']),
                subtitle: Text('Rs. ' + order.order[index]['TotalPrice']),
                trailing: Text('Amount : ' + order.order[index]['Quantity']),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: ()async{
          Navigator.pop(context);
          await MarketDatabase().OrderDelivered(order);
        },
      ),
    );
  }
}
