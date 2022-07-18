import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/LoginScreen.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/AdminTeacherLoginPage.dart';
import 'package:m_eye_gui/2-sidebar/menu_item.dart';
import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
import 'package:m_eye_gui/3-HomeScreen/DrawerPage.dart';
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Drawer/TeacherDrawerPage.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Specific%20Teacher%20MakeUp%20Class/ViewSpecificTeacherMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Specific%20Teacher%20Search%20Screen/SpecificTeacherSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Hide%20Recorded%20Video/TeacherHideRecordedVideo.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Hide%20Recorded%20Video/TeacherHideRecordedVideo2.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Recorded%20Video/TeacherRecordedVideo.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Recorded%20Video/TeacherRecordedVideo2.dart';
import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
import 'package:m_eye_gui/6.1-%20CHR/Specific%20Teacher%20CHR/SpecificTeacherCHR2.dart';
import 'package:m_eye_gui/7-Setting%20Screen/Setting.dart';
import 'package:m_eye_gui/8-About%20Screen/AboutPage.dart';
import 'package:m_eye_gui/9-Notification%20Screen/NotificationPage.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';


class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key,}) : super(key: key);
  // final String name,email;

  

  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {

  // String time = DateFormat('hh:mm:ss').format(date);
  //   print(time);

  late Timer timer;

  TimeOfDay nowTime = TimeOfDay.now();

  void initState(){
   super.initState();
  //  SetNotifications();
    // GETTING CURRENT TIME //
    // DateTime dateTime=DateTime.now();

    // // PARSING SLOT 1 DATETIME//
    // String slot1_stime = "0000-00-00 08:00:00";
    // DateTime slot1_sdt = DateTime.parse(slot1_stime);
    // print('Slot 1 Start Time => $slot1_sdt');

    // String slot1_etime = "0000-00-00 08:30:00";
    // DateTime slot1_edt = DateTime.parse(slot1_stime);
    // print('Slot 1 End Time => $slot1_edt');

    // // PARSING SLOT 2 DATETIME//
    // String slot2_stime = "0000-00-00 11:00:00";
    // DateTime slot2_sdt = DateTime.parse(slot1_stime);
    // print('Slot 2 Start Time => $slot2_sdt');

    // String slot2_etime = "0000-00-00 11:30:00";
    // DateTime slot2_edt = DateTime.parse(slot2_stime);
    // print('Slot 2 End Time => $slot2_edt');


    // if(dateTime.isAfter(slot1_sdt) && dateTime.isBefore(slot1_edt))
    // {
    //   print('Slot 1 API Hit at => $dateTime');
    //   print('Slot 1 true');
    //   SetNotifications();
    // }
    // else if(dateTime.isAfter(slot2_sdt) && slot2_edt.isBefore(dateTime))
    // {
    //   print('Slot 2 API Hit at => $dateTime');
    //   SetNotifications();
    // }
    // timer = Timer.periodic(Duration(minutes: 60), (Timer t) => SetNotifications());
  }

  
   // SET NOTIFICATION API //
  SetNotifications() async {
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/SetNotifications'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Called!");
      //print(response.body);
      
      setState(() {

      });
    }
    else
    {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //style
    var cardtextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      appBar : AppBar(
        title: Center(child: Text('DashBoard', style: TxtStyle.appbartextstyle)),
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

      drawer: TeacherDrawerPage(),

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
                  // Container(
                  //   width: double.maxFinite,
                  //   margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  //   child: InkWell(
                  //   splashColor: Colors.blue,
                  //   highlightColor: Colors.blue,
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(20),
                  //       bottomRight: Radius.circular(20)),
                  //   child: Card(
                  //     elevation: 15,
                  //     shadowColor: Colors.black,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(20),
                  //             bottomRight: Radius.circular(20))),
                  //     child: Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(10),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/images/livestreaming.svg',
                  //               height: 70,
                  //             ),
                  //             //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                  //             Text(
                  //               'Live Streaming',
                  //               style: cardtextstyle,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => LiveStreaming()));
                  //   },
                  // ),
                  // ),

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
                            Image.asset('assets/images/timetable.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'Time Table',
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
                              builder: (context) => SpecificTeacherSearchScreen()));
                    },
                  ),
                  ),

                  // Container(
                  //   width: double.maxFinite,
                  //   margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  //   child: InkWell(
                  //   splashColor: Colors.blue,
                  //   highlightColor: Colors.blue,
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(20),
                  //       bottomRight: Radius.circular(20)),
                  //   child: Card(
                  //     elevation: 15,
                  //     shadowColor: Colors.black,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(20),
                  //             bottomRight: Radius.circular(20))),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(10),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           Image.asset('assets/images/record-button.png',height:70,),
                  //           //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                  //           Text(
                  //             'Recorded Video',
                  //             style: cardtextstyle,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RecordedVideo()));
                  //   },
                  // ),
                  // ),

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
                            Image.asset('assets/images/reschedule.png',height:70,),
                            //SvgPicture.network('https://cdn-icons-png.flaticon.com/512/2040/2040702.png',height: 128,),
                            Text(
                              'View MakeUp Class',
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
                              builder: (context) => ViewSpecificTeacherMakeUpClass()));
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
                              'View CHR',
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
                              builder: (context) => SpecificTeacherCurrentDateCHR2()));
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
                              'View Recorded Video',
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
                              builder: (context) => TeacherRecordedVideo2()));
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
                              'View Hide Recorded Video',
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
                              builder: (context) => TeacherHideRecordedVideo2()));
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

