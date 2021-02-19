
import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass{
  String name;
  String userType;
  List<dynamic> markets;
  UserClass({this.name,this.markets,this.userType});
}

class ProductClass{
  String name;
  int price;
  String additionalInfo;
  ProductClass({this.name,this.additionalInfo,this.price});
}

class OrderClass{
   String customerName;
   Map<dynamic,dynamic> productMap;
   Timestamp timeStamp;
   String marketName;
   OrderClass({this.customerName,this.productMap,this.timeStamp,this.marketName});
}

class MarketClass{
  String marketName;
  String ownerName;
  String uid;
  MarketClass({this.marketName,this.ownerName,this.uid});
}