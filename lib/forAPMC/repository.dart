import 'state_model.dart';
// import 'package:states_lga/state_model.dart';

class Repository {
  // http://locationsng-api.herokuapp.com/api/v1/lgas
  // test() => _nigeria.map((map) => StateModel.fromJson(map));
  List<Map> getAll() => _nigeria;

  getLocalByState(String state) => _nigeria
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.districts)
      .expand((i) => i)
      .toList();
  // _nigeria.where((list) => list['state'] == state);
  // .map((item) => item['lgas'])
  // .expand((i) => i)
  // .toList();

  List<String> getStates() => _nigeria
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();
  // _nigeria.map((item) => item['state'].toString()).toList();

  List _nigeria = [
    {
      "state": "आंध्र प्रदेश",
      "districts": [
        "अनंतपूर",
        "चित्तूर",
        "पूर्व गोदावरी",
        "गुंटूर",
        "कृष्णा",
        "कुर्नूल",
        "नेल्लोर",
        "प्रकाशसम",
        "श्रीकाकुलम",
        "विशाखापट्टणम",
        "विजयनगरम",
        "पश्चिम गोदावरी",
        "वायएसआर कडप्पा"
      ]
    },
    {
      "state": "अरुणाचल प्रदेश",
      "districts": [
        "तवांग",
        "वेस्ट कामेंग",
        "पूर्व कामेंग",
        "पापुम पारे",
        "कुरुंग कुमे",
        "क्रा दादी",
        "लोअर सुबानसिरी",
        "अप्पर सुबानसिरी",
        "वेस्ट सियांग",
        "पूर्व सियांग",
        "सियांग",
        "अप्पर सियांग",
        "लोअर सियांग",
        "लोअर दिबांग व्हॅली",
        "दिबांग व्हॅली",
        "अंजाव",
        "लोहित",
        "नमसाई",
        "चांगलंग",
        "तिरप",
        "तीव्र इच्छा"
      ]
    },
    {
      "state": "आसाम",
      "districts": [
        "बक्सा",
        "बारपेटा",
        "विश्वनाथ",
        "बोंगागांव",
        "कॅचर",
        "चरैदेव",
        "चिरंग",
        "दररंग",
        "धेमाजी",
        "धुबरी",
        "डिब्रूगड",
        "गोलपारा",
        "गोलाघाट",
        "हैलाकांडी",
        "होजाई",
        "जोरहाट",
        "कामरूप महानगर",
        "कामरूप",
        "कार्बी एंग्लॉन्ग",
        "करीमगंज",
        "कोकराझार",
        "लखीमपूर",
        "माजुली",
        "मोरीगाव",
        "नागाव",
        "नलबारी",
        "दिमा हसाओ",
        "शिवसागर",
        "सोनीतपूर",
        "दक्षिण साल्मारा-मन्काचार",
        "तिनसुकिया",
        "उदलगुरी",
        "वेस्ट कार्बी आंग्लॉन्ग"
      ]
    },
    {
      "state": "बिहार",
      "districts": [
        "अररिया",
        "अरवल",
        "औरंगाबाद",
        "बँका",
        "बेगूसराय",
        "भागलपूर",
        "भोजपूर",
        "बक्सर",
        "दरभंगा",
        "पूर्व चंपारण (मोतिहारी)",
        "गया",
        "गोपाळगंज",
        "जमुई",
        "जहानाबाद",
        "कैमूर (भभुआ)",
        "कटिहार",
        "खगारिया",
        "किशनगंज",
        "लखीसराय",
        "मधेपुरा",
        "मधुबनी",
        "मुंगेर (मोंगिर)",
        "मुजफ्फरपूर",
        "नालंदा",
        "नवादा",
        "पटना",
        "पूर्णिया (पूर्णिया)",
        "रोहतास",
        "सहरसा",
        "समस्तीपूर",
        "सारण",
        "शेखपुरा",
        "श्योहर",
        "सीतामढी",
        "सीवान",
        "सुपौल",
        "वैशाली",
        "पश्चिम चंपारण"
      ]
    },
    {
      "state": "चंडीगड (यूटी)",
      "districts": ["चंडीगड"]
    },
    {
      "state": "छत्तीसगड",
      "districts": [
        "बालोद",
        "बलोदा बाजार",
        "बलरामपूर",
        "बस्तर",
        "बेमेतारा",
        "विजापूर",
        "बिलासपुर",
        "दंतेवाडा (दक्षिण बस्तर)",
        "धमतरी",
        "दुर्ग",
        "गरियाबंद",
        "जांजगीर-चांपा",
        "जशपूर",
        "कबीरधाम (कवर्धा)",
        "कांकेर (उत्तर बस्तर)",
        "कोंडागाव",
        "कोरबा",
        "कोरिया (कोरिया)",
        "महासमुंद",
        "मुंगेली",
        "नारायणपूर",
        "रायगड",
        "रायपुर",
        "राजनांदगाव",
        "सुकमा",
        "सूरजपूर",
        "सर्गुजा"
      ]
    },
    {
      "state": "दादरा आणि नगर हवेली (यूटी)",
      "districts": ["दादरा आणि नगर हवेली"]
    },
    {
      "state": "दमण आणि दीव (यूटी)",
      "districts": ["दमण", "दीव"]
    },
    {
      "state": "दिल्ली (एनसीटी)",
      "districts": [
        "मध्य दिल्ली",
        "ईस्ट दिल्ली",
        "नवी दिल्ली",
        "उत्तर दिल्ली",
        "ईशान्य दिल्ली",
        "उत्तर पश्चिम दिल्ली",
        "शाहदरा",
        "दक्षिण दिल्ली",
        "दक्षिण पूर्व दिल्ली",
        "दक्षिण पश्चिम दिल्ली",
        "पश्चिम दिल्ली"
      ]
    },
    {
      "state": "गोवा",
      "districts": ["उत्तर गोवा", "दक्षिण गोवा"]
    },
    {
      "state": "गुजरात",
      "districts": [
        "अहमदाबाद",
        "अमरेली",
        "आनंद",
        "अरवल्ली",
        "बनसकांठा (पालनपूर)",
        "भरुच",
        "भावनगर",
        "बोटाड",
        "छोटा उडेपुर",
        "दाहोद",
        "डँग्स (अहवा)",
        "देवभूमी द्वारका",
        "गांधीनगर",
        "गिर सोमनाथ",
        "जामनगर",
        "जुनागड",
        "कच्छ",
        "खेडा (नाडियाद)",
        "महिसागर",
        "मेहसाणा",
        "मोरबी",
        "नर्मदा (राजपिपला)",
        "नवसारी",
        "पंचमहाल (गोधरा)",
        "पाटण",
        "पोरबंदर",
        "राजकोट",
        "साबरकांठा (हिम्मतनगर)",
        "सूरत",
        "सुरेंद्रनगर",
        "तापी (व्यायारा)",
        "वडोदरा",
        "वलसाड"
      ]
    },
    {
      "state": "हरियाणा",
      "districts": [
        "अंबाला",
        "भिवानी",
        "चरखी दादरी",
        "फरीदाबाद",
        "फतेहाबाद",
        "गुडगाव",
        "हिसार",
        "झज्जर",
        "जींद",
        "कैथल",
        "करनाल",
        "कुरुक्षेत्र",
        "महेंद्रगड",
        "मेवात",
        "पलवल",
        "पंचकुला",
        "पानीपत",
        "रेवाडी",
        "रोहतक",
        "सिरसा",
        "सोनीपत",
        "यमुनानगर"
      ]
    },
    {
      "state": "हिमाचल प्रदेश",
      "districts": [
        "बिलासपुर",
        "चंबा",
        "हमीरपूर",
        "कांगड़ा",
        "किन्नौर",
        "कुल्लू",
        "लाहौल & विद्युतप्रवाह मोजण्याच्या एककाचे संक्षिप्त रुप",
        "मंडी",
        "शिमला",
        "सिरमौर (सिरमौर)",
        "सोलन",
        "उना"
      ]
    },
    {
      "state": "जम्मू आणि काश्मीर",
      "districts": [
        "अनंतनाग",
        "बांदीपुर",
        "बारामुल्ला",
        "बडगाम",
        "डोडा",
        "गॅंडरबल",
        "जम्मू",
        "कारगिल",
        "कठुआ",
        "किश्तवार",
        "कुलगाम",
        "कुपवाडा",
        "लेह",
        "पुंछ",
        "पुलवामा",
        "राजौरी",
        "रामबन",
        "रियासी",
        "सांबा",
        "शोपियन",
        "श्रीनगर",
        "उधमपूर"
      ]
    },
    {
      "state": "झारखंड",
      "districts": [
        "बोकारो",
        "चत्रा",
        "देवघर",
        "धनबाद",
        "दुमका",
        "पूर्व सिंहभूम",
        "गढवा",
        "गिरीडीह",
        "गोड्डा",
        "गुमला",
        "हजारीबाग",
        "जामतारा",
        "खूंटी",
        "कोडरमा",
        "लातेहार",
        "लोहरदगा",
        "पाकुर",
        "पलामू",
        "रामगड",
        "रांची",
        "साहिबगंज",
        "सरायकेला-खरसावन",
        "सिमडेगा",
        "पश्चिम सिंहभूम"
      ]
    },
    {
      "state": "कर्नाटक",
      "districts": [
        "बागलकोट",
        "बल्लारी (बेल्लारी)",
        "बेलागावी (बेळगाव)",
        "बेंगलुरू (बेंगलोर) ग्रामीण",
        "बेंगलुरू (बेंगलोर) अर्बन",
        "बिदर",
        "चमराजनगर",
        "चिकबल्लापूर",
        "चिक्कामागलुरु (चिकमगलूर)",
        "चित्रदुर्गा",
        "दक्षिण कन्नड",
        "दावणगेरे",
        "धारवाड",
        "गाडाग",
        "हसन",
        "हवेरी",
        "कलाबुरागी (गुलबर्गा)",
        "कोडगू",
        "कोलार",
        "कोपल",
        "मांड्या",
        "म्हैसूर (म्हैसूर)",
        "रायचूर",
        "रामनगर",
        "शिवमोगा (शिमोगा)",
        "तुमकुरु (तुमकुर)",
        "उडुपी",
        "उत्तरा कन्नड (कारवार)",
        "विजयपुरा (विजापूर)",
        "यादगीर"
      ]
    },
    {
      "state": "केरळ",
      "districts": [
        "आलापूझा",
        "एर्नाकुलम",
        "इदुक्की",
        "कन्नूर",
        "कसारागोड",
        "कोल्लम",
        "कोट्टायम",
        "कोझिकोड",
        "मलप्पुरम",
        "पलक्कड",
        "पठाणमथिट्टा",
        "तिरुवनंतपुरम",
        "थ्रीसुर",
        "वायनाड"
      ]
    },
    {
      "state": "लक्षद्वीप (यूटी)",
      "districts": [
        "अगाटी",
        "अमिनी",
        "आंद्रोथ",
        "बिथ्रा",
        "चेतलाथ",
        "कावराटी",
        "कदममठ",
        "काळपेनी",
        "किल्थन",
        "मिनीकॉय"
      ]
    },
    {
      "state": "मध्य प्रदेश",
      "districts": [
        "अगर मालवा",
        "अलिराजपूर",
        "अनूपपुर",
        "अशोकनगर",
        "बालाघाट",
        "बारवानी",
        "बैतूल",
        "भिंड",
        "भोपाळ",
        "बुरहानपुर",
        "छतरपूर",
        "छिंदवाडा",
        "दमोह",
        "दतिया",
        "देवास",
        "धर",
        "दिंडोरी",
        "गुना",
        "ग्वालियर",
        "हरदा",
        "होशंगाबाद",
        "इंदौर",
        "जबलपूर",
        "झाबुआ",
        "कटनी",
        "खंडवा",
        "खरगोन",
        "मंडला",
        "मंदसौर",
        "मुरैना",
        "नरसिंहपूर",
        "नीमच",
        "पन्ना",
        "रायसेन",
        "राजगड",
        "रतलाम",
        "रीवा",
        "सागर",
        "सतना",
        "सेहोर",
        "सिवनी",
        "शहडोल",
        "शाजापूर",
        "श्योपुर",
        "शिवपुरी",
        "सिधी",
        "सिंगरौली",
        "टीकमगड",
        "उज्जैन",
        "उमरिया",
        "विदिशा"
      ]
    },
    {
      "state": "महाराष्ट्र",
      "districts": [
        "अहमदनगर",
        "अकोला",
        "अमरावती",
        "औरंगाबाद",
        "बीड",
        "भंडारा",
        "बुलढाणा",
        "चंद्रपूर",
        "धुळे",
        "गडचिरोली",
        "गोंदिया",
        "हिंगोली",
        "जळगाव",
        "जालना",
        "कोल्हापूर",
        "लातूर",
        "मुंबई शहर",
        "मुंबई उपनगरीय",
        "नागपूर",
        "नांदेड",
        "नंदुरबार",
        "नाशिक",
        "उस्मानाबाद",
        "पालघर",
        "परभणी",
        "पुणे",
        "रायगड",
        "रत्नागिरी",
        "सांगली",
        "सातारा",
        "सिंधुदुर्ग",
        "सोलापूर",
        "ठाणे",
        "वर्धा",
        "वाशिम",
        "यवतमाळ"
      ]
    },
    {
      "state": "मणिपूर",
      "districts": [
        "बिष्णुपुर",
        "झूमर",
        "चुराचंदपूर",
        "इम्फाल पूर्व",
        "इम्फाल वेस्ट",
        "जिरीबाम",
        "काचिंग",
        "कामजोंग",
        "कांगपोकपी",
        "नाही",
        "फेरजाऊल",
        "सेनापती",
        "तामेंग्लॉन्ग",
        "टेन्ग्नौपाल",
        "थॉबल",
        "उखरूल"
      ]
    },
    {
      "state": "मेघालय",
      "districts": [
        "ईस्ट गारो हिल्स",
        "पूर्व जेंटिया हिल्स",
        "पूर्व खासी हिल्स",
        "उत्तर गॅरो हिल्स",
        "री भोई",
        "दक्षिण गॅरो हिल्स",
        "दक्षिण पश्चिम गॅरो हिल्स",
        "दक्षिण पश्चिम खासी हिल्स",
        "वेस्ट गॅरो हिल्स",
        "वेस्ट जैंटिया हिल्स",
        "पश्चिम खासी हिल्स"
      ]
    },
    {
      "state": "मिझोरम",
      "districts": [
        "आयझॉल",
        "चांपाई",
        "कोलासिब",
        "लॉंगटलाई",
        "लुंगलेई",
        "ममीत",
        "सायहा",
        "सेर्शिप"
      ]
    },
    {
      "state": "नागालँड",
      "districts": [
        "दिमापूर",
        "किफिरे",
        "कोहिमा",
        "लाँगलेंग",
        "मोकोकचंग",
        "सोम",
        "पेरेन",
        "फेक",
        "तुएनसांग",
        "वोखा",
        "झुन्हेबोटो"
      ]
    },
    {
      "state": "ओडिशा",
      "districts": [
        "अंगुल",
        "बालंगिर",
        "बालासोर",
        "बारगड",
        "भद्रक",
        "बौद्ध",
        "कटक",
        "देवगड",
        "ढेंकनाल",
        "गजपती",
        "गंजम",
        "जगतसिंगपुर",
        "जाजपूर",
        "झारसुगुडा",
        "कलहांडी",
        "कंधमाल",
        "केंद्रपारा",
        "केन्दुझार (केनझार)",
        "खोरधा",
        "कोरापुट",
        "मलकानगिरी",
        "मयूरभंज",
        "नबरंगपूर",
        "नयागढ़",
        "नुआपाडा",
        "पुरी",
        "रायगड",
        "संबलपूर",
        "सोनेपूर",
        "सुंदरगड"
      ]
    },
    {
      "state": "पुडुचेरी (यूटी)",
      "districts": ["कराईकल", "महे", "पांडिचेरी", "यानम"]
    },
    {
      "state": "पंजाब",
      "districts": [
        "अमृतसर",
        "बरनाला",
        "बठिंडा",
        "फरीदकोट",
        "फतेहगड साहिब",
        "फाजिल्का",
        "फिरोजपूर",
        "गुरदासपूर",
        "होशियारपूर",
        "जालंधर",
        "कपूरथला",
        "लुधियाना",
        "मानसा",
        "मोगा",
        "मुक्तसर",
        "नवांशहर (शाहिद भगतसिंग नगर)",
        "पठाणकोट",
        "पटियाला",
        "रूपनगर",
        "साहिबादादा अजितसिंग नगर (मोहाली)",
        "संगरूर",
        "तरण तरण"
      ]
    },
    {
      "state": "राजस्थान",
      "districts": [
        "अजमेर",
        "अलवर",
        "बनसवारा",
        "बारन",
        "बाडमेर",
        "भरतपूर",
        "भीलवाडा",
        "बीकानेर",
        "बूंदी",
        "चित्तोडगड",
        "चूरू",
        "दौसा",
        "धौलपूर",
        "डूंगरपूर",
        "हनुमानगड",
        "जयपूर",
        "जैसलमेर",
        "जलोर",
        "झालावाड़",
        "झुंझुनू",
        "जोधपूर",
        "करौली",
        "कोटा",
        "नागौर",
        "पाली",
        "प्रतापगड",
        "राजसमंद",
        "सवाई माधोपूर",
        "सीकर",
        "सिरोही",
        "श्री गंगानगर",
        "टोंक",
        "उदयपुर"
      ]
    },
    {
      "state": "सिक्कीम",
      "districts": [
        "पूर्व सिक्किम",
        "उत्तर सिक्कीम",
        "दक्षिण सिक्किम",
        "वेस्ट सिक्कीम"
      ]
    },
    {
      "state": "तामिळनाडू",
      "districts": [
        "अरियालूर",
        "चेन्नई",
        "कोयंबटूर",
        "कुडलोर",
        "धर्मपुरी",
        "डिंडीगुल",
        "इरोड",
        "कांचीपुरम",
        "कन्याकुमारी",
        "करूर",
        "कृष्णागिरी",
        "मदुराई",
        "नागापट्टिनम",
        "नमक्कल",
        "नीलगिरी",
        "पेरंबलूर",
        "पुडुकोट्टाई",
        "रामनाथपुरम",
        "सालेम",
        "शिवगंगा",
        "तंजावर",
        "थेनी",
        "थुथुकुडी (तुतीकोरिन)",
        "तिरुचिराप्पल्ली",
        "तिरुनेलवेली",
        "तिरुप्पूर",
        "तिरुवल्लूर",
        "तिरुवन्नमलाई",
        "तिरुवरूर",
        "वेल्लोर",
        "विलुपुरम",
        "विरुधुनगर"
      ]
    },
    {
      "state": "तेलंगणा",
      "districts": [
        "आदिलाबाद",
        "भद्रद्री कोथगुडेम",
        "हैदराबाद",
        "जगातील",
        "जांगाव",
        "जयशंकर भोपाळपल्ली",
        "जोगुलंबा गडवाल",
        "कामरेड्डी",
        "करीमनगर",
        "खम्मम",
        "कोमारम भीम आसिफाबाद",
        "महाबुबाबाद",
        "महाबूबनगर",
        "मँचेरियल",
        "मेदक",
        "मेडचल",
        "नगरकर्णूल",
        "नलगोंडा",
        "निर्मल",
        "निजामाबाद",
        "पेद्दापल्ली",
        "राजन्ना सिरसिल्ला",
        "रंगारेड्डी",
        "संगारेड्डी",
        "सिद्दिपेट",
        "सूर्यपेट",
        "विकराबाद",
        "वानपर्ती",
        "वारंगल (ग्रामीण)",
        "वारंगल (शहरी)",
        "यादद्रि भुवनागिरी"
      ]
    },
    {
      "state": "त्रिपुरा",
      "districts": [
        "धलाई",
        "गोमती",
        "खोवाई",
        "उत्तर त्रिपुरा",
        "सेपहिजाला",
        "दक्षिण त्रिपुरा",
        "उनाकोटी",
        "पश्चिम त्रिपुरा"
      ]
    },
    {
      "state": "उत्तराखंड",
      "districts": [
        "अल्मोडा",
        "बागेश्वर",
        "चमोली",
        "चंपावत",
        "देहरादून",
        "हरिद्वार",
        "नैनीताल",
        "पौरी गढवाल",
        "पिथौरागड",
        "रुद्रप्रयाग",
        "टिहरी गढवाल",
        "उधमसिंह नगर",
        "उत्तरकाशी"
      ]
    },
    {
      "state": "उत्तर प्रदेश",
      "districts": [
        "आग्रा",
        "अलिगड",
        "अलाहाबाद",
        "आंबेडकर नगर",
        "अमेठी (छत्रपती साहूजी महराज नगर)",
        "अमरोहा (जे. पी. नगर)",
        "औरैया",
        "आजमगड",
        "बागपत",
        "बहराइच",
        "बलिया",
        "बलरामपूर",
        "बांदा",
        "बाराबंकी",
        "बरेली",
        "बस्ती",
        "भदोही",
        "बिजनौर",
        "बुडौन",
        "बुलंदशहर",
        "चंदौली",
        "चित्रकूट",
        "देवरिया",
        "एटा",
        "इटावा",
        "फैजाबाद",
        "फर्रुखाबाद",
        "फतेहपूर",
        "फिरोजाबाद",
        "गौतम बुद्ध नगर",
        "गाझियाबाद",
        "गाजीपुर",
        "गोंडा",
        "गोरखपूर",
        "हमीरपूर",
        "हापूर (पंचशील नगर)",
        "हरदोई",
        "हाथरस",
        "जालौन",
        "जौनपुर",
        "झांसी",
        "कन्नौज",
        "कानपूर देहात",
        "कानपूर नगर",
        "कांशीराम नगर (कासगंज)",
        "कौशांबी",
        "कुशीनगर (पडरौना)",
        "लखीमपूर - खेरी",
        "ललितपूर",
        "लखनऊ",
        "महाराजगंज",
        "महोबा",
        "मैनपुरी",
        "मथुरा",
        "मौ",
        "मेरठ",
        "मिर्जापूर",
        "मुरादाबाद",
        "मुझफ्फरनगर",
        "पीलीभीत",
        "प्रतापगड",
        "रायबरेली",
        "रामपूर",
        "सहारनपूर",
        "संभळ (भीम नगर)",
        "संत कबीर नगर",
        "शाहजहांपूर",
        "शामली (प्रबुद्ध नगर)",
        "श्रावस्ती",
        "सिद्धार्थ नगर",
        "सीतापूर",
        "सोनभद्र",
        "सुलतानपूर",
        "उन्नाव",
        "वाराणसी"
      ]
    },
    {
      "state": "पश्चिम बंगाल",
      "districts": [
        "अलीपुरद्वार",
        "बांकुरा",
        "बीरभूम",
        "बर्दवान (बर्धमान)",
        "कूच बिहार",
        "दक्षिण दिनजपूर (दक्षिण दिनाजपूर)",
        "दार्जिलिंग",
        "हुगली",
        "हावडा",
        "जलपाईगुडी",
        "कॅलिंपोंग",
        "कोलकाता",
        "मालदा",
        "मुर्शिदाबाद",
        "नादिया",
        "उत्तर 24 परगना",
        "पश्चिम मेदिनीपुर (पश्चिम मेदिनीपुर)",
        "पूर्बा मेदिनीपुर (पूर्व मेदिनीपुर)",
        "पुरुलिया",
        "दक्षिण 24 परगणा",
        "उत्तर दिनाजपूर (उत्तर दिनाजपूर)"
      ]
    }
  ];
}