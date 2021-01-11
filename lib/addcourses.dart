import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'crud.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'registrationform.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class AddCourses extends StatefulWidget {
  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  DateTime _startdate = DateTime.now();
  DateTime _enddate = DateTime.now().add(Duration(days: 7));
  String sdate = "";
  String edate = "";
  String imgUrl = "";
  String ctitle = "";
  String cdesc = "";
  String iurl = "";
  String radioButtonItem = 'Online';
  String radioButtonItemPay = 'Free';
  int payid = 1;
  String offevent = "";
  String payevent = "";
  int id = 1;
  bool value1;
  bool value2;
  bool value3;
  int paymentamount = 0;
  List<String> reqfields = [];
  List<String> arr = ["Name", "Addres", "Contact No.", "Email ID"];

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File sampleImage;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController offlineevent = TextEditingController();
  TextEditingController paidevent = TextEditingController();

  @override
  void initState() {
    value1 = false;
    value2 = false;
    value3 = false;
    offlineevent.text = "";
//    paidevent.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'अभ्यासक्रम जोडा',
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "कोर्स शीर्षक",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: description,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "अभ्यासक्रम वर्णन",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    //controller: address,
                    onTap: () async {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(new FocusNode());

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
                          sdate = DateFormat('MM/dd/yyyy').format(_startdate);
                          edate = DateFormat('MM/dd/yyyy').format(_enddate);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: '''कोर्स प्रारंभ तारीख : $sdate
कोर्सची समाप्ती तारीख : $edate''',
                      hintMaxLines: 2,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 32.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
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
                ),
                paidEvent(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: CupertinoButton(
                    //elevation: 7.0,
                    child: Text('प्रतिमा अपलोड करा'),
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
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "नोंदणी पत्रक : ",
                        textAlign: TextAlign.left,
                      ),
                      MergeSemantics(
                        child: ListTile(
                          title: Text('नाव'),
                          trailing: CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: value1,
                              onChanged: (bool value) {
                                setState(() {
                                  value1 = value;
                                  _savenswitchValue1(value1, "Name");
                                });
                              }),
                          onTap: () {
                            setState(() {
                              value1 = !value1;
                            });
                          },
                        ),
                      ),
                      MergeSemantics(
                        child: ListTile(
                          title: Text('पत्ता'),
                          trailing: CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: value2,
                              onChanged: (bool value) {
                                setState(() {
                                  value2 = value;
                                  _savenswitchValue1(value2, "Address");
                                });
                              }),
                          onTap: () {
                            setState(() {
                              value2 = !value2;
                            });
                          },
                        ),
                      ),
                      MergeSemantics(
                        child: ListTile(
                          title: Text('संपर्क क्रमांक'),
                          trailing: CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: value3,
                              onChanged: (bool value) {
                                setState(() {
                                  value3 = value;
                                  _savenswitchValue1(value3, "Contact No.");
                                });
                              }),
                          onTap: () {
                            setState(() {
                              value3 = !value3;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GFButton(
                    onPressed: () async {
                      ctitle = title.text;
                      cdesc = description.text;
                      offevent = offlineevent.text;
//                      payevent = paidevent.text;
//                      paymentamount = int.parse(paidevent.text);
                      radioButtonCheck();
                      if (_formKey.currentState.validate() && imgUrl != "") {
                        await checkAndUpdate();
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('कोर्स अपलोड केला!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else if (imgUrl == "") {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('कृपया एक प्रतिमा निवडा'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } //Navigator.pop(context);
                    },
                    text: "कोर्स अपलोड करा",
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

//      floatingActionButton: FloatingActionButton.extended(
//        backgroundColor: Colors.blueAccent,
//        label: Text(
//          "Make Registration form",
//          style: TextStyle(
//              decoration: TextDecoration.none,
//              fontSize: 14,
//              color: Colors.white),
//        ),
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => RegistrationForm(
//                description.text
//              ),
//            ),
//          );
//        },
//      ),
    );
  }

  radioButtonCheck() {
    if (radioButtonItemPay == "Paid") {
      paymentamount = int.parse(paidevent.text);
    } else
      paymentamount = 0;
  }

  checkAndUpdate() async {
    Crud().addCourseData(ctitle, cdesc, sdate, edate, radioButtonItem, offevent,
        imgUrl, _startdate, reqfields, paymentamount);
  }

  Widget offlineEvent() {
    if (radioButtonItem == 'Offline') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
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

  Widget paidEvent() {
    if (radioButtonItemPay == 'Paid') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
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
//            if (paidevent.isEmpty) {
//              return 'Please enter amount';
//            }
//            return null;
//          },
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: TextFormField(
          enabled: false,
          controller: paidevent,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "शुल्क = रु. 0",
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
        ),
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

//  regist(bool val, String field) {
//    return MergeSemantics(
//      child: ListTile(
//        title: Text(field),
//        trailing: CupertinoSwitch(
//            activeColor: Colors.blue,
//            value: val,
//            onChanged: (bool value) {
//              setState(() {
//                val = value;
//                _savenswitchValue1(val, field);
//              });
//            }),
//        onTap: () {
//          setState(() {
//            val = !val;
//          });
//        },
//      ),
//    );
//  }
}
