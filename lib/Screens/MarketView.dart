import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyOrders.dart';
import 'Theme.dart';

class MarketView extends StatefulWidget {
  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name of the market'),
      ),
      body: Container(
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
                          onTap: ()async {
                            int value = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    backgroundColor: LightTheme.starWhite,
                                    title: Text(
                                      'How many kg ?',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: _controller,
                                            keyboardType: TextInputType.number,
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context,int.parse(_controller.text ?? '0'));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              child: Container(
                                                width: 100,
                                                height: 50,
                                                color: Colors.blueAccent,
                                                child: Center(
                                                  child: Text(
                                                    'Done',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return MyOrders();
          }));
        },
      ),
    );
  }
}
