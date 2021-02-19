import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/AddNewMarket.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/ProducerMarketPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProducerHome extends StatefulWidget {
  @override
  _ProducerHomeState createState() => _ProducerHomeState();
}

class _ProducerHomeState extends State<ProducerHome> {
  UserClass user;
  bool loading = true;
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
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text(
            user.name + '\'s Markets'
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Sign Out",style: TextStyle(
                color: Colors.white
            ),),
            onPressed: () async {
              await AuthServices().signOut();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: ListView.builder(
            itemCount: user.markets.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ProducerMarketPage(marketName: user.markets[index]['Name'],market_uid: user.markets[index]['uid'],);
                  }));
                },
                child: Card(
                  color: Colors.blueAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(user.markets[index]['Name']),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddNew();
          }));
        },
      ),
    );
  }
}
