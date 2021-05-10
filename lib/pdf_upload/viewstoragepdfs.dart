import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'pdf_view.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'viewpdffromfirebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

// import 'imagefull.dart';

class PDFFromFirebase extends StatefulWidget {
  @override
  _PDFFromFirebaseState createState() => _PDFFromFirebaseState();
}

class _PDFFromFirebaseState extends State<PDFFromFirebase> {
  static var now = DateTime.now();
  String date = DateFormat('dd-MM-yyyy').format(now);
  String p = '';
  String c = '';
  String filename = "";
  List uu = [];
  List aa;
  List<PDFDocument> pdfdocument;
  String sdate = 'Not set';
  int startindex = 0;
  int endindex = 0;

  Future<void> checkOn() async {
    var now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    DocumentReference documentRef =
        Firestore.instance.collection("pdfupload").document(date);
    DocumentSnapshot doc = await documentRef.get();
    final ss2 =
        await Firestore.instance.collection("pdfupload").document(date).get();

    if (ss2.exists) {
      uu = doc.data['url'];
      // aa = doc.data['url'];
      // for (int i = 0; i < aa.length; i++) {
      //   c = aa[i];

      //   print("c%2");
      //   startindex = c.indexOf('%2') + 2;
      //   print(startindex);
      //   //print(c[79]);
      //   endindex = c.indexOf(".pdf") + 4;
      //   print(endindex);
      //   //print(c[112]);
      //   print("filename:");
      //   print(c.substring(startindex, endindex));
      //   filename = c.substring(startindex, endindex);
      //   uu.add(filename);
      // }
      // print(uu);
      // PDFDocument pd;

      // for (int i = 0; i < uu.length; i++) {
      //   PDFDocument pd = await PDFDocument.fromURL(uu[i]);
      //   pdfdocument.add(pd);
      //   print(uu[i]);
      // }
      setState(() {
        p = 'found';
      });
    } else {
      setState(() {
        p = 'dne';
      });
      print('.................NO>...............');
    }
    // uu = doc.data['url'];
    // setState(() {
    //   p = 'found';
    // });
  }

  Future<void> differentDay(String givenDate) async {
    DocumentReference documentRef =
        Firestore.instance.collection("pdfupload").document(givenDate);
    DocumentSnapshot doc = await documentRef.get();
    final ss = await Firestore.instance
        .collection("pdfupload")
        .document(givenDate)
        .get();
    if (ss.exists) {
      uu = doc.data['url'];
      setState(() {
        p = 'found';
      });
    } else {
      setState(() {
        p = 'dne';
      });
      print('.................NO>...............');
    }
  }

  @override
  void initState() {
    super.initState();

    checkOn().whenComplete(() {
      setState(() {});
      print('..................success.................');
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          'कागदजत्र दर्शन',
          style: TextStyle(color: Colors.black),
        ),

        backgroundColor: Color(0xfffdfcfa),

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
      body: showThis(p),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffdfcfa),
        child: FaIcon(
          FontAwesomeIcons.calendarAlt,
          color: Colors.black,
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
          ).then((date) {
            setState(() {
              sdate = DateFormat('dd-MM-yyyy').format(date);
            });
            print('date................' + sdate);
            differentDay(sdate).whenComplete(() {
              setState(() {});
              print('..................success.................');
            }).catchError((error, stackTrace) {
              print("outer: $error");
            });
          });
        },
      ),
    );
  }

  Widget showThis(String p) {
    if (p == 'found') {
      return ListView.builder(
        itemCount: uu.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            // title: Text(uu[index]),
            title: Text(uu[index].substring(
                uu[index].indexOf('%2') + 2, uu[index].indexOf(".pdf") + 4)),
            leading: Icon(Icons.picture_as_pdf, color: Colors.redAccent),
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.redAccent,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPdf(uu[index]),
                ),
              );
            },
          ));
        },
      );
    } else if (p == 'dne')
      return Center(
        child: Text(
          'कोणत्याही प्रतिमा आढळल्या नाहीत!',
          style: TextStyle(fontSize: 20),
        ),
      );
    else
      return Center(
          child: CircularProgressIndicator(
              //valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              ));
  }
}
