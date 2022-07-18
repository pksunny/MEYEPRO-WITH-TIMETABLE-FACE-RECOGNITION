import 'package:flutter/material.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/0-Add%20DVR%20Screen/AddDVRPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/1-Edit%20DVR%20Screen/Update%20DVR%20Screen/EditDVRPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/2-Add%20Channel/AddNewChannelPage.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/3-Edit%20Channel/UpdateChannelPage.dart';
import 'package:m_eye_gui/main.dart';

class DVRSettingPage extends StatefulWidget {
  const DVRSettingPage({Key? key}) : super(key: key);

  @override
  _DVRSettingPageState createState() => _DVRSettingPageState();
}

class _DVRSettingPageState extends State<DVRSettingPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

    return Scaffold(
      appBar : AppBar(
        title: Text('DVR Setting'),
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
      ),

      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      // height: height*0.44,

                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: InkWell(
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.blue,
                                    margin: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Add DVR',style: TxtStyle.boldtxtstyle , textAlign: TextAlign.center)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddDVRPage()));
                                },
                              ),
                            ),

                            SizedBox(height: height*0.04,),
                            Center(
                              child: InkWell(
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.blue,
                                    margin: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Update DVR',style: TxtStyle.boldtxtstyle,textAlign: TextAlign.center,)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditDVRPage()));
                                },
                              ),
                            ),

                            SizedBox(height: height*0.04,),
                            Center(
                              child: InkWell(
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.blue,
                                    margin: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Add Channel',style: TxtStyle.boldtxtstyle,textAlign: TextAlign.center,)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewChannelPage()));
                                },
                              ),
                            ),

                            SizedBox(height: height*0.04,),
                            Center(
                              child: InkWell(
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.blue,
                                    margin: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Update Channel',style: TxtStyle.boldtxtstyle,textAlign: TextAlign.center,)
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateChannelPage()));
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}
