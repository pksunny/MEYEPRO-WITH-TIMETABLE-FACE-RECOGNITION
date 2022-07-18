
import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/LoginScreen.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/AdminTeacherLoginPage.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/SignupTeacher.dart';
import 'package:m_eye_gui/2-sidebar/menu_item.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Home%20Screen/TeacherHomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/7-Setting%20Screen/Setting.dart';
import 'package:m_eye_gui/8-About%20Screen/AboutPage.dart';
import 'package:m_eye_gui/9-Notification%20Screen/NotificationPage.dart';
import 'package:m_eye_gui/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class TeacherDrawerPage extends StatefulWidget {
  const TeacherDrawerPage({Key? key,}) : super(key: key);

  // final String name,email;


  @override
  State<TeacherDrawerPage> createState() => _TeacherDrawerPageState();
}

class _TeacherDrawerPageState extends State<TeacherDrawerPage> {

  String notival = "0";

  late Timer timer;

  void initState(){
   super.initState();
  //  GetNotifications();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => GetNotifications().then((value) {
      setState(() {
        notival = value;
        print('Total Notifications:$notival');
      });
    })
    );

    // GetNotifications().then((value) {
    //   setState(() {
    //     notival = value;
    //     print('Total Notifications:$notival');
    //   });
    // });
  }

  int counter = 0;
  
  // DateTime now = DateTime.now();
  var st = '11:30:00',et='01:00:00',day='Monday',teacher='Mr Umer',section='BSCS-6C',course='CS687_PDC_50';

  // GET NOTIFICATION COUNT API //
  Future<String> GetNotifications() async {
    String url = ApiUrl.apiUrl + 'meyepro/api/TimeTable/GetNotifications?username=' + name1.toString();
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "0";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 15,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF03E5B7),
                          Color(0xFF08C8F6),
                          Color(0xFF48A9FE),
                        ]
                    ),
                  ),
                  // color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100,),
                      ListTile(
                        title: Text(name1.toString(),style: TxtStyle.drawertitlestyle,),
                        subtitle: Text(email1.toString(),style: TxtStyle.drawersubtitlestyle),
                        trailing: Text(mode1.toString(),style: TxtStyle.drawersubtitlestyle,),
                        // leading: CircleAvatar(
                        //   child: Icon(Icons.perm_identity, color: Colors.white,),
                        //   radius: 25,
                        // ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 1.1,
                        color: Colors.white,
                        indent: 28,
                        endIndent: 28,
                      ),
                      InkWell(
                        child: ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home',style: TxtStyle.normaltxtstyle,),
                        ),
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SideBarLayout()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherHomeScreen()));
                          },
                      ),
                      // InkWell(
                      //   child: ListTile(
                      //     leading: Icon(Icons.person_add),
                      //     title: Text('Add New Teacher',style: TxtStyle.normaltxtstyle),
                      //   ),
                      //   onTap: (){
                      //     // Navigator.push(context, MaterialPageRoute(builder: (context) => SideBarLayout()));
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignupTeacher()));
                      //     },
                      // ),
                      InkWell(
                        child: ListTile(
                          leading: Badge(
                            badgeContent: Text(notival ,style: const TextStyle(fontSize: 10),),
                            child: Icon(Icons.notifications_active_outlined)
                            ),
                          title: Text("Notification",style: TxtStyle.normaltxtstyle),
                        ),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));},
                      ),
                      InkWell(
                        splashColor: Colors.blue,
                        highlightColor: Colors.cyanAccent,
                        child: ListTile(
                          leading: Icon(Icons.info_outlined),
                          title: Text("About",style: TxtStyle.normaltxtstyle),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                        },
                      ),
                      // InkWell(
                      //   child: ListTile(
                      //     leading: Icon(Icons.settings),
                      //     title: Text("Setting",style: TxtStyle.normaltxtstyle),
                      //   ),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
                      //   },
                      // ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white,
                        indent: 28,
                        endIndent: 28,
                      ),
                      InkWell(
                        splashColor: Colors.redAccent,
                        highlightColor: Colors.limeAccent,
                        child: ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("Logout",style: TxtStyle.normaltxtstyle),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => AdminTeacherLoginPage()),
                          (Route<dynamic> route) => false,
                        );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
