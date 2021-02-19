import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmerApp/Database/UserDatabase.dart';
import 'package:farmerApp/Screens/Classes.dart';

class MarketDatabase{

  var markets = FirebaseFirestore.instance.collection('Markets');

  Future<void> addProductToMarket(String market_uid,ProductClass product) async {
    await markets.doc(market_uid).collection('Products').add({
      'Name': product.name,
      'Additional': product.additionalInfo,
      'Price': product.price
    });
  }

  Future<void> addMarket(String marketName,String ownerName) async {
    dynamic id = markets.doc().id;
    await markets.doc(id).set({
      'Name': marketName,
      'Owner': ownerName
    });
    await UserDatabase().addMarketToUser(marketName, id);
  }

}