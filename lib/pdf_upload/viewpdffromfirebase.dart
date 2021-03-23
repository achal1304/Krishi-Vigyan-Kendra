import 'package:flutter/material.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class ViewPdf extends StatefulWidget {
  String url;
  ViewPdf(String url) {
    url = url;
  }

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PDFDocument doc;
  @override
  Widget build(BuildContext context) {
    //get data from first class
    // String data;
    viewNow() async {
      doc = await PDFDocument.fromURL(widget.url);
      setState(() {});
    }

    Widget Loading() {
      viewNow();
      if (doc == null) {
        return Text("jgjgjggkkj");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Retrieve Pdf"),
      ),
      body: doc == null ? Loading() : PDFViewer(document: doc),
    );
  }
}
