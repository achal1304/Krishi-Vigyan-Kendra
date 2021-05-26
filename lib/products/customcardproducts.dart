import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loginkvk/products/productsdescription.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:loginkvk/coursedescription.dart';
import 'package:loginkvk/crud.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class CustomCardProducts extends StatefulWidget {
  BuildContext c1;

  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardProducts(
      {@required this.title,
      @required this.description,
      //@required this.topic,
      @required BuildContext context,
      @required this.isAdmin1,
      // @required this.edate,
      //@required this.stime,
      @required this.url,
      //@required this.type,
      //@required this.venue,
      @required this.useremail,
      @required this.usercoursename,
      //@//required this.startdatetimestamp,
      //@required this.regform,
      @required this.payamount,
      @required this.weight}) {
    c1 = context;
  }

  final title;
  final description;

  //final topic;
  final bool isAdmin1;
  //final edate;
  //final stime;
  final url;
  //final type;
  //final venue;
  final useremail;
  final usercoursename;
  // final startdatetimestamp;
  //final regform;
  final int payamount;
  final int weight;

  @override
  _CustomCardProductsState createState() => _CustomCardProductsState();
}

class _CustomCardProductsState extends State<CustomCardProducts> {
  DateTime _startdate = DateTime.now();
  DateTime _enddate = DateTime.now().add(Duration(days: 7));
  // String sdate = "";
  // String edate = "";
  String imgUrl = "";
  String ctitle = "";
  String cdesc = "";
  //String iurl = "";
  //String radioButtonItem = 'Online';
  //String radioButtonItemPay = 'Free';
  //int payid = 1;
  //String offevent = "";
  //String payevent = "";
  int id = 1;
  bool value1;
  bool value2;
  bool value3;
  //int paymentamount = 0;
  //List<String> reqfields = [];
  //List<String> arr = ["Name", "Addres", "Contact No.", "Email ID"];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File sampleImage;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController paidevent = TextEditingController();
  //TextEditingController offlineevent = TextEditingController();
  //TextEditingController paidevent = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int payevent;
  int weightstring;

  @override
  void initState() {
    value1 = false;
    value2 = false;
    value3 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin1 == true) {
      return Slidable(
        actionExtentRatio: 0.25,
        child: Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomCardProductsDescription(
                            title: widget.title,
                            description: widget.description,
                            //topic: document['Topic'],
                            context: context,
                            isAdmin1: widget.isAdmin1,
                            // edate: widget.edate,
                            // stime: widget.stime,
                            url: widget.url,
                            // type: widget.type,
                            // venue: widget.venue,
                            // startdatetimestamp: widget.startdatetimestamp,
                            useremail: widget.useremail,
                            usercoursename: widget.usercoursename,
                            // registrationform: widget.regform,
                            payamount: widget.payamount,
                            weight: widget.weight)),
                  );
                },
              ),
              Text(
                widget.title,
                maxLines: null,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
//                            ),
              ),
              SizedBox(
                height: 10,
              ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 // child: Row(
//                 //   children: <Widget>[
//                 child: Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
// //                          FittedBox(
// //                            child:

//                       // Text()
//                       // eventVenue()
// //                        FittedBox(
// //                          child: Row(
// //                            children: <Widget>[
// //                              Icon(Icons.location_on),
// //                              SizedBox(
// //                                width: 5,
// //                              ),
// //                              Text(
// //                                widget.venue,
// //                                style: TextStyle(
// //                                  fontSize: 20.0,
// //                                  color: Color(0xFF000000),
// //                                ),
// //                              ),
// //                            ],
// //                          ),
// //                        ),
//                     ],
//                   ),
//                 ),
//                 // Expanded(
//                 //     child: Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.end,
//                 //   children: <Widget>[
//                 //     Text(
//                 //       "मध्ये सुरू होते",
//                 //       textAlign: TextAlign.right,
//                 //       style: TextStyle(
//                 //         fontSize: 20.0,
//                 //         color: Color(0xFF000000),
//                 //       ).copyWith(
//                 //         fontWeight: FontWeight.w300,
//                 //       ),
//                 //     ),
//                 //     Text(
//                 //       widget.startdatetimestamp + " दिवस",
//                 //       textAlign: TextAlign.right,
//                 //       style: TextStyle(
//                 //         fontSize: 20.0,
//                 //         color: Color(0xFF000000),
//                 //       ).copyWith(
//                 //         fontWeight: FontWeight.w300,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // )),
//                 //   ],
//                 // ),
//               ),
//            SizedBox(
//              height: MediaQuery
//                  .of(context)
//                  .size
//                  .height * 0.01,
//            ),
//            ListTile(
//              leading:GFAvatar(
//                shape: GFAvatarShape.standard,
//                size: 80,
//                //radius: 25,
//                backgroundImage: NetworkImage(widget.url),
//              ),
//              title: Text(widget.title),
//              subtitle: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(widget.edate),
//                  Text(widget.stime),
//                ],
//              ),

//            )
            ],
          ),
        ),
        actions: <Widget>[
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: () {
              _showAlertDialog(widget.description);
              //Crud().deleteData(widget.topic);
            },
          ),
        ],
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () {
              _showEditDialog(widget.description);
//              Crud().deleteData(widget.topic);
            },
          ),
        ],
        actionPane: SlidableDrawerActionPane(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(top: 5.0),
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.fitWidth,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomCardProductsDescription(
                        title: widget.title,
                        description: widget.description,
                        //topic: document['Topic'],
                        context: context,
                        isAdmin1: widget.isAdmin1,
                        // edate: widget.edate,
                        // stime: widget.stime,
                        url: widget.url,
                        // type: widget.type,
                        //venue: widget.venue,
                        // startdatetimestamp: widget.startdatetimestamp,
                        useremail: widget.useremail,
                        usercoursename: widget.usercoursename,
                        //registrationform: widget.regform,
                        payamount: widget.payamount,
                        weight: widget.weight),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              maxLines: null,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
//                            ),
            ),
            SizedBox(
              height: 10,
            ),
/*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                          FittedBox(
//                            child:
                        Text(
                          widget.title,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
//                            ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "मध्ये सुरू होते",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF000000),
                        ).copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        widget.startdatetimestamp + "दिवस",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF000000),
                        ).copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),*/
          ],
        ),
      );
    }
  }

  _showEditDialog(String topic) async {
    await showDialog<String>(
        context: widget.c1,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              //contentPadding: const EdgeInsets.all(16.0),
              content:
//                Wrap(
//                  children: <Widget>[
                  SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            controller: title,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "कोर्स शीर्षक",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: 32.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (title) {
                              if (title.isEmpty) {
                                return 'कृपया काही शीर्षक प्रविष्ट करा';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            controller: description,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "अभ्यासक्रम वर्णन",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: 32.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (description) {
                              if (description.isEmpty) {
                                return 'कृपया काही वर्णन प्रविष्ट करा';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        /* Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            maxLines: null,
                            //controller: address,
                            onTap: () async {
                              // Below line stops keyboard from appearing
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              final List<DateTime> picked =
                                  await DateRangePicker.showDatePicker(
                                context: context,
                                initialFirstDate: _startdate,
                                initialLastDate: _enddate,
                                firstDate: DateTime(DateTime.now().year - 50),
                                lastDate: DateTime(DateTime.now().year + 50),
                              );
                              if (picked != null && picked.length == 2) {
                                setState(() {
                                  _startdate = picked[0];
                                  _enddate = picked[1];
                                  sdate = DateFormat('MM/dd/yyyy')
                                      .format(_startdate);
                                  edate =
                                      DateFormat('MM/dd/yyyy').format(_enddate);
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: '''प्रारंभ तारीख: $sdate

शेवटची तारीख : $edate''',
                              hintMaxLines: 2,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: 32.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (_startdate) {
                              if (sdate.isEmpty && edate.isEmpty) {
                                return 'कृपया तारखा निवडा';
                              }
                              return null;
                            },
                          ),
                        ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        /* Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: id,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItem = 'Online';
                                      id = 1;
                                    });
                                  },
                                ),
                                Text(
                                  'ऑनलाईन',
                                  style: new TextStyle(fontSize: 17.0),
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: id,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItem = 'Offline';
                                      id = 2;
                                    });
                                  },
                                ),
                                Text(
                                  'ऑफलाइन',
                                  style: new TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        offlineEvent(),
                        */
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        /* Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: payid,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemPay = 'Free';
                                      payid = 1;
                                    });
                                  },
                                ),
                                Text(
                                  'फुकट',
                                  style: new TextStyle(fontSize: 17.0),
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: payid,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemPay = 'Paid';
                                      payid = 2;
                                    });
                                  },
                                ),
                                Text(
                                  'पैसे दिले',
                                  style: new TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )*/
                        // paidEvent(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CupertinoButton(
                            //elevation: 7.0,
                            child: Text(
                              'प्रतिमा अपलोड करा',
                              style: TextStyle(fontSize: 14),
                            ),
                            //textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              getImage().then((v) => setState(() {
                                    imgUrl = v;
                                  }));
                            },
                          ),
                        ),
                        Divider(thickness: 0.5),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        imageCheck(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Divider(thickness: 0.5),
                        // Container(
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text(
                        //         "नोंदणी पत्रक :",
                        //         textAlign: TextAlign.left,
                        //       ),
                        //       MergeSemantics(
                        //         child: ListTile(
                        //           title: Text('नाव'),
                        //           trailing: CupertinoSwitch(
                        //               activeColor: Colors.blue,
                        //               value: value1,
                        //               onChanged: (bool value) {
                        //                 setState(() {
                        //                   value1 = value;
                        //                   _savenswitchValue1(value1, "Name");
                        //                 });
                        //               }),
                        //           onTap: () {
                        //             setState(() {
                        //               value1 = !value1;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       MergeSemantics(
                        //         child: ListTile(
                        //           title: Text('पत्ता'),
                        //           trailing: CupertinoSwitch(
                        //               activeColor: Colors.blue,
                        //               value: value2,
                        //               onChanged: (bool value) {
                        //                 setState(() {
                        //                   value2 = value;
                        //                   _savenswitchValue1(value2, "Address");
                        //                 });
                        //               }),
                        //           onTap: () {
                        //             setState(() {
                        //               value2 = !value2;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       MergeSemantics(
                        //         child: ListTile(
                        //           title: Text('संपर्क क्रमांक'),
                        //           trailing: CupertinoSwitch(
                        //               activeColor: Colors.blue,
                        //               value: value3,
                        //               onChanged: (bool value) {
                        //                 setState(() {
                        //                   value3 = value;
                        //                   _savenswitchValue1(
                        //                       value3, "Contact No.");
                        //                 });
                        //               }),
                        //           onTap: () {
                        //             setState(() {
                        //               value3 = !value3;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: GFButton(
                            onPressed: () {
                              payevent = int.parse(paidevent.text);
                              ctitle = title.text;
                              cdesc = description.text;
                              weightstring = int.parse(weight.text);

                              if (_formKey.currentState.validate() &&
                                  imgUrl != "") {
                                Crud().deleteCourseData(widget.description);
                                checkAndUpdate();

                                Navigator.pop(context);
                              } else if (imgUrl == "") {}
                            },
                            text: "कोर्स संपादित करा",
                            shape: GFButtonShape.pills,
                            size: GFSize.LARGE,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    )),
              ),
//                  ],
            );
          });
        });
  }

  _showAlertDialog(String desc) {
    showDialog<String>(
      context: widget.c1,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "कोर्स हटवायचा?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'नाही',
                            style: TextStyle(
                                color: Colors.red.shade400, fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        VerticalDivider(),
                        FlatButton(
                          child: Text(
                            'होय',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          onPressed: () {
                            //Crud().deleteData(widget.desc);
                            Crud().deleteproductData(widget.description);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
  Widget eventVenue() {
    if (widget.venue == "") {
      return FittedBox(
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 5,
            ),
            Text(
              "ऑनलाइन कार्यक्रम",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      );
    } else {
      return FittedBox(
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.venue,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      );
    }
  }
*/
/*
  radioButtonCheck() {
    if (radioButtonItemPay == "Paid") {
      paymentamount = int.parse(paidevent.text);
    } else
      paymentamount = 0;
  }
*/
  Future checkAndUpdate() async {
    print(
        "*********************************************************************" +
            "title:" +
            ctitle +
            "desc: " +
            cdesc +
            "Url :" +
            imgUrl +
            "paye: " +
            payevent.toString() +
            weightstring.toString());
    Crud().addProductData(ctitle, cdesc, imgUrl, payevent, weightstring);
  }

/*
  Widget offlineEvent() {
    if (radioButtonItem == 'Offline') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          controller: offlineevent,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "कार्यक्रमाचे ठिकाण",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                borderRadius: BorderRadius.circular(25.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 32.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          validator: (offlineevent) {
            if (offlineevent.isEmpty) {
              return 'कृपया ठिकाण जोडा';
            }
            return null;
          },
        ),
      );
    } else
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0,
      );
  }
*/
/*
  Widget paidEvent() {
    if (radioButtonItemPay == 'Paid') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          controller: paidevent,
          maxLines: null,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "तिकिट रक्कम प्रविष्ट करा",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                borderRadius: BorderRadius.circular(25.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 32.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
//          validator: (paidevent) {
//            if (paidevent == "0" || paidevent.isEmpty) {
//              return 'Please enter amount';
//            }
//            return null;
//          },
        ),
      );
    } else
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0,
      );
  }

  _savenswitchValue1(bool value1, String name) async {
    if (value1 == true) {
      setState(() {
        reqfields.add(name);
      });
    } else
      setState(() {
        reqfields.remove(name);
      });
  }
*/
  Future<String> getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('/events/${Path.basename(sampleImage.path)}');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

    if (task.isInProgress) CircularProgressIndicator();
    await task.onComplete;

    print('File Uploaded');
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    //print('URL Is $url');

    return url;
  }

  Widget imageCheck() {
    if (imgUrl == "") {
      return Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Text("कृपया एक प्रतिमा निवडा"));
    } else
      return Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            fit: BoxFit.fitWidth,
          ));
  }
}
