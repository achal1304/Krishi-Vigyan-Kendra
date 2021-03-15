import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path;

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  // PlatformFile _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: _multiPick,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButton(
                      hint: const Text('LOAD PATH FROM'),
                      value: _pickingType,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          child: const Text('FROM AUDIO'),
                          value: FileType.audio,
                        ),
                        DropdownMenuItem(
                          child: const Text('FROM IMAGE'),
                          value: FileType.image,
                        ),
                        DropdownMenuItem(
                          child: const Text('FROM VIDEO'),
                          value: FileType.video,
                        ),
                        DropdownMenuItem(
                          child: const Text('FROM MEDIA'),
                          value: FileType.media,
                        ),
                        DropdownMenuItem(
                          child: const Text('FROM ANY'),
                          value: FileType.any,
                        ),
                        DropdownMenuItem(
                          child: const Text('CUSTOM FORMAT'),
                          value: FileType.custom,
                        ),
                      ],
                      onChanged: (value) => setState(() {
                            _pickingType = value;
                            if (_pickingType != FileType.custom) {
                              _controller.text = _extension = '';
                            }
                          })),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 100.0),
                  child: _pickingType == FileType.custom
                      ? TextFormField(
                          maxLength: 15,
                          autovalidateMode: AutovalidateMode.always,
                          controller: _controller,
                          decoration:
                              InputDecoration(labelText: 'File extension'),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                        )
                      : const SizedBox(),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 200.0),
                  child: SwitchListTile.adaptive(
                    title:
                        Text('Pick multiple files', textAlign: TextAlign.right),
                    onChanged: (bool value) =>
                        setState(() => _multiPick = value),
                    value: _multiPick,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _openFileExplorer(),
                        child: const Text("Open file picker"),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectFolder(),
                        child: const Text("Pick folder"),
                      ),
                      ElevatedButton(
                        onPressed: () => _clearCachedFiles(),
                        child: const Text("Clear temporary files"),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (BuildContext context) => _loadingPath
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator(),
                        )
                      : _directoryPath != null
                          ? ListTile(
                              title: const Text('Directory path'),
                              subtitle: Text(_directoryPath),
                            )
                          : _paths != null
                              ? Container(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  child: Scrollbar(
                                      child: ListView.separated(
                                    itemCount:
                                        _paths != null && _paths.isNotEmpty
                                            ? _paths.length
                                            : 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final bool isMultiPath =
                                          _paths != null && _paths.isNotEmpty;
                                      final String name = 'File $index: ' +
                                          (isMultiPath
                                              ? _paths
                                                  .map((e) => e.name)
                                                  .toList()[index]
                                              : _fileName ?? '...');
                                      final path = _paths
                                          .map((e) => e.path)
                                          .toList()[index]
                                          .toString();

                                      return ListTile(
                                        title: Text(
                                          name,
                                        ),
                                        subtitle: Text(path),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                  )),
                                )
                              : const SizedBox(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
 List<PlatformFile> _sampleImage;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://kvk-iskcon.appspot.com');

  StorageUploadTask _uploadTask;

  String imgUrl = "";

  Widget builddd(BuildContext context) {
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
                        addTo(imgUrl);
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
    // File f = File(filesss[0].path)
    // File f = File(widget.filess.path);
    for (int i =0;i<_paths.length;i++){

      List<File> f;
      File fii = File(_paths[i].path);
    
    String filePath = '/daily/${Path.basename(_paths[i].path)}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_paths[i].path);
    });
    final StorageTaskSnapshot downloadUrl = (await _uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
    }
    
  }

  addTo(String url) async {
    String date;
    DocumentReference documentRef;

    documentRef = Firestore.instance.collection("daily").document(date);

    final ss =
        await Firestore.instance.collection("daily").document(date).get();
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

}

class Uploader extends StatefulWidget {
  final List<PlatformFile> filess;

  const Uploader({Key key, this.filess}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  List<PlatformFile> _sampleImage;
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
                        addTo(imgUrl);
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
    // File f = File(filesss[0].path)
    // File f = File(widget.filess.path);

    String filePath = '/daily/${Path.basename(widget.filess.path)}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.filess.path);
    });
    final StorageTaskSnapshot downloadUrl = (await _uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }

  addTo(String url) async {
    String date;
    DocumentReference documentRef;

    documentRef = Firestore.instance.collection("daily").document(date);

    final ss =
        await Firestore.instance.collection("daily").document(date).get();
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
