import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:translator/translator.dart';

// final translator = GoogleTranslator();
// const kGoogleApiKey = "AIzaSyDA2vSkZdEb9_8Gz-ivOP1vW8QOu01xEW0";

// var _translateddata;
// Future<String> translateanyString(String _datatobetranslated) async {
//   _translateddata =
//       await translator.translate(_datatobetranslated, from: 'en', to: 'mr');
//   return _translateddata.toString();
// }

String st;
String dist;
String commo;
String mark;
String va;

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
    // translateanyString(json["commodity"].toString()).then((value) {
    //   commo = value;
    // });
    // translateanyString(json["state"].toString()).then((value) {
    //   st = value;
    // });
    // translateanyString(json["district"].toString()).then((value) {
    //   dist = value;
    // });
    // translateanyString(json["market"].toString()).then((value) {
    //   mark = value;
    // });
    // translateanyString(json["variety"].toString()).then((value) {
    //   va = value;
    // });
    return Post(
      timestamp: json["timestamp"] as String,
      // state: st,
      // district: dist,
      // market: mark,
      // commodity: commo,
      // variety: mark,
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
//  timestamp: json["टाइमस्टॅम्प"] as String,
//       state: json["राज्य"] as String,
//       district: json["जिल्हा"] as String,
//       market: json["बाजार"] as String,
//       commodity: json["कमोडिटी"] as String,
//       variety: json["विविध"] as String,
//       arrival_date: json["arrivent_date"] as String,
//       min_price: json["min_price"] as String,
//       max_price: json["max_price"] as String,
//       modal_price: json["modal_price"] as String,
