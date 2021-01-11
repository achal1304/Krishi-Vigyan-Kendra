import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'crud.dart';

class FeedBack extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;

  FeedBack(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  String fb;
  AsyncSnapshot<DocumentSnapshot> snapshot;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _textController = TextEditingController();
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'अभिप्राय',
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
//      body:Card(
//        shape: RoundedRectangleBorder(
//            side: BorderSide(
//                color: Colors.blue,
//                width: 1.5
//            ),
//            borderRadius: BorderRadius.circular(3)
//        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              height: 200,
              width: MediaQuery.of(context).size.width * 0.95,
              child: SingleChildScrollView(
                child: TextField(
                  controller: _textController,
                  enabled: _isEnabled,
                  decoration: InputDecoration(
                      hintText: "आपला अभिप्राय येथे प्रविष्ट करा"),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
//          padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.6,
              child: GFButton(
                onPressed: () async {
                  fb = _textController.text;
                  if (fb != "") {
                    await Crud().addFeedBack(widget._user.email, fb);
                    setState(() {
                      _isEnabled = false;
                    });
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('आपल्या अभिप्रायाबद्दल धन्यवाद'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }

                  //Navigator.pop(context);
                },
                text: "अभिप्राय पाठवा",
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),
          ],
        ));
  }
}
