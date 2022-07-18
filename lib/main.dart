// ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/LoginScreen.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/AdminTeacherLoginPage.dart';
import 'package:m_eye_gui/3-HomeScreen/DrawerPage.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m_eye_gui/3-HomeScreen/Notifications/NotificationPage.dart';
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Home%20Screen/TeacherHomeScreen.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlotsOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/TimeTableScreen.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:m_eye_gui/7-Setting%20Screen/0-Recording%20Mode%20Screen/RecordingModePage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/0-Add%20DVR%20Screen/AddDVRPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/3-Facial%20Recognition%20Screen/FacialRecognitionPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/3-Facial%20Recognition%20Screen/TeacherImageUploadPage.dart';
import 'package:m_eye_gui/CUSTOM%20WIDGETS/CustomWidgets.dart';

void main() async {

  AwesomeNotifications().initialize(
      'resource://drawable/logo.png',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel to activate badge indicator',
            channelShowBadge: true,
            defaultColor: Color(0xFF9D50DD),
            // ledColor: Colors.yellow),
        )
      ]
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      // home : HomeScreen(),
      home:const AdminTeacherLoginPage(),
    );
  }
}

class ApiUrl
{
  static String apiUrl = "http://192.168.1.3/";
}

class TxtStyle 
{
  static var appbartextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold);
  static var boldtxtstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 20,color: Color.fromRGBO(63, 63, 63, 1));
  static var boldtxtstyleblue = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue);
  static var normaltxtstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 20,color: Color.fromRGBO(63, 63, 63, 1));
  static var drawersubtitlestyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  static var drawertitlestyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 20,fontWeight: FontWeight.bold, color: Color.fromRGBO(63, 63, 63, 1));
  static var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  static var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xFF03E5B7),
            //     Color(0xFF08C8F6),
            //     Color(0xFF48A9FE),
            //   ]
            // ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
              Image.asset('assets/images/cctv.png',height: 120,),
              const SizedBox(height: 15,),
              const Text('M EYE PRO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              ),
              const SizedBox(height: 30,),
              Container(
                height: 480,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    const Text('Welcome to MEYEPRO',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    const Text('Please Login to Your Account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                 
                    Container(
                      width: 250,
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          suffixIcon: Icon(FontAwesomeIcons.envelope,size: 20,),

                        ),
                      ),
                    ),

                    Container(
                      width: 250,
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 20,),
                        ),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forget Password',
                          style: TextStyle(
                            color: Colors.cyan,
                          ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // gradient: const LinearGradient(
                          //   begin: Alignment.centerLeft,
                          //   end: Alignment.centerRight,
                          //   colors: [
                          //     Color(0xFF03E5B7),
                          //     Color(0xFF08C8F6),
                          //     Color(0xFF48A9FE),
                          //   ]
                          // ),
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),onTap: (){

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    ),

                    //SizedBox(height: 30,),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

