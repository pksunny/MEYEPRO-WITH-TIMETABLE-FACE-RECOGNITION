import 'package:flutter/material.dart';
import 'package:m_eye_gui/9-Notification%20Screen/NotificationPage.dart';
import 'package:m_eye_gui/main.dart';
import 'package:http/http.dart' as http;

class NotificationOnClick extends StatefulWidget {
  const NotificationOnClick({Key? key, required this.overall,required this.notificationtimetable}) : super(key: key);

  final NotificationTable overall;
  final List<NotificationTable> notificationtimetable;

  @override
  State<NotificationOnClick> createState() => _NotificationOnClickState();
}

class _NotificationOnClickState extends State<NotificationOnClick> {

  void initState() {
    super.initState();
    // updateStatus();
  }

  // final TextEditingController nidController = new TextEditingController();
  // final TextEditingController teachernameController = new TextEditingController();
  // final TextEditingController msgController = new TextEditingController();
  // final TextEditingController statusController = new TextEditingController();

  // updateStatus() async {

  //   setState(() {
  //     nidController.text = widget.overall.nid.toString();
  //     teachernameController.text = widget.overall.teachername.toString();
  //     msgController.text = widget.overall.msg.toString();
  //     statusController.text = "1";
  //   });

  //   var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/UpdateNotificationStatus'),
  //     body:{
  //       'nid': nidController.text,
  //       'teachername': teachernameController.text,
  //       'msg': msgController.text,
  //       'status': statusController.text,
  //     });


      
  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Viewed!"),));
  //     // return TimeTable.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update Record!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar : AppBar(
        title: Center(child: Text(widget.overall.teachername)),
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
        child: Center(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height*0.3,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Card(
              elevation: 10,
              shadowColor: Colors.cyan,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.overall.teachername + '\n',style: TxtStyle.boldtxtstyle),
                    Text(widget.overall.msg, style: TxtStyle.normaltxtstyle,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}