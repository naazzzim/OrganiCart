import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';

class MarketDatabase{

  var markets = FirebaseFirestore.instance.collection('Markets');

  Future<MarketClass> getMarket(String market_uid) async {
    MarketClass market;
    await markets.doc(market_uid).get().then((DocumentSnapshot doc){
      market = MarketClass(marketName: doc.data()['Name'],ownerName: doc.data()['Owner'],uid: market_uid,geohash: doc.data()['Location']['geohash'],geopoint: doc.data()['Location']['geopoint']);
    });
    return market;
  }

  Future<void> addProductToMarket(String market_uid,ProductClass product) async {
    await markets.doc(market_uid).collection('Products').add({
      'Name': product.name,
      'Additional': product.additionalInfo,
      'Price': product.price
    });
  }

  Future<void> addMarket(String marketName,String ownerName,Map<dynamic,dynamic> location) async {
    dynamic id = markets.doc().id;
    await markets.doc(id).set({
      'Name': marketName,
      'Owner': ownerName,
      'Location': location,
    });
    await UserDatabase().addMarketToUser(marketName, id);
  }

  Future<void> placeOrder(String market_id,OrderClass order) async {
    dynamic id =  markets.doc(market_id).collection('Orders').doc().id;
    await markets.doc(market_id).collection('Orders').doc(id).set({
      'Name': order.customerName,
      'Order': order.order,
      'TimeStamp': order.timeStamp,
      'Location': {'geohash':order.geohash,'geopoint':order.geopoint},
    });
    await UserDatabase().addOrderToUser(market_id,id, order);
  }

  Future<void> OrderDelivered(OrderClass order) async {
    await markets.doc(order.market_uid).collection('Orders').doc(order.market_order_id).delete();
    await markets.doc(order.market_uid).collection('History').doc(order.market_order_id).set({
      'Name': order.customerName,
      'Order': order.order,
      'TimeStamp': order.timeStamp,
      'Location': {'geohash':order.geohash,'geopoint':order.geopoint},
    });
    await UserDatabase().updateOrderStatus(order);
  }

}