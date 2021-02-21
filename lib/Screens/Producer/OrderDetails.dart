import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class OrderDetails extends StatefulWidget {
  static String id = 'OrderDetails';
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),

      body: Container(
        child: ListView.builder(
            itemCount: 51 + 3,
            itemBuilder: (context,index){
              if(index == 0)
                return ListTile(
                  title: Text('Customer Name : Customer Name'),
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

              if(index == 50)
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
                title: Text('ProductName'),
                subtitle: Text('Rs. TotalPrice'),
                trailing: Text('Amount : ${2.5 * 2} Kg'),
              );
            }),
      ),
    );
  }
}
