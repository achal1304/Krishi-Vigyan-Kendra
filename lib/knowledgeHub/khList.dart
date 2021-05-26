import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginkvk/knowledgeHub/customcardkh.dart';

// import 'customCardAudio.dart';

class KHList extends StatefulWidget {
  final bool isAdmin;
  final String foldername;

  const KHList({Key key, @required this.isAdmin, this.foldername})
      : super(key: key);
  @override
  _KHListState createState() => _KHListState();
}

class _KHListState extends State<KHList> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   'Audio Streams',
        //   style: TextStyle(color: Colors.black),
        //   textScaleFactor: 1.2,
        // ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? Firestore.instance
                    .collection(widget.foldername)
                    .where("searchedKey", arrayContains: name)
                    .snapshots()
                : Firestore.instance.collection(widget.foldername).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (snapshot.data.documents.length == 0) return Text("No Data");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Card(
                        child: CustomCardKH(
                            name: document['Name'],
                            context: context,
                            url: document['URL'],
                            desc: document['Description'],
                            isAdmin: widget.isAdmin,
                            foldername: widget.foldername),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
