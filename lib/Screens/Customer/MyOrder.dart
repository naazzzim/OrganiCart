import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/AuthenticationSystem/Wrapper.dart';
import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Customer/CustomerHome.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  List<dynamic> order;
  MarketClass market;
  MyOrder({this.order,this.market});
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool loading = true;
  UserClass user;
  @override
  void initState() {
    // TODO: implement initState
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
    for(Map<dynamic,dynamic> element in widget.order){
      totalPrice += double.parse(element['TotalPrice']);
    }
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.popUntil(context, ModalRoute.withName(Wrapper.id));
          await MarketDatabase().placeOrder(widget.market.uid, OrderClass(customerName: user.name,order: widget.order,timeStamp: Timestamp.now(),isCompleted: false,marketName: widget.market.marketName));
        },
        child: Icon(
          Icons.chevron_right_sharp
        ),
      ),
      body: ListView.builder(
        itemCount: widget.order.length + 1,
          itemBuilder: (context,index){
          if(index == widget.order.length)
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
