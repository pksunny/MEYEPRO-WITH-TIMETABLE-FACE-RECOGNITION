// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/AdminTeacherLoginPage.dart';
import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlots.dart';
import 'package:m_eye_gui/9-Notification%20Screen/NotificationOnClick.dart';

import '../main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

var nid;
var nteachername;
var nmsg;
var nstatus;

class _NotificationPageState extends State<NotificationPage> {

  late Timer timer;

  void initState(){
   super.initState();
   GetNotificationDetails();
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => GetNotificationDetails());
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => GetNotificationDetails());

    updateStatus();
  }

  List<NotificationTable> notificationTable = [];

  GetNotificationDetails() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/GetNotificationsDetail?username=' + name1.toString()));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      // print(listt);
      notificationTable = listt.map((e) => NotificationTable.fromJson(e)).toList();
      
      setState(() {

      });
    }
    else
    {
      throw Exception('Failed to update Record!');
    }

  //   for (int i=0;i<notificationTable.length;i++)
  //     {
  //        var updateresponse;

  //        var n = notificationTable.map((e) async => {
  //       // nid = e.nid,
  //       // nteachername = e.teachername,
  //       // nmsg = e.msg,
  //       // nstatus = e.status,

  //       print(e.nid),
  //       print(e.teachername),
  //       // print(e.msg),
  //       // print(e.status),
  //       // print(nid + ' ' + nteachername + ' ' + nmsg + ' ' + nstatus),

  //     updateresponse = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/UpdateNotificationStatus'),
  //     body:{
  //       'nid': e.nid,
  //       'teachername': e.teachername,
  //       'msg': e.msg,
  //       'status': 1,
  //     }),
  //     });
      
  //     if (updateresponse.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Viewed!"),));
  //     // return Notif.fromJson(json.decode(updateresponse.body));
  //   } 
  //   else 
  //   {
  //     throw Exception('Failed to update Record!');
  //   }      
  // }

  }

  final TextEditingController statusController = new TextEditingController();

  updateStatus() async {

    setState(() {
      statusController.text = "1";
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/UpdateTeacherStatus?teachername=' + 
      name1.toString() + 
      "&status=" + statusController.text
      ));


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Viewed!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Notifications'),
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
        child: (notificationTable.isNotEmpty) ? ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            itemCount: 10,
            itemBuilder: (context,index) {
              return ListTile(
                leading: Icon(Icons.circle_notifications,size: 50,),
                title: Text(notificationTable[index].teachername,style: TextStyle(color: Colors.blue),),
                subtitle: Text(notificationTable[index].msg.toString()),
                onTap: (){
                        String teachername=notificationTable[index].teachername;
                        
                        List<NotificationTable> data=[];
                        for(int i=0;i<notificationTable.length;i++)
                        {
                          if(notificationTable[i].teachername==teachername)
                          data.add(notificationTable[i]);
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationOnClick(overall: notificationTable[index], notificationtimetable:data,)));
                        },
              );
            },
            separatorBuilder: (context,index) {
              return Divider();
            }
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.notifications_off_outlined, color: Colors.blue,),
              Text('No Notification!',style: TxtStyle.boldtxtstyle,)
            ],
          ),
        )
      ),
    );
  }
}


class NotificationTable
{
  late int nid;
  late String teachername;
  late String msg;
  late int status;
  
  
  NotificationTable({
    required this.nid,
    required this.teachername,
    required this.msg,
    required this.status,
    });

  factory NotificationTable.fromJson(Map<String,dynamic>json)
  {
    return NotificationTable(
      nid:json['nid'],
      teachername:json['teachername'],
      msg:json['msg'],
      status:json['status'],
    );
  }
}