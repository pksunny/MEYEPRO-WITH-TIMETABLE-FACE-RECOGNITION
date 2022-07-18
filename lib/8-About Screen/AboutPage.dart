import 'package:flutter/material.dart';
import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:m_eye_gui/main.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('About',style: TxtStyle.appbartextstyle),
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
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('About',textAlign: TextAlign.center,style: TxtStyle.boldtxtstyle)
                ),
              ),

              Divider(height: 10,thickness: 3, indent: 300, endIndent: 300,),
              SizedBox(height: 20,),

              Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('MEYE PRO WITH TIME TABLE',textAlign: TextAlign.center,style: TxtStyle.editTextStyle),
                  )
              ),

              Divider(height: 10,thickness: 4,endIndent: 220,indent: 220,),
              SizedBox(height: 10,),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('This application is developed for the security purpose of an organization and helps in viewing camera streaming and lecture details from DVR. Any university can use this mobile application.'
                      '\nThe product provides the following features:'
                      '\n•  User can be able to monitor cameras remotely from their mobile phones and desktop by entering valid logins data.'
                      '\n•  Can view video streams and lecture details from all DVR channels simultaneously.'
                      '\n•  Recording videos and saving them on user end.'
                      '\n•  Generating alerts about lectures according to timetable.'
                      '\nFacial recognition is the advance feature of this app to recognize every teacher constantly.',
                  style: TxtStyle.normaltxtstyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
