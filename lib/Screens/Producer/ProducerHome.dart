import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/AddNewMarket.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Producer/ProducerMarketPage.dart';
import 'package:farmerApp/Screens/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProducerHome extends StatefulWidget {
  final UserClass user;
  ProducerHome({this.user});
  @override
  _ProducerHomeState createState() => _ProducerHomeState();
}

class _ProducerHomeState extends State<ProducerHome> {

  List<dynamic> markets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.user.name + '\'s Markets',
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Sign Out",),
            onPressed: () async {
              await AuthServices().signOut();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.email).snapshots(),
        builder: (context, snapshot) {

          if(!snapshot.hasData)
            return Loading();

          markets = snapshot.data['Markets'];

          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: ListView.builder(
                itemCount: markets.length + 1,
                itemBuilder: (context,index){
                  if(index == 0)
                    return SizedBox(height: 10,);
                    index --;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProducerMarketPage(marketUid: markets[index]['uid']);
                      }));
                    },
                    child: Card(
                      color: LightTheme.greenAccent.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Text(markets[index]['Name']),
                      ),
                    ),
                  );
                }),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_business),
        onPressed: (){
          Navigator.pushNamed(context, AddNewMarket.id,arguments: widget.user.name);
        },
      ),
    );
  }
}
