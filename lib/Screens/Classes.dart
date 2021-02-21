
import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass{
  String name;
  String userType;
  List<dynamic> markets;
  UserClass({this.name,this.markets,this.userType});
}

class ProductClass{
  String name;
  String price;
  String additionalInfo;
  ProductClass({this.name,this.additionalInfo,this.price});
}

class OrderClass{
   String customerName;
   String market_uid;
   String market_order_id;
   String customer_order_id;
   List<dynamic> order;
   Timestamp timeStamp;
   String marketName;
   GeoPoint geopoint;
   String geohash;
   bool isCompleted;
   OrderClass({this.customerName,this.order,this.timeStamp,this.marketName,this.isCompleted,this.geopoint,this.geohash,this.market_uid,this.customer_order_id,this.market_order_id});
}

class MarketClass{
  String marketName;
  String ownerName;
  GeoPoint geopoint;
  String geohash;
  String uid;
  MarketClass({this.marketName,this.ownerName,this.uid,this.geohash,this.geopoint});
}

class GeoLocation{
  GeoPoint geopoint;
  String geohash;
  GeoLocation({this.geopoint,this.geohash});
}