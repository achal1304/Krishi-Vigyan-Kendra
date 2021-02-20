import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'forAPMC/repository.dart';
import 'package:translator/translator.dart';

import 'forAPMC/post_model.dart';

const kGoogleApiKey = "AIzaSyDA2vSkZdEb9_8Gz-ivOP1vW8QOu01xEW0";

class DropDownSearchmenuuu extends StatefulWidget {
  @override
  _DropDownSearchmenuuuState createState() => _DropDownSearchmenuuuState();
}

class _DropDownSearchmenuuuState extends State<DropDownSearchmenuuu> {
  final translator = GoogleTranslator();
  var _translateddata;
  String sttt = "";
  String disttt = "";
  String commdtt = "";
  final String postUrl =
      "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd00000133f585e2c6a244007be46a15bdf9ecf0&format=json&offset=0&limit=100";
  String s = "Andhra Pradesh";
  String d = "Chittor";
  List<Post> templist;

  Future<List<Post>> getPosts() async {
    // Map<String, String> queryParams = {"state": "Maharashtra"};
    // String queryString = Uri(queryParameters: queryParams).query;
    sttt = await translateanyString(_selectedState);
    disttt = await translateanyString(_selectedLGA);
    print(sttt + disttt);

    String queryStringState = "filters[state]=" + sttt;
    String queryStringDistrict = "filters[district]=" + disttt;
    String queryStringCommodity = "filters[commodity]=" + commodityy;
    var requestUrl = postUrl +
        '&' +
        queryStringState +
        '&' +
        queryStringDistrict +
        '&' +
        queryStringCommodity;

    List<Post> list;
    Response res = await get(requestUrl);
    print(res.statusCode);
    // print(res.body);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var rest = data["records"] as List;

      // String a = rest.join("###");
      // print("String a is :  " + a);
      // String tra = await translateanyStringtomarathi(a);
      // print("Tra is :  " + tra.toString());
      // var restresult = tra.toString().split('###');
      // print("restresult is :  " + restresult.toString());

      print(rest);
      // List<dynamic> body = jsonDecode(res.body);

      // List<Post> posts =
      //     body.map((dynamic item) => Post.fromJson(item)).toList();

      list = rest.map<Post>((json) => Post.fromJson(json)).toList();

      // String a = list.join("###");
      // print("String a is :  " + a);
      // String tra = await translateanyStringtomarathi(a);
      // print("Tra is :  " + tra.toString());
      // var restresult = tra.toString().split('###');
      // print("restresult is :  " + restresult.toString());

      templist = list;
      return list;
    } else {
      throw "Can't get posts";
    }
  }

  Repository repo = Repository();

  List<String> _states = ["Choose a state"];
  List<String> _districts = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose ..";
  String commo = "";
  String commodityy = "";

  Future<String> translateanyString(String _datatobetranslated) async {
    _translateddata =
        await translator.translate(_datatobetranslated, from: 'mr', to: 'en');
    return _translateddata.toString();
  }

  Future<String> translateanyStringtomarathi(String _datatobetranslated) async {
    _translateddata =
        await translator.translate(_datatobetranslated, from: 'en', to: 'mr');
    return _translateddata.toString();
  }

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'उत्पादनांचे बाजार दर',
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                isExpanded: true,
                items: _states.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (value) => _onSelectedState(value),
                value: _selectedState,
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: _districts.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                // onChanged: (value) => print(value),
                onChanged: (value) => _onSelectedLGA(value),
                value: _selectedLGA,
              ),
              DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 300,
                // items: [
                //   'Tomato',
                //   'Black%20Gram%20(Urd%20Beans)(Whole)',
                //   'Lemon',
                //   'Jowar(Sorghum)',
                //   'Bengal%20Gram(Gram)(Whole)',
                //   'Paddy(Dhan)(Common)',
                //   'Maize',
                //   'Apple',
                //   'Banana%20-%20Green',
                //   'Bhindi(Ladies%20Finger)',
                //   'Bitter%20Gourd',
                //   'Bottle%20Gourd',
                //   'Brinjal',
                //   'Cabbage',
                //   'Capsicum',
                //   'Carrot',
                //   'Cauliflower',
                //   'Chikoos(Sapota)',
                //   'Coriander(Leaves)',
                //   'Cucumbar(Kheera)',
                //   'Garlic',
                //   'Ginger(Green)',
                //   'Grapes',
                //   'Green%20Chilli',
                //   'Guar',
                //   'Karbuja(Musk%20Melon)',
                //   'Knool%20Khol',
                //   'Little%20Gourd%20(Kundru)',
                //   'Methi(Leaves)',
                //   'Mousambi(Sweet%20Lime)',
                //   'Onion',
                //   'Orange',
                //   'Papaya%20(Raw)',
                //   'Peas%20Wet',
                //   'Pomegranate',
                //   'Potato',
                //   'Pumpkin',
                //   'Raddish',
                //   'Sweet%20Potato',
                //   'Tinda',
                //   'Water%20Melon',
                //   'Soyabean',
                //   'Cotton',
                //   'Cummin%20Seed(Jeera)',
                //   'Groundnut',
                //   'Sesamum(Sesame',
                //   'Gingelly',
                //   'Til)',
                //   'Wheat',
                //   'Arhar%20(Tur/Red%20Gram)(Whole)',
                //   'Bajra(Pearl%20Millet/Cumbu)',
                //   'Green%20Gram%20(Moong)(Whole)',
                //   'Kabuli%20Chana(Chickpeas-White)',
                //   'Methi%20Seeds',
                //   'Mustard',
                //   'Castor%20Seed',
                //   'Guar%20Seed(Cluster%20Beans%20Seed)',
                //   'Isabgul%20(Psyllium)',
                //   'Onion%20Green',
                //   'Corriander%20Seed',
                //   'Dry%20Chillies',
                //   'Ground%20Nut%20Seed',
                //   'Cluster%20Beans',
                //   'Beetroot',
                //   'Cowpea(Veg)',
                //   'Drumstick',
                //   'Elephant%20Yam%20(Suran)',
                //   'French%20Beans%20(Frasbean)',
                //   'Indian%20Beans%20(Seam)',
                //   'Pegeon%20Pea%20(Arhar%20Fali)',
                //   'Pointed%20Gourd%20(Parval)',
                //   'Ridge%20Gourd(Tori)',
                //   'Surat%20Beans%20(Papadi)',
                //   'Turmeric%20(Raw)',
                //   'Yam%20(Ratalu)',
                //   'Spinach',
                //   'Banana',
                //   'Ber(Zizyphus/Borehannu)',
                //   'Ginger(Dry)',
                //   'Guava',
                //   'Kinnow',
                //   'Turnip',
                //   'Leafy%20Vegetable',
                //   'Papaya',
                //   'Peas%20Cod',
                //   'Pineapple',
                //   'Mashrooms',
                //   'Colacasia',
                //   'Field%20Pea',
                //   'Dalda',
                //   'Mahua',
                //   'Mustard%20Oil',
                //   'Rice',
                //   'Sugar',
                //   'Wheat%20Atta',
                //   'White%20Peas',
                //   'Beans',
                //   'Chapparad%20Avare',
                //   'Chilly%20Capsicum',
                //   'Green%20Avare%20(w)',
                //   'Seemebadnekai',
                //   'Snake%20Gourd',
                //   'Suvarna%20Gadde',
                //   'Sweet%20Pumpkin',
                //   'Kulthi(Horse%20Gram)',
                //   'Bunch%20Beans',
                //   'Thondekai',
                //   'Tamarind%20Seed',
                //   'Tamarind%20Fruit',
                //   'Tender%20Coconut',
                //   'Foxtail%20Millet(Navane)',
                //   'Green%20Peas',
                //   'Tapioca',
                //   'Amphophalus',
                //   'Ashgourd',
                //   'Amaranthus',
                //   'Mango',
                //   'Black%20Pepper',
                //   'Mango%20(Raw-Ripe)',
                //   'Coconut',
                //   'Rubber',
                //   'Copra',
                //   'Coconut%20Oil',
                //   'Coconut%20Seed',
                //   'Cowpea%20(Lobia/Karamani)',
                //   'Lime',
                //   'Pepper%20Ungarbled',
                //   'Duster%20Beans',
                //   'Coffee',
                //   'Mint(Pudina)',
                //   'Gur(Jaggery)',
                //   'Chrysanthemum(Loose)',
                //   'Marigold(Calcutta)',
                //   'Betal%20Leaves',
                //   'Hen',
                //   'Jack%20Fruit',
                //   'Fish',
                //   'Amla(Nelli%20Kai)',
                //   'Rat%20Tail%20Radish%20(Mogari)',
                //   'Season%20Leaves',
                //   'Squash(Chappal%20Kadoo)',
                //   'Moath%20Dal',
                //   'Taramira',
                //   'Barley%20(Jau)',
                //   'Soanf',
                //   'Cashewnuts',
                //   'T.v.%20Cumbu',
                //   'Turmeric',
                //   'Ragi%20(Finger%20Millet)',
                //   'Paddy(Dhan)(Basmati)',
                //   'Arhar%20Dal(Tur%20Dal)',
                //   'Bengal%20Gram%20Dal%20(Chana%20Dal)',
                //   'Black%20Gram%20Dal%20(Urd%20Dal)',
                //   'Green%20Gram%20Dal%20(Moong%20Dal)',
                //   'Lentil%20(Masur)(Whole)',
                //   'Masur%20Dal',
                //   'Ghee',
                //   'Peas(Dry)',
                //   'Linseed',
                //   'Jute',
                //   'Tomato',
                //   'Tomato',
                //   'Black%20Gram%20(Urd%20Beans)(Whole)',
                //   'Lemon',
                //   'Jowar(Sorghum)',
                //   'Bengal%20Gram(Gram)(Whole)',
                //   'Paddy(Dhan)(Common)',
                //   'Maize',
                //   'Apple',
                //   'Banana%20-%20Green',
                //   'Bhindi(Ladies%20Finger)',
                //   'Bitter%20Gourd',
                //   'Bottle%20Gourd',
                //   'Brinjal',
                //   'Cabbage',
                //   'Capsicum',
                //   'Carrot',
                //   'Cauliflower',
                //   'Chikoos(Sapota)',
                //   'Coriander(Leaves)',
                //   'Cucumbar(Kheera)',
                //   'Garlic',
                //   'Ginger(Green)',
                //   'Grapes',
                //   'Green%20Chilli',
                //   '',
                //   'Karbuja(Musk---Melon)',
                //   '%20Khol',
                //   'Little%20Gourd%20(Kundru)',
                //   'Methi(Leaves)',
                //   'Mousambi(Sweet%20Lime)',
                //   'Onion',
                //   'Orange',
                //   'Papaya%20(Raw)',
                //   'Peas%20Wet',
                //   'Pomegranate',
                //   'Potato',
                //   'Pumpkin',
                //   'Raddish',
                //   'Sweet%20Potato',
                //   'Tinda',
                //   'Water%20Melon',
                //   'Soyabean',
                //   'Cotton',
                //   'Cummin%20Seed(Jeera)',
                //   'Groundnut',
                //   'Sesamum(Sesame',
                //   'Gingelly',
                //   'Til)',
                //   'Wheat',
                //   'Arhar%20(Tur/Red%20Gram)(Whole)',
                //   'Bajra(Pearl%20Millet/Cumbu)',
                //   'Green%20Gram%20(Moong)(Whole)',
                //   'Kabuli%20Chana(Chickpeas-White)',
                //   'Methi%20Seeds',
                //   'Mustard',
                //   'Castor%20Seed',
                //   'Guar%20Seed(Cluster%20Beans%20Seed)',
                //   'Isabgul%20(Psyllium)',
                //   'Onion%20Green',
                //   'Corriander%20Seed',
                //   'Dry%20Chillies',
                //   'Ground%20Nut%20Seed',
                //   'Cluster%20Beans',
                //   'Beetroot',
                //   'Cowpea(Veg)',
                //   'Drumstick',
                //   'Elephant%20Yam%20(Suran)',
                //   'French%20Beans%20(Frasbean)',
                //   'Indian%20Beans%20(Seam)',
                //   'Pegeon%20Pea%20(Arhar%20Fali)',
                //   'Pointed%20Gourd%20(Parval)',
                //   'Ridge%20Gourd(Tori)',
                //   'Surat%20Beans%20(Papadi)',
                //   'Turmeric%20(Raw)',
                //   'Yam%20(Ratalu)',
                //   'Spinach',
                //   'Banana',
                //   'Ber(Zizyphus/Borehannu)',
                //   'Ginger(Dry)',
                //   'Guava',
                //   'Kinnow',
                //   'Turnip',
                //   'Leafy%20Vegetable',
                //   'Papaya',
                //   'Peas%20Cod',
                //   'Pineapple',
                //   'Mashrooms',
                //   'Colacasia',
                //   'Field%20Pea',
                //   'Dalda',
                //   'Mahua',
                //   'Mustard%20Oil',
                //   'Rice',
                //   'Sugar',
                //   'Wheat%20Atta',
                //   'White%20Peas',
                //   'Beans',
                //   'Chapparad%20Avare',
                //   'Chilly%20Capsicum',
                //   'Green%20Avare%20(w)',
                //   'Seemebadnekai',
                //   'Snake%20Gourd',
                //   'Suvarna%20Gadde',
                //   'Sweet%20Pumpkin',
                //   'Kulthi(Horse%20Gram)',
                //   'Bunch%20Beans',
                //   'Thondekai',
                //   'Arecanut(Betelnut/Supari)',
                //   'Tamarind%20Seed',
                //   'Tamarind%20Fruit',
                //   'Tender%20Coconut',
                //   'Foxtail%20Millet(Navane)',
                //   'Green%20Peas',
                //   'Tapioca',
                //   'Amphophalus',
                //   'Ashgourd',
                //   'Amaranthus',
                //   'Mango',
                //   'Black%20Pepper',
                //   'Mango%20(Raw-Ripe)',
                //   'Coconut',
                //   'Rubber',
                //   'Copra',
                //   'Coconut%20Oil',
                //   'Coconut%20Seed',
                //   'Chili%20Red',
                //   'Cowpea%20(Lobia/Karamani)',
                //   'Lime',
                //   'Pepper%20Ungarbled',
                //   'Duster%20Beans',
                //   'Coffee',
                //   'Mint(Pudina)',
                //   'Gur(Jaggery)',
                //   'Chrysanthemum(Loose)',
                //   'Marigold(Calcutta)',
                //   'Betal%20Leaves',
                //   'Hen',
                //   'Jack%20Fruit',
                //   'Fish',
                //   'Amla(Nelli%20Kai)',
                //   'Rat%20Tail%20Radish%20(Mogari)',
                //   'Season%20Leaves',
                //   'Squash(Chappal%20Kadoo)',
                //   'Moath%20Dal',
                //   'Taramira',
                //   'Barley%20(Jau)',
                //   'Soanf',
                //   'Cashewnuts',
                //   'T.v.%20Cumbu',
                //   'Turmeric',
                //   'Ragi%20(Finger%20Millet)',
                //   'Paddy(Dhan)(Basmati)',
                //   'Arhar%20Dal(Tur%20Dal)',
                //   'Bengal%20Gram%20Dal%20(Chana%20Dal)',
                //   'Black%20Gram%20Dal%20(Urd%20Dal)',
                //   'Green%20Gram%20Dal%20(Moong%20Dal)',
                //   'Lentil%20(Masur)(Whole)',
                //   'Masur%20Dal',
                //   'Ghee',
                //   'Peas(Dry)',
                //   'Linseed',
                //   'Jute'
                // ],
                items: [
                  "Tomato",
                  "Black Gram (Urd Beans)(Whole)",
                  "Lemon",
                  "Jowar(Sorghum)",
                  "Bengal Gram(Gram)(Whole)",
                  "Paddy(Dhan)(Common)",
                  "Maize",
                  "Apple",
                  "Banana - Green",
                  "Bhindi(Ladies Finger)",
                  "Bitter Gourd",
                  "Bottle Gourd",
                  "Brinjal",
                  "Cabbage",
                  "Capsicum",
                  "Carrot",
                  "Cauliflower",
                  "Chikoos(Sapota)",
                  "Coriander(Leaves)",
                  "Cucumbar(Kheera)",
                  "Garlic",
                  "Ginger(Green)",
                  "Grapes",
                  "Green Chilli",
                  "Guar",
                  "Karbuja(Musk Melon)",
                  "Knool Khol",
                  "Little Gourd (Kundru)",
                  "Methi(Leaves)",
                  "Mousambi(Sweet Lime)",
                  "Onion",
                  "Orange",
                  "Papaya (Raw)",
                  "Peas Wet",
                  "Pomegranate",
                  "Potato",
                  "Pumpkin",
                  "Raddish",
                  "Sweet Potato",
                  "Tinda",
                  "Water Melon",
                  "Soyabean",
                  "Cotton",
                  "Cummin Seed(Jeera)",
                  "Groundnut",
                  "Sesamum(Sesame",
                  "Gingelly",
                  "Til)",
                  "Wheat",
                  "Arhar (Tur/Red Gram)(Whole)",
                  "Bajra(Pearl Millet/Cumbu)",
                  "Green Gram (Moong)(Whole)",
                  "Kabuli Chana(Chickpeas-White)",
                  "Methi Seeds",
                  "Mustard",
                  "Castor Seed",
                  "Guar Seed(Cluster Beans Seed)",
                  "Isabgul (Psyllium)",
                  "Onion Green",
                  "Corriander Seed",
                  "Dry Chillies",
                  "Ground Nut Seed",
                  "Cluster Beans",
                  "Beetroot",
                  "Cowpea(Veg)",
                  "Drumstick",
                  "Elephant Yam (Suran)",
                  "French Beans (Frasbean)",
                  "Indian Beans (Seam)",
                  "Pegeon Pea (Arhar Fali)",
                  "Pointed Gourd (Parval)",
                  "Ridge Gourd(Tori)",
                  "Surat Beans (Papadi)",
                  "Turmeric (Raw)",
                  "Yam (Ratalu)",
                  "Spinach",
                  "Banana",
                  "Ber(Zizyphus/Borehannu)",
                  "Ginger(Dry)",
                  "Guava",
                  "Kinnow",
                  "Turnip",
                  "Leafy Vegetable",
                  "Papaya",
                  "Peas Cod",
                  "Pineapple",
                  "Mashrooms",
                  "Colacasia",
                  "Field Pea",
                  "Dalda",
                  "Mahua",
                  "Mustard Oil",
                  "Rice",
                  "Sugar",
                  "Wheat Atta",
                  "White Peas",
                  "Beans",
                  "Chapparad Avare",
                  "Chilly Capsicum",
                  "Green Avare (w)",
                  "Seemebadnekai",
                  "Snake Gourd",
                  "Suvarna Gadde",
                  "Sweet Pumpkin",
                  "Kulthi(Horse Gram)",
                  "Bunch Beans",
                  "Thondekai",
                  "Tamarind Seed",
                  "Tamarind Fruit",
                  "Tender Coconut",
                  "Foxtail Millet(Navane)",
                  "Green Peas",
                  "Tapioca",
                  "Amphophalus",
                  "Ashgourd",
                  "Amaranthus",
                  "Mango",
                  "Black Pepper",
                  "Mango (Raw-Ripe)",
                  "Coconut",
                  "Rubber",
                  "Copra",
                  "Coconut Oil",
                  "Coconut Seed",
                  "Cowpea (Lobia/Karamani)",
                  "Lime",
                  "Pepper Ungarbled",
                  "Duster Beans",
                  "Coffee",
                  "Mint(Pudina)",
                  "Gur(Jaggery)",
                  "Chrysanthemum(Loose)",
                  "Marigold(Calcutta)",
                  "Betal Leaves",
                  "Hen",
                  "Jack Fruit",
                  "Fish",
                  "Amla(Nelli Kai)",
                  "Rat Tail Radish (Mogari)",
                  "Season Leaves",
                  "Squash(Chappal Kadoo)",
                  "Moath Dal",
                  "Taramira",
                  "Barley (Jau)",
                  "Soanf",
                  "Cashewnuts",
                  "T.v. Cumbu",
                  "Turmeric",
                  "Ragi (Finger Millet)",
                  "Paddy(Dhan)(Basmati)",
                  "Arhar Dal(Tur Dal)",
                  "Bengal Gram Dal (Chana Dal)",
                  "Black Gram Dal (Urd Dal)",
                  "Green Gram Dal (Moong Dal)",
                  "Lentil (Masur)(Whole)",
                  "Masur Dal",
                  "Ghee",
                  "Peas(Dry)",
                  "Linseed",
                  "Jute",
                  "Tomato",
                  "Tomato",
                  "Black Gram (Urd Beans)(Whole)",
                  "Lemon",
                  "Jowar(Sorghum)",
                  "Bengal Gram(Gram)(Whole)",
                  "Paddy(Dhan)(Common)",
                  "Maize",
                  "Apple",
                  "Banana - Green",
                  "Bhindi(Ladies Finger)",
                  "Bitter Gourd",
                  "Bottle Gourd",
                  "Brinjal",
                  "Cabbage",
                  "Capsicum",
                  "Carrot",
                  "Cauliflower",
                  "Chikoos(Sapota)",
                  "Coriander(Leaves)",
                  "Cucumbar(Kheera)",
                  "Garlic",
                  "Ginger(Green)",
                  "Grapes",
                  "Green Chilli",
                  "",
                  "Karbuja(Musk Melon)",
                  " Khol",
                  "Little Gourd (Kundru)",
                  "Methi(Leaves)",
                  "Mousambi(Sweet Lime)",
                  "Onion",
                  "Orange",
                  "Papaya (Raw)",
                  "Peas Wet",
                  "Pomegranate",
                  "Potato",
                  "Pumpkin",
                  "Raddish",
                  "Sweet Potato",
                  "Tinda",
                  "Water Melon",
                  "Soyabean",
                  "Cotton",
                  "Cummin Seed(Jeera)",
                  "Groundnut",
                  "Sesamum(Sesame",
                  "Gingelly",
                  "Til)",
                  "Wheat",
                  "Arhar (Tur/Red Gram)(Whole)",
                  "Bajra(Pearl Millet/Cumbu)",
                  "Green Gram (Moong)(Whole)",
                  "Kabuli Chana(Chickpeas-White)",
                  "Methi Seeds",
                  "Mustard",
                  "Castor Seed",
                  "Guar Seed(Cluster Beans Seed)",
                  "Isabgul (Psyllium)",
                  "Onion Green",
                  "Corriander Seed",
                  "Dry Chillies",
                  "Ground Nut Seed",
                  "Cluster Beans",
                  "Beetroot",
                  "Cowpea(Veg)",
                  "Drumstick",
                  "Elephant Yam (Suran)",
                  "French Beans (Frasbean)",
                  "Indian Beans (Seam)",
                  "Pegeon Pea (Arhar Fali)",
                  "Pointed Gourd (Parval)",
                  "Ridge Gourd(Tori)",
                  "Surat Beans (Papadi)",
                  "Turmeric (Raw)",
                  "Yam (Ratalu)",
                  "Spinach",
                  "Banana",
                  "Ber(Zizyphus/Borehannu)",
                  "Ginger(Dry)",
                  "Guava",
                  "Kinnow",
                  "Turnip",
                  "Leafy Vegetable",
                  "Papaya",
                  "Peas Cod",
                  "Pineapple",
                  "Mashrooms",
                  "Colacasia",
                  "Field Pea",
                  "Dalda",
                  "Mahua",
                  "Mustard Oil",
                  "Rice",
                  "Sugar",
                  "Wheat Atta",
                  "White Peas",
                  "Beans",
                  "Chapparad Avare",
                  "Chilly Capsicum",
                  "Green Avare (w)",
                  "Seemebadnekai",
                  "Snake Gourd",
                  "Suvarna Gadde",
                  "Sweet Pumpkin",
                  "Kulthi(Horse Gram)",
                  "Bunch Beans",
                  "Thondekai",
                  "Arecanut(Betelnut/Supari)",
                  "Tamarind Seed",
                  "Tamarind Fruit",
                  "Tender Coconut",
                  "Foxtail Millet(Navane)",
                  "Green Peas",
                  "Tapioca",
                  "Amphophalus",
                  "Ashgourd",
                  "Amaranthus",
                  "Mango",
                  "Black Pepper",
                  "Mango (Raw-Ripe)",
                  "Coconut",
                  "Rubber",
                  "Copra",
                  "Coconut Oil",
                  "Coconut Seed",
                  "Chili Red",
                  "Cowpea (Lobia/Karamani)",
                  "Lime",
                  "Pepper Ungarbled",
                  "Duster Beans",
                  "Coffee",
                  "Mint(Pudina)",
                  "Gur(Jaggery)",
                  "Chrysanthemum(Loose)",
                  "Marigold(Calcutta)",
                  "Betal Leaves",
                  "Hen",
                  "Jack Fruit",
                  "Fish",
                  "Amla(Nelli Kai)",
                  "Rat Tail Radish (Mogari)",
                  "Season Leaves",
                  "Squash(Chappal Kadoo)",
                  "Moath Dal",
                  "Taramira",
                  "Barley (Jau)",
                  "Soanf",
                  "Cashewnuts",
                  "T.v. Cumbu",
                  "Turmeric",
                  "Ragi (Finger Millet)",
                  "Paddy(Dhan)(Basmati)",
                  "Arhar Dal(Tur Dal)",
                  "Bengal Gram Dal (Chana Dal)",
                  "Black Gram Dal (Urd Dal)",
                  "Green Gram Dal (Moong Dal)",
                  "Lentil (Masur)(Whole)",
                  "Masur Dal",
                  "Ghee",
                  "Peas(Dry)",
                  "Linseed",
                  "Jute"
                ],
                label: "Commodities",
                onChanged: (result) {
                  setState(() {
                    // translateanyString(result).then((value) {
                    //   commdtt = value;
                    // });
                    commo = result;
                    commodityy = commo.replaceAll(RegExp('\\s'), '%20');
                    print("selected cmmodity" + commodityy);
                  });
                },
                selectedItem: "tomato",
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Search Commodity",
                ),
                popupTitle: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Commodity',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              Divider(),
              // FlatButton(
              //   color: Colors.blue,
              //   textColor: Colors.white,
              //   disabledColor: Colors.grey,
              //   disabledTextColor: Colors.black,
              //   padding: EdgeInsets.all(8.0),
              //   splashColor: Colors.blueAccent,
              //   onPressed: () {
              //     getPosts();
              //   },
              //   child: Text(
              //     "Flat Button",
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              // ),
              Expanded(
                child: FutureBuilder(
                  future: getPosts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.hasData) {
                      List<Post> post = snapshot.data;
                      return ListView(
                        shrinkWrap: true,
                        children: post
                            .map((Post post) => ListTile(
                                  title: Text(post.state),
                                  subtitle: Text(post.district.toString() +
                                      "[ Commodity -" +
                                      post.commodity +
                                      "] = ." +
                                      post.modal_price),
                                  isThreeLine: true,
                                ))
                            .toList(),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose ..";
      _districts = ["Choose .."];
      _selectedState = value;
      _districts = List.from(_districts)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) async {
    // String ttt = await translateanyString(value);

    // setState(() => _selectedLGA = value);
    setState(() {
      // print(value);
      _selectedLGA = value;
    });
  }
}
