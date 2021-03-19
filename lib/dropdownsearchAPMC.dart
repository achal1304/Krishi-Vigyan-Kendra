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
  String s = "";
  String d = "";
  List<Post> templist;
  var marendict = {
    'टोमॅटो': 'Tomato',
    'काळी हरभरा (उडीद बीन्स) (संपूर्ण)': 'Black Gram (Urd Beans)(Whole)',
    'लिंबू': 'Lemon',
    'ज्वार (ज्वारी)': 'Jowar(Sorghum)',
    'बंगाल ग्राम (ग्रॅम) (संपूर्ण)': 'Bengal Gram(Gram)(Whole)',
    'धान (धान) (सामान्य)': 'Paddy(Dhan)(Common)',
    'मका': 'Maize',
    'Appleपल': 'Apple',
    'केळी - हिरवा': 'Banana - Green',
    'भिंडी (लेडीज फिंगर)': 'Bhindi(Ladies Finger)',
    'कारले': 'Bitter Gourd',
    'दुधीभोपळा': 'Bottle Gourd',
    'वांगे': 'Brinjal',
    'कोबी': 'Cabbage',
    'शिमला मिर्ची': 'Capsicum',
    'गाजर': 'Carrot',
    'फुलकोबी': 'Cauliflower',
    'चिकू (सपोटा)': 'Chikoos(Sapota)',
    'कोथिंबीरीची पाने)': 'Coriander(Leaves)',
    'कुकंबर (खीरा)': 'Cucumbar(Kheera)',
    'लसूण': 'Garlic',
    'आले (हिरवा)': 'Ginger(Green)',
    'द्राक्षे': 'Grapes',
    'हिरवी मिरची': 'Green Chilli',
    'ग्वार': 'Guar',
    'कार्बुजा (कस्तुरी खरबूज)': 'Karbuja(Musk Melon)',
    'नूल खोल': 'Knool Khol',
    'छोटा लौकी (कुंडरू)': 'Little Gourd (Kundru)',
    'मेथी (पाने)': 'Methi(Leaves)',
    'मौसंबी (गोड चुना)': 'Mousambi(Sweet Lime)',
    'कांदा': 'Onion',
    'ऑरेंज': 'Orange',
    'पपई (रॉ)': 'Papaya (Raw)',
    'वाटाणे ओले': 'Peas Wet',
    'डाळिंब': 'Pomegranate',
    'बटाटा': 'Potato',
    'भोपळा': 'Pumpkin',
    'रॅडिश': 'Raddish',
    'रताळे': 'Sweet Potato',
    'टिंडा': 'Tinda',
    'वॉटर खरबूज': 'Water Melon',
    'सोयाबीन': 'Soyabean',
    'कापूस': 'Cotton',
    'कमिन बियाणे (जीरा)': 'Cummin Seed(Jeera)',
    'शेंगदाणा': 'Groundnut',
    'तीळ (तीळ)': 'Sesamum(Sesame',
    'जिन्गली': 'Gingelly',
    'तिल)': 'Til)',
    'गहू': 'Wheat',
    'अरहर (तूर / लाल हरभरा) (संपूर्ण)': 'Arhar (Tur/Red Gram)(Whole)',
    'बाजरी (मोत्याची बाजरी / कुंबू)': 'Bajra(Pearl Millet/Cumbu)',
    'ग्रीन ग्राम (मूग) (संपूर्ण)': 'Green Gram (Moong)(Whole)',
    'काबुली चना (चिकन-व्हाइट)': 'Kabuli Chana(Chickpeas-White)',
    'मेथी बियाणे': 'Methi Seeds',
    'मोहरी': 'Mustard',
    'एरंडेल बियाणे': 'Castor Seed',
    'ग्वार बियाणे (क्लस्टर बीन्स बियाणे)': 'Guar Seed(Cluster Beans Seed)',
    'इसाबगुल (सायलियम)': 'Isabgul (Psyllium)',
    'कांदा हिरवा': 'Onion Green',
    'कोरीएंडर बियाणे': 'Corriander Seed',
    'ड्राय मिरची': 'Dry Chillies',
    'ग्राउंड नट बियाणे': 'Ground Nut Seed',
    'क्लस्टर बीन्स': 'Cluster Beans',
    'बीटरूट': 'Beetroot',
    'काउपीया (वेज)': 'Cowpea(Veg)',
    'शेवगा': 'Drumstick',
    'हत्ती याम (सुरण)': 'Elephant Yam (Suran)',
    'फ्रेंच बीन्स (फ्रासीबियन)': 'French Beans (Frasbean)',
    'इंडियन बीन्स (सीम)': 'Indian Beans (Seam)',
    'पेगॉन पे (अरहर फली)': 'Pegeon Pea (Arhar Fali)',
    'पेन्टेड लौकी (परवल)': 'Pointed Gourd (Parval)',
    'रिज लौकी (तोरी)': 'Ridge Gourd(Tori)',
    'सूरत बीन्स (पापडी)': 'Surat Beans (Papadi)',
    'हळद (रॉ)': 'Turmeric (Raw)',
    'याम (रतालू)': 'Yam (Ratalu)',
    'पालक': 'Spinach',
    'केळी': 'Banana',
    'बेर (झिजिफस / बोरहेन्नू)': 'Ber(Zizyphus/Borehannu)',
    'आले (कोरडे)': 'Ginger(Dry)',
    'पेरू': 'Guava',
    'किन्नू': 'Kinnow',
    'शलजम': 'Turnip',
    'पालेभाज्या': 'Leafy Vegetable',
    'पपई': 'Papaya',
    'मटर कॉड': 'Peas Cod',
    'अननस': 'Pineapple',
    'मशरूम': 'Mashrooms',
    'कोलाकासिया': 'Colacasia',
    'फील्ड वाटाणा': 'Field Pea',
    'डालडा': 'Dalda',
    'महुआ': 'Mahua',
    'मोहरीचे तेल': 'Mustard Oil',
    'तांदूळ': 'Rice',
    'साखर': 'Sugar',
    'गहू अट्टा': 'Wheat Atta',
    'पांढरा वाटाणे': 'White Peas',
    'बीन्स': 'Beans',
    'छप्परद अवारे': 'Chapparad Avare',
    'मिरची कॅप्सिकम': 'Chilly Capsicum',
    'ग्रीन अवारे (डब्ल्यू)': 'Green Avare (w)',
    'सीमबदनेकाई': 'Seemebadnekai',
    'साप लौकी': 'Snake Gourd',
    'सुवर्णा गडदे': 'Suvarna Gadde',
    'गोड भोपळा': 'Sweet Pumpkin',
    'कुलथी (घोडा हरभरा)': 'Kulthi(Horse Gram)',
    'गुच्छ बीन्स': 'Bunch Beans',
    'थोंडेकाई': 'Thondekai',
    'चिंचेची बियाणे': 'Tamarind Seed',
    'चिंचेचे फळ': 'Tamarind Fruit',
    'निविदा नारळ': 'Tender Coconut',
    'फॉक्सटेल बाजरी (नावणे)': 'Foxtail Millet(Navane)',
    'मटार': 'Green Peas',
    'तापिओका': 'Tapioca',
    'अँफोफॅलस': 'Amphophalus',
    'Gशगॉर्ड': 'Ashgourd',
    'अमरानथुस': 'Amaranthus',
    'आंबा': 'Mango',
    'काळी मिरी': 'Black Pepper',
    'आंबा (कच्चा-पिकलेला)': 'Mango (Raw-Ripe)',
    'नारळ': 'Coconut',
    'रबर': 'Rubber',
    'कोपरा': 'Copra',
    'खोबरेल तेल': 'Coconut Oil',
    'नारळ बीज': 'Coconut Seed',
    'काउपीया (लोबिया / करमणि)': 'Cowpea (Lobia/Karamani)',
    'चुना': 'Lime',
    'पेपर अँगर्बल्ड': 'Pepper Ungarbled',
    'डस्टर बीन्स': 'Duster Beans',
    'कॉफी': 'Coffee',
    'पुदीना (पुदिना)': 'Mint(Pudina)',
    'गुर (गूळ)': 'Gur(Jaggery)',
    'क्रायसॅन्थेमम (लूज)': 'Chrysanthemum(Loose)',
    'मेरीगोल्ड (कलकत्ता)': 'Marigold(Calcutta)',
    'बेटल पाने': 'Betal Leaves',
    'कोंबडी': 'Hen',
    'फणस': 'Jack Fruit',
    'फिश': 'Fish',
    'आमला (नेल्ली कै)': 'Amla(Nelli Kai)',
    'रॅट टेल मूली (मोगरी)': 'Rat Tail Radish (Mogari)',
    'हंगामातील पाने': 'Season Leaves',
    'स्क्वॉश (चप्पल कडू)': 'Squash(Chappal Kadoo)',
    'मॉथ डाळ': 'Moath Dal',
    'तारामिरा': 'Taramira',
    'बार्ली (जौ)': 'Barley (Jau)',
    'Soanf': 'Soanf',
    'काजू': 'Cashewnuts',
    'टी.व्ही. कुंबू': 'T.v. Cumbu',
    'हळद': 'Turmeric',
    'रागी (फिंगर बाजरी)': 'Ragi (Finger Millet)',
    'धान (धान) (बासमती)': 'Paddy(Dhan)(Basmati)',
    'अरहर दाल (तूर दल)': 'Arhar Dal(Tur Dal)',
    'बंगाल ग्राम दल (चना दल)': 'Bengal Gram Dal (Chana Dal)',
    'ब्लॅक ग्राम डाळ (उडीद डाळ)': 'Black Gram Dal (Urd Dal)',
    'ग्रीन ग्राम डाळ (मूग डाळ)': 'Green Gram Dal (Moong Dal)',
    'मसूर (मसूर) (संपूर्ण)': 'Lentil (Masur)(Whole)',
    'मसूर दाल': 'Masur Dal',
    'घी': 'Ghee',
    'वाटाणे (ड्राय)': 'Peas(Dry)',
    'अलसी': 'Linseed',
    'जूट': 'Jute',
    '': '',
    'खोल': ' Khol',
    'अरेकेनॉट (सुपारी / सुपारी)': 'Arecanut(Betelnut/Supari)',
    'मिरची लाल': 'Chili Red'
  };

  Future<List<Post>> getPosts() async {
    // Map<String, String> queryParams = {"state": "Maharashtra"};
    // String queryString = Uri(queryParameters: queryParams).query;
    sttt = await translateanyString(_selectedState);
    disttt = await translateanyString(_selectedLGA);
    commdtt = marendict[commodityy];
    var requestUrl = postUrl;

    print(sttt + disttt + commdtt);

    String queryStringState = "filters[state]=" + sttt;
    String queryStringDistrict = "filters[district]=" + disttt;
    String queryStringCommodity = "filters[commodity]=" + commdtt;
    if (sttt != "Choose a state") {
      requestUrl = requestUrl + '&' + queryStringState;
    } else
      requestUrl = requestUrl + '&filters[state]=Karnataka';
    if (disttt != "Choose ..") {
      requestUrl = requestUrl + '&' + queryStringDistrict;
    } else
      requestUrl = requestUrl;

    if (commdtt != "") {
      requestUrl = requestUrl + '&' + queryStringCommodity;
    } else
      requestUrl = requestUrl;

    // var requestUrl = postUrl +
    //     '&' +
    //     queryStringState +
    //     '&' +
    //     queryStringDistrict +
    //     '&' +
    //     queryStringCommodity;

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
      // print(list);
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
                items: [
                  "टोमॅटो",
                  "काळी हरभरा (उडीद बीन्स) (संपूर्ण)",
                  "लिंबू",
                  "ज्वार (ज्वारी)",
                  "बंगाल ग्राम (ग्रॅम) (संपूर्ण)",
                  "धान (धान) (सामान्य)",
                  "मका",
                  "Appleपल",
                  "केळी - हिरवा",
                  "भिंडी (लेडीज फिंगर)",
                  "कारले",
                  "दुधीभोपळा",
                  "वांगे",
                  "कोबी",
                  "शिमला मिर्ची",
                  "गाजर",
                  "फुलकोबी",
                  "चिकू (सपोटा)",
                  "कोथिंबीरीची पाने)",
                  "कुकंबर (खीरा)",
                  "लसूण",
                  "आले (हिरवा)",
                  "द्राक्षे",
                  "हिरवी मिरची",
                  "ग्वार",
                  "कार्बुजा (कस्तुरी खरबूज)",
                  "नूल खोल",
                  "छोटा लौकी (कुंडरू)",
                  "मेथी (पाने)",
                  "मौसंबी (गोड चुना)",
                  "कांदा",
                  "ऑरेंज",
                  "पपई (रॉ)",
                  "वाटाणे ओले",
                  "डाळिंब",
                  "बटाटा",
                  "भोपळा",
                  "रॅडिश",
                  "रताळे",
                  "टिंडा",
                  "वॉटर खरबूज",
                  "सोयाबीन",
                  "कापूस",
                  "कमिन बियाणे (जीरा)",
                  "शेंगदाणा",
                  "तीळ (तीळ)",
                  "जिन्गली",
                  "तिल)",
                  "गहू",
                  "अरहर (तूर / लाल हरभरा) (संपूर्ण)",
                  "बाजरी (मोत्याची बाजरी / कुंबू)",
                  "ग्रीन ग्राम (मूग) (संपूर्ण)",
                  "काबुली चना (चिकन-व्हाइट)",
                  "मेथी बियाणे",
                  "मोहरी",
                  "एरंडेल बियाणे",
                  "ग्वार बियाणे (क्लस्टर बीन्स बियाणे)",
                  "इसाबगुल (सायलियम)",
                  "कांदा हिरवा",
                  "कोरीएंडर बियाणे",
                  "ड्राय मिरची",
                  "ग्राउंड नट बियाणे",
                  "क्लस्टर बीन्स",
                  "बीटरूट",
                  "काउपीया (वेज)",
                  "शेवगा",
                  "हत्ती याम (सुरण)",
                  "फ्रेंच बीन्स (फ्रासीबियन)",
                  "इंडियन बीन्स (सीम)",
                  "पेगॉन पे (अरहर फली)",
                  "पेन्टेड लौकी (परवल)",
                  "रिज लौकी (तोरी)",
                  "सूरत बीन्स (पापडी)",
                  "हळद (रॉ)",
                  "याम (रतालू)",
                  "पालक",
                  "केळी",
                  "बेर (झिजिफस / बोरहेन्नू)",
                  "आले (कोरडे)",
                  "पेरू",
                  "किन्नू",
                  "शलजम",
                  "पालेभाज्या",
                  "पपई",
                  "मटर कॉड",
                  "अननस",
                  "मशरूम",
                  "कोलाकासिया",
                  "फील्ड वाटाणा",
                  "डालडा",
                  "महुआ",
                  "मोहरीचे तेल",
                  "तांदूळ",
                  "साखर",
                  "गहू अट्टा",
                  "पांढरा वाटाणे",
                  "बीन्स",
                  "छप्परद अवारे",
                  "मिरची कॅप्सिकम",
                  "ग्रीन अवारे (डब्ल्यू)",
                  "सीमबदनेकाई",
                  "साप लौकी",
                  "सुवर्णा गडदे",
                  "गोड भोपळा",
                  "कुलथी (घोडा हरभरा)",
                  "गुच्छ बीन्स",
                  "थोंडेकाई",
                  "चिंचेची बियाणे",
                  "चिंचेचे फळ",
                  "निविदा नारळ",
                  "फॉक्सटेल बाजरी (नावणे)",
                  "मटार",
                  "तापिओका",
                  "अँफोफॅलस",
                  "Gशगॉर्ड",
                  "अमरानथुस",
                  "आंबा",
                  "काळी मिरी",
                  "आंबा (कच्चा-पिकलेला)",
                  "नारळ",
                  "रबर",
                  "कोपरा",
                  "खोबरेल तेल",
                  "नारळ बीज",
                  "काउपीया (लोबिया / करमणि)",
                  "चुना",
                  "पेपर अँगर्बल्ड",
                  "डस्टर बीन्स",
                  "कॉफी",
                  "पुदीना (पुदिना)",
                  "गुर (गूळ)",
                  "क्रायसॅन्थेमम (लूज)",
                  "मेरीगोल्ड (कलकत्ता)",
                  "बेटल पाने",
                  "कोंबडी",
                  "फणस",
                  "फिश",
                  "आमला (नेल्ली कै)",
                  "रॅट टेल मूली (मोगरी)",
                  "हंगामातील पाने",
                  "स्क्वॉश (चप्पल कडू)",
                  "मॉथ डाळ",
                  "तारामिरा",
                  "बार्ली (जौ)",
                  "Soanf",
                  "काजू",
                  "टी.व्ही. कुंबू",
                  "हळद",
                  "रागी (फिंगर बाजरी)",
                  "धान (धान) (बासमती)",
                  "अरहर दाल (तूर दल)",
                  "बंगाल ग्राम दल (चना दल)",
                  "ब्लॅक ग्राम डाळ (उडीद डाळ)",
                  "ग्रीन ग्राम डाळ (मूग डाळ)",
                  "मसूर (मसूर) (संपूर्ण)",
                  "मसूर दाल",
                  "घी",
                  "वाटाणे (ड्राय)",
                  "अलसी",
                  "जूट",
                  "टोमॅटो",
                  "टोमॅटो",
                  "काळी हरभरा (उडीद बीन्स) (संपूर्ण)",
                  "लिंबू",
                  "ज्वार (ज्वारी)",
                  "बंगाल ग्राम (ग्रॅम) (संपूर्ण)",
                  "धान (धान) (सामान्य)",
                  "मका",
                  "Appleपल",
                  "केळी - हिरवा",
                  "भिंडी (लेडीज फिंगर)",
                  "कारले",
                  "दुधीभोपळा",
                  "वांगे",
                  "कोबी",
                  "शिमला मिर्ची",
                  "गाजर",
                  "फुलकोबी",
                  "चिकू (सपोटा)",
                  "कोथिंबीरीची पाने)",
                  "कुकंबर (खीरा)",
                  "लसूण",
                  "आले (हिरवा)",
                  "द्राक्षे",
                  "हिरवी मिरची",
                  "",
                  "कार्बुजा (कस्तुरी खरबूज)",
                  "खोल",
                  "छोटा लौकी (कुंडरू)",
                  "मेथी (पाने)",
                  "मौसंबी (गोड चुना)",
                  "कांदा",
                  "ऑरेंज",
                  "पपई (रॉ)",
                  "वाटाणे ओले",
                  "डाळिंब",
                  "बटाटा",
                  "भोपळा",
                  "रॅडिश",
                  "रताळे",
                  "टिंडा",
                  "वॉटर खरबूज",
                  "सोयाबीन",
                  "कापूस",
                  "कमिन बियाणे (जीरा)",
                  "शेंगदाणा",
                  "तीळ (तीळ)",
                  "जिन्गली",
                  "तिल)",
                  "गहू",
                  "अरहर (तूर / लाल हरभरा) (संपूर्ण)",
                  "बाजरी (मोत्याची बाजरी / कुंबू)",
                  "ग्रीन ग्राम (मूग) (संपूर्ण)",
                  "काबुली चना (चिकन-व्हाइट)",
                  "मेथी बियाणे",
                  "मोहरी",
                  "एरंडेल बियाणे",
                  "ग्वार बियाणे (क्लस्टर बीन्स बियाणे)",
                  "इसाबगुल (सायलियम)",
                  "कांदा हिरवा",
                  "कोरीएंडर बियाणे",
                  "ड्राय मिरची",
                  "ग्राउंड नट बियाणे",
                  "क्लस्टर बीन्स",
                  "बीटरूट",
                  "काउपीया (वेज)",
                  "शेवगा",
                  "हत्ती याम (सुरण)",
                  "फ्रेंच बीन्स (फ्रासीबियन)",
                  "इंडियन बीन्स (सीम)",
                  "पेगॉन पे (अरहर फली)",
                  "पेन्टेड लौकी (परवल)",
                  "रिज लौकी (तोरी)",
                  "सूरत बीन्स (पापडी)",
                  "हळद (रॉ)",
                  "याम (रतालू)",
                  "पालक",
                  "केळी",
                  "बेर (झिजिफस / बोरहेन्नू)",
                  "आले (कोरडे)",
                  "पेरू",
                  "किन्नू",
                  "शलजम",
                  "पालेभाज्या",
                  "पपई",
                  "मटर कॉड",
                  "अननस",
                  "मशरूम",
                  "कोलाकासिया",
                  "फील्ड वाटाणा",
                  "डालडा",
                  "महुआ",
                  "मोहरीचे तेल",
                  "तांदूळ",
                  "साखर",
                  "गहू अट्टा",
                  "पांढरा वाटाणे",
                  "बीन्स",
                  "छप्परद अवारे",
                  "मिरची कॅप्सिकम",
                  "ग्रीन अवारे (डब्ल्यू)",
                  "सीमबदनेकाई",
                  "साप लौकी",
                  "सुवर्णा गडदे",
                  "गोड भोपळा",
                  "कुलथी (घोडा हरभरा)",
                  "गुच्छ बीन्स",
                  "थोंडेकाई",
                  "अरेकेनॉट (सुपारी / सुपारी)",
                  "चिंचेची बियाणे",
                  "चिंचेचे फळ",
                  "निविदा नारळ",
                  "फॉक्सटेल बाजरी (नावणे)",
                  "मटार",
                  "तापिओका",
                  "अँफोफॅलस",
                  "Gशगॉर्ड",
                  "अमरानथुस",
                  "आंबा",
                  "काळी मिरी",
                  "आंबा (कच्चा-पिकलेला)",
                  "नारळ",
                  "रबर",
                  "कोपरा",
                  "खोबरेल तेल",
                  "नारळ बीज",
                  "मिरची लाल",
                  "काउपीया (लोबिया / करमणि)",
                  "चुना",
                  "पेपर अँगर्बल्ड",
                  "डस्टर बीन्स",
                  "कॉफी",
                  "पुदीना (पुदिना)",
                  "गुर (गूळ)",
                  "क्रायसॅन्थेमम (लूज)",
                  "मेरीगोल्ड (कलकत्ता)",
                  "बेटल पाने",
                  "कोंबडी",
                  "फणस",
                  "फिश",
                  "आमला (नेल्ली कै)",
                  "रॅट टेल मूली (मोगरी)",
                  "हंगामातील पाने",
                  "स्क्वॉश (चप्पल कडू)",
                  "मॉथ डाळ",
                  "तारामिरा",
                  "बार्ली (जौ)",
                  "Soanf",
                  "काजू",
                  "टी.व्ही. कुंबू",
                  "हळद",
                  "रागी (फिंगर बाजरी)",
                  "धान (धान) (बासमती)",
                  "अरहर दाल (तूर दल)",
                  "बंगाल ग्राम दल (चना दल)",
                  "ब्लॅक ग्राम डाळ (उडीद डाळ)",
                  "ग्रीन ग्राम डाळ (मूग डाळ)",
                  "मसूर (मसूर) (संपूर्ण)",
                  "मसूर दाल",
                  "घी",
                  "वाटाणे (ड्राय)",
                  "अलसी",
                  "जूट"
                ],
                // items: [
                //   "Tomato",
                //   "Black Gram (Urd Beans)(Whole)",
                //   "Lemon",
                //   "Jowar(Sorghum)",
                //   "Bengal Gram(Gram)(Whole)",
                //   "Paddy(Dhan)(Common)",
                //   "Maize",
                //   "Apple",
                //   "Banana - Green",
                //   "Bhindi(Ladies Finger)",
                //   "Bitter Gourd",
                //   "Bottle Gourd",
                //   "Brinjal",
                //   "Cabbage",
                //   "Capsicum",
                //   "Carrot",
                //   "Cauliflower",
                //   "Chikoos(Sapota)",
                //   "Coriander(Leaves)",
                //   "Cucumbar(Kheera)",
                //   "Garlic",
                //   "Ginger(Green)",
                //   "Grapes",
                //   "Green Chilli",
                //   "Guar",
                //   "Karbuja(Musk Melon)",
                //   "Knool Khol",
                //   "Little Gourd (Kundru)",
                //   "Methi(Leaves)",
                //   "Mousambi(Sweet Lime)",
                //   "Onion",
                //   "Orange",
                //   "Papaya (Raw)",
                //   "Peas Wet",
                //   "Pomegranate",
                //   "Potato",
                //   "Pumpkin",
                //   "Raddish",
                //   "Sweet Potato",
                //   "Tinda",
                //   "Water Melon",
                //   "Soyabean",
                //   "Cotton",
                //   "Cummin Seed(Jeera)",
                //   "Groundnut",
                //   "Sesamum(Sesame",
                //   "Gingelly",
                //   "Til)",
                //   "Wheat",
                //   "Arhar (Tur/Red Gram)(Whole)",
                //   "Bajra(Pearl Millet/Cumbu)",
                //   "Green Gram (Moong)(Whole)",
                //   "Kabuli Chana(Chickpeas-White)",
                //   "Methi Seeds",
                //   "Mustard",
                //   "Castor Seed",
                //   "Guar Seed(Cluster Beans Seed)",
                //   "Isabgul (Psyllium)",
                //   "Onion Green",
                //   "Corriander Seed",
                //   "Dry Chillies",
                //   "Ground Nut Seed",
                //   "Cluster Beans",
                //   "Beetroot",
                //   "Cowpea(Veg)",
                //   "Drumstick",
                //   "Elephant Yam (Suran)",
                //   "French Beans (Frasbean)",
                //   "Indian Beans (Seam)",
                //   "Pegeon Pea (Arhar Fali)",
                //   "Pointed Gourd (Parval)",
                //   "Ridge Gourd(Tori)",
                //   "Surat Beans (Papadi)",
                //   "Turmeric (Raw)",
                //   "Yam (Ratalu)",
                //   "Spinach",
                //   "Banana",
                //   "Ber(Zizyphus/Borehannu)",
                //   "Ginger(Dry)",
                //   "Guava",
                //   "Kinnow",
                //   "Turnip",
                //   "Leafy Vegetable",
                //   "Papaya",
                //   "Peas Cod",
                //   "Pineapple",
                //   "Mashrooms",
                //   "Colacasia",
                //   "Field Pea",
                //   "Dalda",
                //   "Mahua",
                //   "Mustard Oil",
                //   "Rice",
                //   "Sugar",
                //   "Wheat Atta",
                //   "White Peas",
                //   "Beans",
                //   "Chapparad Avare",
                //   "Chilly Capsicum",
                //   "Green Avare (w)",
                //   "Seemebadnekai",
                //   "Snake Gourd",
                //   "Suvarna Gadde",
                //   "Sweet Pumpkin",
                //   "Kulthi(Horse Gram)",
                //   "Bunch Beans",
                //   "Thondekai",
                //   "Tamarind Seed",
                //   "Tamarind Fruit",
                //   "Tender Coconut",
                //   "Foxtail Millet(Navane)",
                //   "Green Peas",
                //   "Tapioca",
                //   "Amphophalus",
                //   "Ashgourd",
                //   "Amaranthus",
                //   "Mango",
                //   "Black Pepper",
                //   "Mango (Raw-Ripe)",
                //   "Coconut",
                //   "Rubber",
                //   "Copra",
                //   "Coconut Oil",
                //   "Coconut Seed",
                //   "Cowpea (Lobia/Karamani)",
                //   "Lime",
                //   "Pepper Ungarbled",
                //   "Duster Beans",
                //   "Coffee",
                //   "Mint(Pudina)",
                //   "Gur(Jaggery)",
                //   "Chrysanthemum(Loose)",
                //   "Marigold(Calcutta)",
                //   "Betal Leaves",
                //   "Hen",
                //   "Jack Fruit",
                //   "Fish",
                //   "Amla(Nelli Kai)",
                //   "Rat Tail Radish (Mogari)",
                //   "Season Leaves",
                //   "Squash(Chappal Kadoo)",
                //   "Moath Dal",
                //   "Taramira",
                //   "Barley (Jau)",
                //   "Soanf",
                //   "Cashewnuts",
                //   "T.v. Cumbu",
                //   "Turmeric",
                //   "Ragi (Finger Millet)",
                //   "Paddy(Dhan)(Basmati)",
                //   "Arhar Dal(Tur Dal)",
                //   "Bengal Gram Dal (Chana Dal)",
                //   "Black Gram Dal (Urd Dal)",
                //   "Green Gram Dal (Moong Dal)",
                //   "Lentil (Masur)(Whole)",
                //   "Masur Dal",
                //   "Ghee",
                //   "Peas(Dry)",
                //   "Linseed",
                //   "Jute",
                //   "Tomato",
                //   "Tomato",
                //   "Black Gram (Urd Beans)(Whole)",
                //   "Lemon",
                //   "Jowar(Sorghum)",
                //   "Bengal Gram(Gram)(Whole)",
                //   "Paddy(Dhan)(Common)",
                //   "Maize",
                //   "Apple",
                //   "Banana - Green",
                //   "Bhindi(Ladies Finger)",
                //   "Bitter Gourd",
                //   "Bottle Gourd",
                //   "Brinjal",
                //   "Cabbage",
                //   "Capsicum",
                //   "Carrot",
                //   "Cauliflower",
                //   "Chikoos(Sapota)",
                //   "Coriander(Leaves)",
                //   "Cucumbar(Kheera)",
                //   "Garlic",
                //   "Ginger(Green)",
                //   "Grapes",
                //   "Green Chilli",
                //   "",
                //   "Karbuja(Musk Melon)",
                //   " Khol",
                //   "Little Gourd (Kundru)",
                //   "Methi(Leaves)",
                //   "Mousambi(Sweet Lime)",
                //   "Onion",
                //   "Orange",
                //   "Papaya (Raw)",
                //   "Peas Wet",
                //   "Pomegranate",
                //   "Potato",
                //   "Pumpkin",
                //   "Raddish",
                //   "Sweet Potato",
                //   "Tinda",
                //   "Water Melon",
                //   "Soyabean",
                //   "Cotton",
                //   "Cummin Seed(Jeera)",
                //   "Groundnut",
                //   "Sesamum(Sesame",
                //   "Gingelly",
                //   "Til)",
                //   "Wheat",
                //   "Arhar (Tur/Red Gram)(Whole)",
                //   "Bajra(Pearl Millet/Cumbu)",
                //   "Green Gram (Moong)(Whole)",
                //   "Kabuli Chana(Chickpeas-White)",
                //   "Methi Seeds",
                //   "Mustard",
                //   "Castor Seed",
                //   "Guar Seed(Cluster Beans Seed)",
                //   "Isabgul (Psyllium)",
                //   "Onion Green",
                //   "Corriander Seed",
                //   "Dry Chillies",
                //   "Ground Nut Seed",
                //   "Cluster Beans",
                //   "Beetroot",
                //   "Cowpea(Veg)",
                //   "Drumstick",
                //   "Elephant Yam (Suran)",
                //   "French Beans (Frasbean)",
                //   "Indian Beans (Seam)",
                //   "Pegeon Pea (Arhar Fali)",
                //   "Pointed Gourd (Parval)",
                //   "Ridge Gourd(Tori)",
                //   "Surat Beans (Papadi)",
                //   "Turmeric (Raw)",
                //   "Yam (Ratalu)",
                //   "Spinach",
                //   "Banana",
                //   "Ber(Zizyphus/Borehannu)",
                //   "Ginger(Dry)",
                //   "Guava",
                //   "Kinnow",
                //   "Turnip",
                //   "Leafy Vegetable",
                //   "Papaya",
                //   "Peas Cod",
                //   "Pineapple",
                //   "Mashrooms",
                //   "Colacasia",
                //   "Field Pea",
                //   "Dalda",
                //   "Mahua",
                //   "Mustard Oil",
                //   "Rice",
                //   "Sugar",
                //   "Wheat Atta",
                //   "White Peas",
                //   "Beans",
                //   "Chapparad Avare",
                //   "Chilly Capsicum",
                //   "Green Avare (w)",
                //   "Seemebadnekai",
                //   "Snake Gourd",
                //   "Suvarna Gadde",
                //   "Sweet Pumpkin",
                //   "Kulthi(Horse Gram)",
                //   "Bunch Beans",
                //   "Thondekai",
                //   "Arecanut(Betelnut/Supari)",
                //   "Tamarind Seed",
                //   "Tamarind Fruit",
                //   "Tender Coconut",
                //   "Foxtail Millet(Navane)",
                //   "Green Peas",
                //   "Tapioca",
                //   "Amphophalus",
                //   "Ashgourd",
                //   "Amaranthus",
                //   "Mango",
                //   "Black Pepper",
                //   "Mango (Raw-Ripe)",
                //   "Coconut",
                //   "Rubber",
                //   "Copra",
                //   "Coconut Oil",
                //   "Coconut Seed",
                //   "Chili Red",
                //   "Cowpea (Lobia/Karamani)",
                //   "Lime",
                //   "Pepper Ungarbled",
                //   "Duster Beans",
                //   "Coffee",
                //   "Mint(Pudina)",
                //   "Gur(Jaggery)",
                //   "Chrysanthemum(Loose)",
                //   "Marigold(Calcutta)",
                //   "Betal Leaves",
                //   "Hen",
                //   "Jack Fruit",
                //   "Fish",
                //   "Amla(Nelli Kai)",
                //   "Rat Tail Radish (Mogari)",
                //   "Season Leaves",
                //   "Squash(Chappal Kadoo)",
                //   "Moath Dal",
                //   "Taramira",
                //   "Barley (Jau)",
                //   "Soanf",
                //   "Cashewnuts",
                //   "T.v. Cumbu",
                //   "Turmeric",
                //   "Ragi (Finger Millet)",
                //   "Paddy(Dhan)(Basmati)",
                //   "Arhar Dal(Tur Dal)",
                //   "Bengal Gram Dal (Chana Dal)",
                //   "Black Gram Dal (Urd Dal)",
                //   "Green Gram Dal (Moong Dal)",
                //   "Lentil (Masur)(Whole)",
                //   "Masur Dal",
                //   "Ghee",
                //   "Peas(Dry)",
                //   "Linseed",
                //   "Jute"
                // ],
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
                selectedItem: "",
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
                    } else if (snapshot.hasError) {
                      return Text("Error :  ${snapshot.error}");
                    }
                    // if (!snapshot.hasData || snapshot.data.length == 0) {
                    //   return Center(child: Text("No Data Yet..."));
                    // }
                    else
                      return Center(child: CircularProgressIndicator());
                    // else
                    //   return Center(child: Text("No Data Yet..."));
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
