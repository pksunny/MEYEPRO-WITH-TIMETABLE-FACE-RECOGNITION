import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/LoginScreen.dart';
import 'package:m_eye_gui/2-sidebar/menu_item.dart';
import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
import 'package:m_eye_gui/3-HomeScreen/DrawerPage.dart';
import 'package:m_eye_gui/3-HomeScreen/Notifications/NotificationPage.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlots.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:m_eye_gui/6.1-%20CHR/CHR.dart';
import 'package:m_eye_gui/6.1-%20CHR/TASK%20CHR/TaskChr.dart';
import 'package:m_eye_gui/7-Setting%20Screen/Setting.dart';
import 'package:m_eye_gui/8-About%20Screen/AboutPage.dart';
import 'package:m_eye_gui/9-Notification%20Screen/NotificationPage.dart';
import 'package:m_eye_gui/main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);
  // final String name,email;

  

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      super.initState();

      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if(!isAllowed)
        {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would Like to send you a notification'),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text('Allow')
                  ),

                  TextButton(
                  onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context)),
                  child: Text('Don\'t Allow')
                  ),
              ],
              )
            );
        }
      });
    }

    var size = MediaQuery.of(context).size;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //style
    var cardtextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      appBar : AppBar(
        title: Center(child: Text('DashBoard',style: TxtStyle.appbartextstyle)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF03E5B7),
                  Color(0xFF08C8F6),
                  Color(0xFF48A9FE),
                ]
            ),
          ),
        ),
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SideBarLayout()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.white,
        // ),

        // automaticallyImplyLeading: false,

      ),

      drawer: DrawerPage(),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height*1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png'),
                  ),
                ),
              ),

              Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/images/livestreaming.svg',
                                height: 70,
                              ),
                              //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                              Text(
                                'Live Streaming',
                                style: cardtextstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LiveStreaming()));
                    },
                  ),
                  ),

                  // SizedBox(height: 10,),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/searching.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'Search',
                              style: cardtextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SectionSearchScreen()));
                    },
                  ),
                  ),

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/freeclass.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'Free Slots',
                              style: cardtextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FreeSlots()));
                    },
                  ),
                  ),


                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/record-button.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'Recorded Video',
                              style: cardtextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordedVideo()));
                    },
                  ),
                  ),

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/chr.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'CHR',
                              style: cardtextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskCHR()));
                    },
                  ),
                  ),

                   Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                    splashColor: Colors.blue,
                    highlightColor: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/settings.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'Setting',
                              style: cardtextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Setting()));
                    },
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

