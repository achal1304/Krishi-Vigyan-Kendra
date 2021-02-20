import 'package:flutter/cupertino.dart';

class Post {
  String timestamp;
  String state;
  String district;
  String market;
  String commodity;
  String variety;
  String arrival_date;
  String min_price;
  String max_price;
  String modal_price;

  Post({
    @required this.timestamp,
    @required this.state,
    @required this.district,
    @required this.market,
    @required this.commodity,
    @required this.variety,
    @required this.arrival_date,
    @required this.min_price,
    @required this.max_price,
    @required this.modal_price,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      timestamp: json["timestamp"] as String,
      state: json["state"] as String,
      district: json["district"] as String,
      market: json["market"] as String,
      commodity: json["commodity"] as String,
      variety: json["variety"] as String,
      arrival_date: json["arrival_date"] as String,
      min_price: json["min_price"] as String,
      max_price: json["max_price"] as String,
      modal_price: json["modal_price"] as String,
    );
  }
}
