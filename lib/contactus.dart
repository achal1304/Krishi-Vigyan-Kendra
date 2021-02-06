import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'आमच्याशी संपर्क साधा',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            elevation: 0.7,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: '02465-227757'));
                    Toast.show("Number copied to clipboard", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  // title: Text('Phone Number : '),
                  title: Text('फोन नंबर: '),
                  subtitle: Text('02465-227757'),
                  trailing: Icon(Icons.phone),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0.7,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: 'kvksagroli@gmail.com'));
                    Toast.show("Email copied to clipboard", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  title: Text('ईमेल:'),
                  subtitle: Text('kvksagroli@gmail.com'),
                  trailing: Icon(Icons.alternate_email),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
