import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/Database/MarketDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/AddNewProduct.dart';
import 'package:farmerApp/Screens/Producer/OrderDetails.dart';
import 'package:farmerApp/Screens/ViewLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Theme.dart';

class ProducerMarketPage extends StatefulWidget {
  final String marketUid;
  ProducerMarketPage({this.marketUid});
  @override
  _ProducerMarketPageState createState() => _ProducerMarketPageState();
}

class _ProducerMarketPageState extends State<ProducerMarketPage> {
  List<ProductClass> products = [];
  List<OrderClass> orders = [];
  bool loading = true;
  MarketClass market;
  @override
  void initState() {
    MarketDatabase().getMarket(widget.marketUid).then((value){
      setState(() {
        market = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Loading():DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(market.marketName),
          bottom: TabBar(
            tabs: [
              Tab(text : "Products"),
              Tab(text : "Orders")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Markets').doc(widget.marketUid).collection('Products').snapshots(),
                builder: (context,snapshot){
                products = [];

                if(!snapshot.hasData){
                  return Loading();
                }

                for(DocumentSnapshot doc in snapshot.data.documents){
                  products.add(ProductClass(name: doc['Name'],additionalInfo: doc['Additional'],price: doc['Price']));
                }
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context,AddNewProduct.id,arguments: widget.marketUid);
                      },
                      child: Icon(Icons.add),
                    ),
                    body: Container(
                      height: MediaQuery.of(context).size.height,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                              padding:
                              const EdgeInsets.fromLTRB(10, 15, 10, 5),
                              sliver: SliverToBoxAdapter(
                                child: FlatButton(onPressed: (){
                                  Navigator.pushNamed(context, ViewLocation.id,
                                    arguments: Marker(
                                    position: LatLng(market.geopoint.latitude, market.geopoint.longitude),
                                    icon: BitmapDescriptor.defaultMarker,
                                    markerId: MarkerId(market.geohash),
                                    infoWindow: InfoWindow(title: market.marketName))
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
                                          Text('View Market Location',
                                            style: TextStyle(
                                                color: LightTheme.darkGray,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14) ,),
                                        ],
                                      ),
                                    )
                                )

                              )),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      color: LightTheme.greenAccent.withOpacity(0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(products[index].name,
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        subtitle:Padding(
                                          padding: const EdgeInsets.fromLTRB(8,10,0,10),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                   text : 'Price : ',
                                                  style: TextStyle(
                                                    color: DarkTheme.darkGray
                                                  ),
                                                ),
                                                TextSpan(
                                                text : products[index].price.toString(),
                                                  style: TextStyle(
                                                      color: DarkTheme.darkGray.withOpacity(0.8)
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:  '\n\nAdditional Info : ',
                                                  style: TextStyle(
                                                      color: DarkTheme.darkGray
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: products[index].additionalInfo ?? "",
                                                  style: TextStyle(
                                                      color: DarkTheme.darkGray.withOpacity(0.8)
                                                  ),
                                                ),
                                              ]
                                            ),
                                          ),
                                        ),
                                        isThreeLine: true,
                                      ),
                                    ),
                                  );
                                },
                                childCount: products.length,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Markets').doc(widget.marketUid).collection('Orders').snapshots(),
                builder: (context,snapshot){

                  orders = [];

                  if(!snapshot.hasData){
                    return Loading();
                  }

                  for(DocumentSnapshot doc in snapshot.data.documents){
                    orders.add(OrderClass(customerName: doc['Name'],order: doc['Order'],timeStamp: doc['TimeStamp']));
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
                              onTap: () {
                                Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index]);
                              },
                              child: Card(
                                color: LightTheme.greenAccent.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Text(orders[index].customerName),
                                  subtitle: Text(DateTime.fromMicrosecondsSinceEpoch(orders[index].timeStamp.microsecondsSinceEpoch).toString().split(':')[0] + ':' + DateTime.fromMicrosecondsSinceEpoch(orders[index].timeStamp.microsecondsSinceEpoch).toString().split(':')[1]),
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
