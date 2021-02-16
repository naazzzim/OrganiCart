import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Name of the market'),
          bottom: TabBar(
            tabs: [
              Tab(text : "Products"),
              Tab(text : "Orders")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
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
                                title: Text('Name : Product Name'),
                                subtitle: Text('Price : Rs 50'),
                              ),
                            ),
                          );
                        },
                        childCount: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                                title: Text('Name : Product Name'),
                                subtitle: Text('Price : Rs 50'),
                              ),
                            ),
                          );
                        },
                        childCount: 50,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
