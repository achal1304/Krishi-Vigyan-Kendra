import 'package:flutter/material.dart';

//import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'आमच्याबद्दल',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset('assets/sanskriti samvardhan mandal.png'),
            SizedBox(height: 12),
            // Image.network(
            //     'http://www.iskconpune.com/dev/wp-content/uploads/2013/10/iskcon_logo.png'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "मराठावाड्यातील एस.एस.एम ही एक प्रमुख संस्था आहे, ज्याने समाजातील लहान शेतकरी आणि दुर्बल घटकांमध्ये कृषी ज्ञान आणि तंत्रज्ञान पोहोचविण्याच्या उद्देशाने ऑक्टोबर २०११ मध्ये कृषी विज्ञान केंद्राची स्थापना केली. केव्हीके हा आयसीएआरचा एक संस्थात्मक प्रकल्प आहे ज्यायोगे कृषी संशोधन आणि शिक्षणाचे विज्ञान आणि तंत्रज्ञान इनपुटचा उपयोग शेतकरी शेतात आणि ग्रामीण भागात वैज्ञानिकांच्या बहु-अनुशासनात्मक टीमच्या मदतीने दर्शविला जातो.",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
