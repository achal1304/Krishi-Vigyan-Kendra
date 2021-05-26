import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

//import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loginkvk/crud.dart';
import 'package:random_color/random_color.dart';
import 'package:path/path.dart' as Path;

class AddInfo extends StatefulWidget {
  @override
  AddInfoState createState() => AddInfoState();
}

class AddInfoState extends State<AddInfo> {
  String fileUrl = "";
  String name = "";
  TextEditingController _chosenValue = TextEditingController();
  TextEditingController controller = TextEditingController();
  String _path;
  String existingfolder;
  Map<String, String> _paths;
  String _extension;
  FileType _pickType = FileType.audio;
  bool _multiPick = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  File sampleImage;
  String imgUrl = "";
  TextEditingController description = TextEditingController();
  String cdesc;
  final _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // void openFileExplorer() async {
  //   name = controller.text;
  //   _path = null;

  //   _path = await FilePicker.getFilePath(type: _pickType);

  //   uploadToFirebase(name);
  // }

  // uploadToFirebase(String name) {
  //   String fileName = _path.split('/').last;
  //   String filePath = _path;
  //   List<String> arr = [];
  //   String finalfolder;
  //   if (isEditable == true && _chosenValue.text.isNotEmpty) {
  //     finalfolder = _chosenValue.text;
  //   } else if (isEditable == false) {
  //     finalfolder = existingfolder;
  //   }
  //   for (int i = 0; i < name.length; i++) {
  //     arr.insert(i, name.substring(0, name.length - i));
  //   }

  //   upload(fileName, filePath).then((v) {
  //     setState(() {
  //       fileUrl = v;
  //       Crud().addAudioUrl(name, fileUrl, finalfolder, arr);
  //       Crud().addFolderList(finalfolder);
  //     });
  //   });
  // }

  // Future<String> upload(fileName, filePath) async {
  //   String foldern = _chosenValue.text;
  //   String uploadPath = '/$foldern/$fileName';
  //   _extension = fileName.toString().split('.').last;
  //   StorageReference storageRef =
  //       FirebaseStorage.instance.ref().child(uploadPath);
  //   final StorageUploadTask uploadTask = storageRef.putFile(File(filePath));
  //   setState(() {
  //     _tasks.add(uploadTask);
  //   });
  //   final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
  //   final String url = (await downloadUrl.ref.getDownloadURL());

  //   return url;
  // }

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
                    controller: _chosenValue,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Create Folder",
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
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('KHFolderNames')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );

                      return Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      12.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    "Existing Folders",
                                  ),
                                )),
                            new Expanded(
                              flex: 4,
                              child: DropdownButton(
                                value: existingfolder,
                                isDense: true,
                                onChanged: (valueSelectedByUser) {
                                  _onShopDropItemSelected(valueSelectedByUser);
                                },
                                hint: Text('Choose existing folder'),
                                items: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return DropdownMenuItem<String>(
                                    value: document.documentID.toString(),
                                    child: Text(document.documentID.toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                // SizedBox(
                //   height: 15,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "File Name",
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
                    validator: (controller) {
                      if (controller.isEmpty) {
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
                    controller: description,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "File description",
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
//
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GFButton(
                    onPressed: () async {
                      // ctitle = title.text;
                      name = controller.text;
                      cdesc = description.text;
                      // offevent = offlineevent.text;
//                      payevent = paidevent.text;
//                      paymentamount = int.parse(paidevent.text);
                      // radioButtonCheck();
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
                    text: "info अपलोड करा",
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
    );
  }

  Future checkAndUpdate() async {
    // Crud().addCourseData(ctitle, cdesc, sdate, edate, radioButtonItem, offevent,
    //     imgUrl, _startdate, reqfields, paymentamount);
    List<String> arr = [];
    String finalfolder;
    if (_chosenValue.text.isNotEmpty || _chosenValue.text == null) {
      finalfolder = _chosenValue.text;
    } else {
      finalfolder = existingfolder;
    }
    for (int i = 0; i < name.length; i++) {
      arr.insert(i, name.substring(0, name.length - i));
    }
    Crud().addInfoUrl(name, cdesc, imgUrl, finalfolder, arr);
    Crud().addKHList(finalfolder);
    print(name);
    print(cdesc);
  }

  void _onShopDropItemSelected(String newValueSelected) {
    setState(() {
      this.existingfolder = newValueSelected;
    });
  }

  Future<String> getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('/knowledgehub/${Path.basename(sampleImage.path)}');
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
