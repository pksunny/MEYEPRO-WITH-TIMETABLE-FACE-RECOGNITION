import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:m_eye_gui/7-Setting%20Screen/0-Recording%20Mode%20Screen/RecordingModePage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/1-View%20Setting%20Screen/ViewSettingPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/DVRSettingPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/3-Facial%20Recognition%20Screen/FacialRecognitionPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/3-Facial%20Recognition%20Screen/TeacherImageUploadPage.dart';
import 'package:m_eye_gui/main.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Setting', style: TxtStyle.appbartextstyle,),
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
        //     // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        //   },
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.white,
        // ),
      ),

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 40,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.settings_rounded,color: Colors.blue,),
                  // SizedBox(width: 20,),
                  Text("Setting",textAlign: TextAlign.center,style: TxtStyle.boldtxtstyle),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Divider(height: 20,thickness: 1,),
              ),
              SizedBox(height: 10,),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              //   child: InkWell(
              //     splashColor: Colors.blue,
              //     highlightColor: Colors.blue,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       textDirection: TextDirection.ltr,
              //       children: [
              //         Icon(Icons.video_settings,color: Colors.blue,size: 30,),
              //         // SizedBox(width: 10,),
              //         Text("Recording Mode",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              //         Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
              //       ],
              //     ),
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => RecordingModePage()));
              //     },
              //   ),
              // ),

              // SizedBox(height: 10,),
              //
              // InkWell(
              //   splashColor: Colors.blue,
              //   highlightColor: Colors.blue,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       textDirection: TextDirection.ltr,
              //       children: [
              //         Icon(Icons.view_carousel_sharp,color: Colors.blue,size: 30,),
              //         // SizedBox(width: 10,),
              //         Text("View Setting",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              //         Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
              //       ],
              //     ),
              //   ),
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSettingPage()));
              //   },
              // ),

              SizedBox(height: 10,),

              InkWell(
                splashColor: Colors.blue,
                highlightColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(Icons.dvr_sharp,color: Colors.blue,size: 30,),
                      // SizedBox(width: 10,),
                      Text("DVR Setting",style: TxtStyle.boldtxtstyle),
                      Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DVRSettingPage()));
                },
              ),

              SizedBox(height: 10,),

              InkWell(
                splashColor: Colors.blue,
                highlightColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: [
                      Icon(Icons.face_outlined,color: Colors.blue,size: 30,),
                      // SizedBox(width: 10,),
                      Text("Face Recognition",style: TxtStyle.boldtxtstyle),
                      Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherImageUploadPage()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
