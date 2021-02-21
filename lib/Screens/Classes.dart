
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
   List<dynamic> order;
   Timestamp timeStamp;
   String marketName;
   bool isCompleted;
   OrderClass({this.customerName,this.order,this.timeStamp,this.marketName,this.isCompleted});
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