import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/AuthenticationSystem/Auth.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Customer/MarketView.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/AddNewProduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerHome extends StatefulWidget {
  static String id = 'CustomerHome';
  UserClass user;
  CustomerHome({this.user});
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  List<MarketClass> markets = [];
  List<OrderClass> orders = [];
  Map<dynamic,dynamic> yourOrder = {};
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name + '\'s Dashboard'),
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
          bottom: TabBar(
            tabs: [
              Tab(text : "Markets"),
              Tab(text : "Yours Orders")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Markets').snapshots(),
                builder: (context,snapshot){
                  markets = [];

                  if(!snapshot.hasData){
                    return Loading();
                  }

                  for(DocumentSnapshot doc in snapshot.data.documents){
                    markets.add(MarketClass(marketName: doc['Name'],ownerName: doc['Owner'],uid: doc.id));
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width - 20,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text('Location : '),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: SelectableText(
                                          'This is my Location, testing testing testing testing',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, MarketView.id,arguments: markets[index]);
                                  },
                                  child: Card(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      title: Text(markets[index].marketName),
                                      subtitle: Text( markets[index].ownerName),
                                    ),
                                  ),
                                );
                              },
                              childCount: markets.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.email).collection('UserOrders').snapshots(),
                builder: (context,snapshot){

                  orders = [];

                  if(!snapshot.hasData){
                    return Loading();
                  }

                  for(DocumentSnapshot doc in snapshot.data.documents){
                    orders.add(OrderClass(marketName: doc['MarketName'],order: doc['Order'],timeStamp: doc['TimeStamp'],isCompleted: doc['isCompleted']));
                  }

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      title: Text(orders[index].marketName),
                                      subtitle: Text(DateTime.fromMicrosecondsSinceEpoch(orders[index].timeStamp.microsecondsSinceEpoch).toString()),
                                    ),
                                  ),
                                );
                              },
                              childCount: orders.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
