/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:translator/translator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import "package:google_maps_webservice/geocoding.dart";

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }
const kGoogleApiKey = "AIzaSyDA2vSkZdEb9_8Gz-ivOP1vW8QOu01xEW0";

class WeatherFore extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;

  WeatherFore(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _WeatherForeState createState() => _WeatherForeState();
}

class _WeatherForeState extends State<WeatherFore> {
  final translator = GoogleTranslator();
  String key = 'c5a7cdb13e89746a2bd5ad742e8d2c40';
  WeatherFactory ws;
  List<Weather> _data = [];
  var _translateddata;
  AppState _state = AppState.NOT_DOWNLOADED;
  double lat, lon;
  Prediction p;
  TextEditingController address = TextEditingController();
  final places =
      new GoogleMapsPlaces(apiKey: "AIzaSyDA2vSkZdEb9_8Gz-ivOP1vW8QOu01xEW0");
  bool _isAddEditable = false;

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key);
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat, lon);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
    _translateddata =
        await translator.translate(_data.toString(), from: 'en', to: 'mr');
    print(_translateddata.toString());
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat, lon);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });

    _translateddata =
        await translator.translate(_data.toString(), from: 'en', to: 'mr');
    print(_translateddata.toString());
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          // return ListTile(
          //   title: Text(_data[index].toString()),
          // );
          return ListTile(
            title: Text(_translateddata.toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
        margin: EdgeInsets.all(25),
        child: Column(children: [
          Text(
            'Fetching Weather...',
            style: TextStyle(fontSize: 20),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
        ]));
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  void _saveLat(String input) {
    lat = double.tryParse(input);
    print(lat);
  }

  void _saveLon(String input) {
    lon = double.tryParse(input);
    print(lon);
  }

  Widget _placesLatLob() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.all(5),
          child: TextFormField(
            controller: address,
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              prefixIcon: Icon(Icons.my_location),
              hintText: "Address",
              enabled: _isAddEditable,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onTap: () async {
              try {
                p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    mode: Mode.fullscreen,
                    // Mode.fullscreen
                    language: "mr",
                    components: [new Component(Component.country, "in")]);
                // showDetailPlace(p.placeId);
              } catch (e) {
                return;
              }

              setState(() {
                if (p.description != null) {
                  address.text = p.description;
                  displayPrediction(p);
                } else
                  address.text = "";
              });
//                  _handlePressButton();
            },
          ),
        )),
        Container(
          margin: EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(
              _isAddEditable ? Icons.check : Icons.edit,
            ),
            onPressed: () {
              setState(() {
                _isAddEditable = !_isAddEditable;
              });
            },
          ),
        )
      ],
    );
  }

  displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId);

      // var placeId = p.placeId;
      lat = detail.result.geometry.location.lat;
      lon = detail.result.geometry.location.lng;

      _saveLat(lat.toString());
      _saveLon(lon.toString());
      print(lat);
      print(lon);
    }
  }

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: lat.toString(),
                    labelText: 'Enter Latitude',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: _saveLat,
                  onSubmitted: _saveLat)),
        ),
        Expanded(
            child: Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: lon.toString(),
                      labelText: 'Enter Longitude',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: _saveLon,
                    onSubmitted: _saveLon)))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: FlatButton(
            child: Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryWeather,
            color: Colors.blue,
          ),
        ),
        Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
              child: Text(
                'Fetch forecast',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: queryForecast,
              color: Colors.blue,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Weather Example App'),
          ),
          body: Column(
            children: <Widget>[
              _placesLatLob(),
              // _coordinateInputs(),
              _buttons(),
              Text(
                'Output:',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              Expanded(child: _resultView())
            ],
          )),
    );
  }
}
