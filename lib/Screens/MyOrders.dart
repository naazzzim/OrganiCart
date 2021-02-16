import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: 50,
          itemBuilder: (context,index){
          if(index == 49)
            return Container(
              child: Column(
                children: [
                  Divider(
                    color: Colors.blueAccent,
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
                          'Rs 2000',
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
            title: Text('Product Name'),
            subtitle: Text('Rs 50'),
          );
          }),
    );
  }
}
