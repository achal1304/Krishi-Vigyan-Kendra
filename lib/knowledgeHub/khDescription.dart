import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
// import 'package:loginkvk/products/registeredusers.dart';

// import 'coursepayment.dart';
import 'package:loginkvk/crud.dart';
import 'package:loginkvk/imageDialog.dart';
import 'package:loginkvk/message.dart';
import 'package:loginkvk/msg.dart';

class CustomCardKHDescription extends StatefulWidget {
  BuildContext c1;

  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardKHDescription({
    @required this.title,
    @required this.description,
    @required this.foldername,
    //@required this.topic,
    @required BuildContext context,
    @required this.isAdmin1,
    @required this.url,
  }) {
    c1 = context;
  }

  final title;
  final description;
  final foldername;

  //final topic;
  final bool isAdmin1;
  // final edate;
  // final stime;
  final url;
  // final type;
  // final venue;

  @override
  _CustomCardKHDescriptionState createState() =>
      _CustomCardKHDescriptionState();
}

class _CustomCardKHDescriptionState extends State<CustomCardKHDescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController mailid = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController contact2 = TextEditingController();
  TextEditingController mailid2 = TextEditingController();
  TextEditingController name3 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController contact3 = TextEditingController();
  TextEditingController mailid3 = TextEditingController();
  TextEditingController name4 = TextEditingController();
  TextEditingController address4 = TextEditingController();
  TextEditingController contact4 = TextEditingController();
  TextEditingController mailid4 = TextEditingController();
  TextEditingController na = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String result = "";
  bool ispresent = false;
  String cname = "";
  String caddress = "";
  String ccontact = "";
  int participants = 1;
  int amount;
  int totalamount;
  String _selectedparticipants;
  String paymentstaus = "";
  List<String> _particip = ["1", "2", "3", "4"];

  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
  }

  Future sendNotification() async {
    final response = await Messaging.sendToTopic(
        title: title.text, body: body.text, topic: widget.description);

    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
  }

  final List<Message> messages = [];

  @override
  void initState() {
    _selectedparticipants = "1";
    super.initState();
    // checkIfLikedOrNot();
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(
          () {
            messages.add(
              Message(
                // title: notification['title'],
                // body: notification['body'],
                title: '${notification['title']}',
                body: '${notification['body']}',
              ),
            );
          },
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
//        .then((dynamic data){
//      setState(() {
//        ispresent = data.ex;
//        print("data exists in initstate" + data.exists.toString());
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: FaIcon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      // backgroundColor: Colors.orangeAccent,
                    ),
                  ),
                ),
                background: GestureDetector(
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.fitHeight,
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                              url: widget.url,
                            ));
                  },
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 28),
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                widget.description,
                maxLines: null,
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget noti() {
    if (widget.isAdmin1 == true) {
      return FlatButton(
        textColor: Colors.white,
        color: Colors.blueAccent,
//        backgroundColor: Colors.blueAccent,
//        elevation: 0.5,
        child: Text(
          "सूचना पाठवा",
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () async {
          await _showNotiDialog();
        },
      );
    }
  }

  _showNotiDialog() async {
    // List<dynamic> arr = widget.registrationform;
    showDialog<String>(
        context: widget.c1,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: title,
                          decoration: InputDecoration(
//                        prefixIcon: Icon(Icons.mail_outline),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "शीर्षक",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 32.0),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 32.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
//                          validator: (mailid) {
//                            if (!emailRegex.hasMatch(mailid)) {
//                              return 'Please enter valid Email';
//                            }
//                            return null;
//                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: body,
                          decoration: InputDecoration(
//                        prefixIcon: Icon(Icons.person),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "शरीर",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 32.0),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 32.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
//                          validator: (name) {
//                            if (name.isEmpty) {
//                              return 'Please enter Name';
//                            }
//                            return null;
//                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        FloatingActionButton.extended(
                          backgroundColor: Colors.blueAccent,
                          elevation: 0.5,
                          label: new Text(
                            "सूचना पाठवा",
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () async {
                            await sendNotification();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
