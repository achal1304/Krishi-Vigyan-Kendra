import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Image Plugin
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'demo.dart';
import 'package:path/path.dart' as Path;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'pdf_view.dart';

//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PDFupload extends StatefulWidget {
  @override
  _PDFuploadState createState() => new _PDFuploadState();
}

class _PDFuploadState extends State<PDFupload> {
  File sampleImage;
  String name;
  TextEditingController cont;
  String imgUrl = "";
  bool isLoaded;
  String docname;
  PDFDocument document;

  void _clear() {
    setState(() => sampleImage = null);
  }

  Future<void> getImage() async {
    var tempImage = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    setState(() {
      sampleImage = tempImage;
    });
    if (sampleImage != null) {
      document = await PDFDocument.fromFile(sampleImage);
      // docname = sampleImage.path.replaceAll(
      //     "/data/user/0/com.example.loginkvk/cache/file_picker", "");
    } else
      document = null;
  }

  List listUrl = [];

  String sdate = "Not set";
  String sel_date = "Not set";

  @override
  void initState() {
    // checkAtStart().then((value) {
    //   isLoaded = value;
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'कागदजत्र अपलोड करा',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (sampleImage != null) ...[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(32),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        // child: PDFViewer(
                        //   document: document, zoomSteps: 1,
                        //   lazyLoad: false,
                        //   // uncomment below line to scroll vertically
                        //   scrollDirection: Axis.vertical,

                        //   //uncomment below code to replace bottom navigation with your own
                        //   navigationBuilder: (context, page, totalPages,
                        //       jumpToPage, animateToPage) {
                        //     return ButtonBar(
                        //       alignment: MainAxisAlignment.spaceEvenly,
                        //       children: <Widget>[
                        //         // IconButton(
                        //         //   icon: Icon(Icons.first_page),
                        //         //   onPressed: () {
                        //         //     jumpToPage()(page: 0);
                        //         //   },
                        //         // ),
                        //         IconButton(
                        //           icon: Icon(Icons.arrow_back),
                        //           onPressed: () {
                        //             animateToPage(page: page - 2);
                        //           },
                        //         ),
                        //         IconButton(
                        //           icon: Icon(Icons.arrow_forward),
                        //           onPressed: () {
                        //             animateToPage(page: page);
                        //           },
                        //         ),
                        //         IconButton(
                        //           icon: Icon(Icons.last_page),
                        //           onPressed: () {
                        //             jumpToPage(page: totalPages - 1);
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // )
                        child: Text("PDF selected = " +
                            '${Path.basename(sampleImage.path)}')
                        // Image.file(
                        //   sampleImage,
                        //   width: MediaQuery.of(context).size.width * .45,
                        // ),
                        ),
                  ),
                  ButtonTheme(
                    child: Uploader(
                      file: sampleImage,
                      sel_date: sel_date,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.4,
                    child: FlatButton.icon(
                      label: Text(
                        "हटवा",
                        style: TextStyle(color: Colors.white),
                      ),

                      color: Colors.redAccent,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      //shape: GFButtonShape.pills,
                      onPressed: _clear,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.4,
                    child: FlatButton.icon(
                      label: Text(
                        "प्रतिमा पहा",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFVieww(document)),
                        );
                        // _clear();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Colors.blueAccent,
                      icon: Icon(Icons.view_compact, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Center(
              child: Text(
                'कोणतीही प्रतिमा निवडली नाही!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.calendarAlt,
                size: 30,
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2022),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.blue, //Head background
                        accentColor: Colors.blue, //selection color
                        colorScheme: ColorScheme.light(primary: Colors.blue),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                        //dialogBackgroundColor: Colors.white,//Background color
                      ),
                      child: child,
                    );
                  },
                ).then((date) {
                  setState(() {
                    sel_date = DateFormat('dd-MM-yyyy').format(date);
                  });
                  //print('date................' + sdate);
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 30,
              ),
              onPressed: () {
                getImage();
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //   backgroundColor: Colors.orangeAccent,
      //   onPressed: () {
      //     getImage();
      //     // then((v) => setState(() {
      //     //       imgUrl = v;
      //     //       addTo(imgUrl);
      //     //     }));
      //     //addTo(imgUrl);
      //   },
      //   tooltip: 'Add Image',
      //   child: new Icon(Icons.add_photo_alternate),
      // ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;
  final sel_date;

  const Uploader({Key key, this.file, this.sel_date}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  File sampleImage;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://kvk-iskcon.appspot.com');

  StorageUploadTask _uploadTask;

  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_uploadTask.isComplete)
                Text('प्रतिमा यशस्वीरित्या अपलोड केली!',
                    style: TextStyle(
                        // color: Colors.greenAccent,
                        height: 2,
                        fontSize: 20)),
              if (_uploadTask.isInProgress)
                Column(
                  children: <Widget>[
                    LinearProgressIndicator(value: progressPercent),
                    Text(
                      '${(progressPercent * 100).toStringAsFixed(2)} % ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
            ],
          );
        },
      );
    } else {
      return Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.4,
            child: FlatButton.icon(
                color: Colors.blue,
                label: Text(
                  'अपलोड करा',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {
                  startUpload().then((v) => setState(() {
                        imgUrl = v;
                        addTo(imgUrl, widget.sel_date);
                      }));
                  //addTo(imgUrl);

                  //addTo(imgUrl);
                }),
          ),
        ],
      );
    }
  }

  Future<String> startUpload() async {
    String filePath = '/pdfupload/${Path.basename(widget.file.path)}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
    final StorageTaskSnapshot downloadUrl = (await _uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }

  addTo(String url, String sel_date) async {
    String date;
    DocumentReference documentRef;
    if (sel_date == "Not set") {
      var now = DateTime.now();
      date = DateFormat('dd-MM-yyyy').format(now);
      documentRef = Firestore.instance.collection("pdfupload").document(date);
    } else {
      documentRef =
          Firestore.instance.collection("pdfupload").document(sel_date);
      date = sel_date;
    }

    final ss =
        await Firestore.instance.collection("pdfupload").document(date).get();
    if (ss.exists) {
      Firestore.instance.runTransaction(
        (transaction) async {
          await documentRef.updateData({
            'url': FieldValue.arrayUnion([url])
          });
          print("daily darshan Data added!");
        },
      );
    } else {
      Firestore.instance.runTransaction(
        (transaction) async {
          await documentRef.setData({
            'url': FieldValue.arrayUnion([url])
          });
          print("daily darshan Data added!");
        },
      );
    }
  }
}
