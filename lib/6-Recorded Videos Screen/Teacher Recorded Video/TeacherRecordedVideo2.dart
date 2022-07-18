import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideoOnClick.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Recorded%20Video/TeacherRecordedOnClick.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/Teacher%20Recorded%20Video/TeacherRecordedVideoOnClick2.dart';
import 'package:m_eye_gui/main.dart';

import '../../1-Login+Signup Screen/Multi Login/AdminTeacherLoginPage.dart';

class TeacherRecordedVideo2 extends StatefulWidget {
  const TeacherRecordedVideo2({ Key? key }) : super(key: key);

  @override
  State<TeacherRecordedVideo2> createState() => _TeacherRecordedVideo2State();
}

class _TeacherRecordedVideo2State extends State<TeacherRecordedVideo2> {

  void initState(){
   super.initState();
    getPythonVideo();
  }

  List<SavePython> videouploadList = [];

  // var baseUrl = 'http://192.168.152.123';

  Future<void> getPythonVideo() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/SavePython2/getPythonVideo?teachername=' + name1.toString()));
    if(response.statusCode==200)
    {
      print("Successfull Show Record");


      Iterable listt = jsonDecode(response.body);
      print(listt);
      videouploadList=listt.map((e) => SavePython.fromJson(e)).toList();
      setState(() {

      });
    }
    else
      throw Exception('Failed to load data');

  }

  // VlcPlayerController _vlcViewController;


  // _onTap(int index)
  // {
  //   _vlcViewController = new VlcPlayerController.network(
  //   videourlList[index].videourl.toString(),
  //   autoPlay: true,
  //   options: VlcPlayerOptions(),
  // );
  // }

  String _location(dynamic media)
  {
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recorded Videos'),
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            // itemCount: videouploadList.length,
            itemCount: videouploadList.length,
            itemBuilder: (context,index){
              String myUrl = ApiUrl.apiUrl + Uri.parse(videouploadList[index].videopath.toString()).toString();
              VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay: true,options: VlcPlayerOptions());
              return InkWell(
                onTap: (){
                      String videopath=videouploadList[index].id.toString();
                      
                      List<SavePython> data=[];
                      for(int i=0;i<videouploadList.length;i++)
                      {
                        if(videouploadList[i].videopath==videopath)
                        data.add(videouploadList[i]);
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherRecordedOnClick2(videouplod: videouploadList[index], videouploadList:data,)));
                      
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.withOpacity(0.5)),
                  child: Stack(
                    alignment: FractionalOffset.bottomCenter,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: VlcPlayer(
                            controller: _vlcPlayer,
                            aspectRatio: 16 / 9,
                            placeholder: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              videouploadList[index].videoname.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            ),
      ),
    );
  }
}

