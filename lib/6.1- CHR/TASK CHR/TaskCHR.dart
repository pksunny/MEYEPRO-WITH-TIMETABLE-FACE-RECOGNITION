import 'dart:ffi';
import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
import 'package:m_eye_gui/6.1-%20CHR/TASK%20CHR/TaskPDFAPI.dart';
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import '../../../../main.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io'; 
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


class TaskCHR extends StatefulWidget {
  const TaskCHR({Key? key}) : super(key: key);

  @override
  _TaskCHRState createState() => _TaskCHRState();
}

class _TaskCHRState extends State<TaskCHR> {

  void initState() {
    super.initState();

    ShowAllCHR2();
  }

  late TextEditingController dvrNameController;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

  List<TaskCHRTable> chrTable = [];

  Future<void> ShowAllCHR2() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR2/getCHR2'));
    // var response=await http.get(Uri.parse('https://localhost:44353/api/CHR/getCHR'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      chrTable = listt.map((e) => TaskCHRTable.fromJson(e)).toList();
      setState(() {

      });
    }
    else
      throw Exception('Failed to load data');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('CHR', style: TxtStyle.appbartextstyle,),
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

        actions: [
          PopupMenuButton(
              offset: Offset(0.0, AppBar().preferredSize.height),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificTeacherCHR()));
                          },
                          child: Text("Specific Teacher CHR")),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDateCHR()));
                          },
                          child: Text("Specific Date CHR")),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDayCHR()));
                          },
                          child: Text("Specific Day CHR")),
                      value: 3,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificSectionCHR()));
                          },
                          child: Text("Specific Section CHR")),
                      value: 4,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherDateCHR()));
                          },
                          child: Text("Teacher+Date CHR")),
                      value: 5,
                    )
                  ])
        ],

      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async{
          if(i == 0)
          {
            final pdfFile = await TaskPdfApi.generateTable();

            TaskPdfApi.openFile(pdfFile);
          }
        }
      ),

      body: RefreshIndicator(
        onRefresh: ShowAllCHR2,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  
                  SizedBox(height: 15),
                  // Container(
                  //   margin: EdgeInsets.only(right: 1100),
                  //   child: Text('{$dayy}', style: TxtStyle.cardtextstyle2)
                  //   ),

                  SizedBox(height: 15,),
                  Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),

                  SizedBox(height: 15,),
                  Text('Class Held Report',style: TxtStyle.boldtxtstyleblue,),

                  SizedBox(height: 10,),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(15),
                    
                    child: Expanded(
                      // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
                      child: DataTable(
                      
                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
                        // columnSpacing: 38.0,
                        // border: TableBorder.all(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(10),
                        //     width: 3),
                        columns: [
                          // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
                          DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
                          DataColumn(label: Text('In Time',style: cardtextstyle2,)),
                          DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
                          DataColumn(label: Text('In Date', style: cardtextstyle2,)),
                          DataColumn(label: Text('Day ', style: cardtextstyle2,)),
                          DataColumn(label: Text('Section',style: cardtextstyle2,)),
                          DataColumn(label: Text('Course',style: cardtextstyle2,)),
                          DataColumn(label: Text('Venue',style: cardtextstyle2,)),
                          DataColumn(label: Text('Status ', style: cardtextstyle2,)),
                          DataColumn(label: Text('Late In', style: cardtextstyle2,)),
                          DataColumn(label: Text('Left Early', style: cardtextstyle2,)),
                        ],
                        rows: List.generate(chrTable.length, (index) {
                          // final dvrid = dvrTable[index].dvrid.toString();
                          final teachername = chrTable[index].name.toString();
                          final intime = chrTable[index].intime.toString();
                          final outtime = chrTable[index].outime.toString();
                          final indate = chrTable[index].indate.toString();
                          final dayy = chrTable[index].dayy.toString();
                          final sectionname = chrTable[index].sectionname.toString();
                          final coursename = chrTable[index].coursename.toString();
                          final venue = chrTable[index].venue.toString();
                          final status = chrTable[index].status.toString();
                          final latein = chrTable[index].latein.toString();
                          final leftearly = chrTable[index].leftearly.toString();
                          return DataRow(
                            color: MaterialStateProperty.resolveWith((states) => (status =='Late + Left Early' || status == 'Late') ? Colors.yellow : Colors.white),
                            cells: [
                            // DataCell(Text(dvrid),showEditIcon: true),
                            DataCell(Text(teachername)),
                            DataCell(Text(intime)),
                            DataCell(Text(outtime)),
                            DataCell(Text(indate)),
                            DataCell(Text(dayy)),
                            DataCell(Text(sectionname)),
                            // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
                            DataCell(Text(coursename)),
                            DataCell(Text(venue)),
                            DataCell(Text(status)),
                            DataCell(Text(latein)),
                            DataCell(Text(leftearly)),
                            
                          ]);
                        }),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}


class TaskCHRTable
{
  late int chrid;
  late String name;
  late String intime;
  late String outime;
  late String indate;
  late String dayy;
  late String sectionname;
  late String coursename;
  late String venue;
  late String status;
  late double latein;
  late double leftearly;
  late String stime;
  late String etime;
  
  
  TaskCHRTable({
    required this.chrid,
    required this.name,
    required this.intime,
    required this.outime,
    required this.indate,
    required this.dayy,
    required this.sectionname,
    required this.coursename,
    required this.venue,
    required this.status,
    required this.latein,
    required this.leftearly,
    required this.stime,
    required this.etime,
    });

  factory TaskCHRTable.fromJson(Map<String,dynamic>json)
  {
    return TaskCHRTable(
      chrid:json['chrid'],
      name:json['name'],
      intime:json['intime'],
      outime:json['outime'],
      indate:json['indate'],
      dayy:json['dayy'],
      sectionname:json['sectionname'],
      coursename:json['coursename'],
      venue:json['venue'],
      status: json['status'],
      latein: json['latein'],
      leftearly: json['leftearly'],
      stime:json['stime'],
      etime:json['etime'],
    );
  }
}