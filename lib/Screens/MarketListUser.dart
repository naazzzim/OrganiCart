import 'package:farmerApp/Screens/Customer/MarketView.dart';
import 'package:farmerApp/Screens/Customer/MyOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';

class MarketListUser extends StatefulWidget {
  @override
  _MarketListUserState createState() => _MarketListUserState();
}

class _MarketListUserState extends State<MarketListUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MarketView();
                  }));
                },
                child: Card(
                  color: Colors.blueAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text('Title'),
                    subtitle: Text('sub Title'),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return MyOrder();
          }));
        },
      ),
    );
  }
}
