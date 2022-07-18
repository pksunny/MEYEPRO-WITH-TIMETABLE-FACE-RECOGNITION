// ---->>>> WITHOUT DATATABLE CHECKBOX <<<<---- //

import 'package:flutter/material.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick_CheckBox.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/TeacherSelectedOnClick_CheckBox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class TeacherOnClick extends StatefulWidget {
  const TeacherOnClick({ Key? key, required this.overall,required this.teachertimetable }) : super(key: key);

  final TimeTable overall;
  final List<TimeTable> teachertimetable;
  // SectionOnClickPage(this._overall);
  // final String sectionname;

  @override
  State<TeacherOnClick> createState() => _TeacherOnClickState();
}

class _TeacherOnClickState extends State<TeacherOnClick> {

  // -->> SELECTED SECTIONS <<-- //
  List<TimeTable> selectedSections = [];
  late TimeTable timeTable;

  @override
  Widget build(BuildContext context) { 

    List<TimeTable> sectionTable = [];

    Future<void> ShowAllTeachers() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/getTimeTable'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      sectionTable = listt.map((e) => TimeTable.fromJson(e)).toList();
      // final uniqueJsonList = sectionTable.toSet().toList();
      setState(() {
         
      });
      //var res=json.decode(response.body);
      //return res.map<student>((json)=>student.fromJson(json)).toList();
    }
    else
      throw Exception('Failed to load data');

  }


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.overall.teachername),
      ),

      // bottomNavigationBar: SafeArea(
      //     child: Container(
      //           width: double.infinity,
      //           padding: EdgeInsets.all(12),
      //           // color: Colors.black,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               shape: StadiumBorder(),
      //               minimumSize: Size.fromHeight(40),
      //             ),
      //             child: Text('Select ${selectedSections.length} Records'),
      //             onPressed: (){
      //               // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedOnClick(selectedOverall: selectedSections.toSt, selectedTimeTable: selectedTimeTable)));
      //             },
      //           ),
      //         )
      //   ),

      body: RefreshIndicator(
        onRefresh: ShowAllTeachers,
        child: SafeArea(
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Teacher: '+'${widget.overall.teachername.toString()}',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
            
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Expanded(
                            
                      // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
                            
                      child: DataTable(
                        columnSpacing: 38.0,
                        border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
                        columns: [
                          DataColumn(label: Text('Teacher: ${widget.overall.teachername}')),
                          // DataColumn(label: Text('Tid')),
                          DataColumn(label: Text('Day', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Section', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Course', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Venue', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Time', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('First Ten Min', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Middle Ten Min', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Last Ten Min', style: TxtStyle.cardtextstyle2,)),
                          DataColumn(label: Text('Edit', style: TxtStyle.editTextStyle,)),
                        ],
                        rows: List.generate(widget.teachertimetable.length, (index) {
                          final teacher = widget.teachertimetable[index].teachername.toString();
                          // final tid = widget.teachertimetable[index].tid.toString();
                          final day = widget.teachertimetable[index].dayy.toString();
                          final section = widget.teachertimetable[index].sectionname.toString();
                          final subject = widget.teachertimetable[index].coursename.toString();
                          final venue = widget.teachertimetable[index].venue.toString();
                          final time = widget.teachertimetable[index].stime.toString() + ' - ' + widget.teachertimetable[index].etime.toString();
                          final ftenm = widget.teachertimetable[index].ftenm.toString();
                          final mtenm = widget.teachertimetable[index].mtenm.toString();
                          final ltenm = widget.teachertimetable[index].ltenm.toString();
                    
                          return DataRow(
                            // selected: selectedSections.contains(widget.overall),
                            // onSelectChanged: (isSelected) {
                            //   setState(() {
                            //     final isAdding = isSelected != null && isSelected;
                  
                            //     isAdding ? selectedSections.add(widget.overall) : selectedSections.remove(widget.overall);
                            //   });
                            // },
                            cells: [
                            DataCell(Text('')),
                            // DataCell(
                            //   Text(tid),
                            //   onTap: (){
                            //   int tid=widget.teachertimetable[index].tid;
                        
                            //   List<TimeTable> tidData=[];
                            //   for(int i=0;i<widget.teachertimetable.length;i++)
                            //   {
                            //     if(widget.teachertimetable[i].tid==tid)
                            //     tidData.add(widget.teachertimetable[i]);
                            //   }
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSelectedOnClickCheckBox(selectedOverall: widget.teachertimetable[index], selectedTimeTable: tidData)));
                            // }),
                            DataCell(Text(day), ),
                            DataCell(Text(section) ),
                            DataCell(Text(subject)),
                            DataCell(Text(venue)),
                            DataCell(Text(time)),
                            DataCell(Text(ftenm)),
                            DataCell(Text(mtenm)),
                            DataCell(Text(ltenm)),
                            DataCell(
                            Icon(Icons.edit_outlined, color: Colors.blue,),
                            onTap: () {
                              String tid=widget.teachertimetable[index].tid.toString();
                      
                              List<TimeTable> tidData=[];
                              for(int i=0;i<widget.teachertimetable.length;i++)
                              {
                                if(widget.teachertimetable[i].tid==tid)
                                  tidData.add(widget.teachertimetable[i]);
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSelectedOnClickCheckBox(selectedOverall: widget.teachertimetable[index], selectedTimeTable: tidData )));
                            }
                          ),
                          ]
                          );
                        }
                        
                        ),
                      ),
                    ),
                  ),
      
                  
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



