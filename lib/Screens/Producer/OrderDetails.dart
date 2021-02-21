import 'package:farmerApp/Screens/Classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class OrderDetails extends StatefulWidget {
  static String id = 'OrderDetails';
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderClass order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context).settings.arguments;
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
                  title: Text('Customer Name : ' + order.customerName),
                );
                  if(index == 1)
              return ListTile(
              title: Text('Location : Location user user user'),
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
                              'Rs. ' + 100.toString(),
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
    );
  }
}
