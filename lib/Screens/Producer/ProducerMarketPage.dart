import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Producer/AddNewProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProducerMarketPage extends StatefulWidget {
  String marketName;
  String market_uid;
  ProducerMarketPage({this.market_uid,this.marketName});
  @override
  _ProducerMarketPageState createState() => _ProducerMarketPageState();
}

class _ProducerMarketPageState extends State<ProducerMarketPage> {
  List<ProductClass> products = [];
  List<OrderClass> orders = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.marketName),
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
              stream: FirebaseFirestore.instance.collection('Markets').doc(widget.market_uid).collection('Products').snapshots(),
                builder: (context,snapshot){
                products = [];

                if(!snapshot.hasData){
                  return Loading();
                }

                for(DocumentSnapshot doc in snapshot.data.documents){
                  products.add(ProductClass(name: doc['Name'],additionalInfo: doc['Additional'],price: doc['Price']));
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
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      title: Text(products[index].name),
                                      subtitle: Text('Price : ' + products[index].price.toString()),
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
                  );
                }),

            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Markets').doc(widget.market_uid).collection('Orders').snapshots(),
                builder: (context,snapshot){

                  orders = [];

                  if(!snapshot.hasData){
                    return Loading();
                  }

                  for(DocumentSnapshot doc in snapshot.data.documents){
                    orders.add(OrderClass(customerName: doc['Name'],productMap: doc['Product-Quantity'],timeStamp: doc['TimeStamp']));
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
                                  title: Text(orders[index].customerName),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,AddNewProduct.id,arguments: widget.market_uid);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
