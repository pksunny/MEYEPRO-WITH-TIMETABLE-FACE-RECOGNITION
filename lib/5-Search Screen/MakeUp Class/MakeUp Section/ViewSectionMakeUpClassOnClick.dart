// ---->>>> WITHOUT DATATABLE CHECKBOX <<<<---- //

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/SectionMakeupOnClick_CheckBox.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick_CheckBox.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class ViewSectionMakeUpClassOnClick extends StatefulWidget {
  const ViewSectionMakeUpClassOnClick({ Key? key, required this.overall,required this.sectiontimetable }) : super(key: key);

  final MakeUpClass overall;
  final List<MakeUpClass> sectiontimetable;
  // SectionOnClickPage(this._overall);
  // final String sectionname;

  @override
  State<ViewSectionMakeUpClassOnClick> createState() => _ViewSectionMakeUpClassOnClickState();
}

class _ViewSectionMakeUpClassOnClickState extends State<ViewSectionMakeUpClassOnClick> {

  // -->> SELECTED SECTIONS <<-- //
  List<MakeUpClass> selectedSections = [];
  late MakeUpClass timeTable;

  // DELETE FUNCTION //
  Future<MakeUpClass> deleteMakeUpClass(String mcid) async {
    final http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'meyepro/api/MakeUpClass/deleteMakeUpClass?mcid='+mcid),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

   // var responsed = await http.Response.fromStream(response);
    // ignore: unused_local_variable
    final respnse = json.decode(response.body);


    print(mcid);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted!"),));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTeacherMakeUpClass()));
      print('SuccessFull Deleted');

      setState(() {
        
      });

      return MakeUpClass.fromJson(jsonDecode(response.body));
    } else {

      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete');
    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.overall.sectionname),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Section: '+'${widget.overall.sectionname.toString()}',style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
          
                Container(
                  padding: EdgeInsets.all(15),
                  child: Expanded(
                          
                    // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
                          
                    child: DataTable(
                      columnSpacing: 38.0,
                      border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
                      columns: [
                        DataColumn(label: Text('Section: ${widget.overall.sectionname}')),
                        DataColumn(label: Text('mcid')),
                        DataColumn(label: Text('Day')),
                        DataColumn(label: Text('Teacher')),
                        DataColumn(label: Text('Course')),
                        DataColumn(label: Text('Venue')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('First Ten Min')),
                        DataColumn(label: Text('Middle Ten Min')),
                        DataColumn(label: Text('Last Ten Min')),
                        DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Delete')),
                      ],
                      rows: List.generate(widget.sectiontimetable.length, (index) {
                        final sectionname = widget.sectiontimetable[index].sectionname.toString();
                        final tid = widget.sectiontimetable[index].mcid.toString();
                        final day = widget.sectiontimetable[index].dayy.toString();
                        final teacher = widget.sectiontimetable[index].teachername.toString();
                        final subject = widget.sectiontimetable[index].coursename.toString();
                        final venue = widget.sectiontimetable[index].venue.toString();
                        final time = widget.sectiontimetable[index].stime.toString() + ' - ' + widget.sectiontimetable[index].etime.toString();
                        final ftenm = widget.sectiontimetable[index].ftenm.toString();
                        final mtenm = widget.sectiontimetable[index].mtenm.toString();
                        final ltenm = widget.sectiontimetable[index].ltenm.toString();
                        final delete = widget.sectiontimetable[index].mcid.toString();
                  
                        return DataRow(
                          // selected: selectedSections.contains(widget.overall),
                          // onSelectChanged: (isSelected) {
                          //   setState(() {
                          //     final isAdding = isSelected != null && isSelected;
                
                          //     isAdding ? selectedSections.add(widget.overall) : selectedSections.remove(widget.overall);
                          //   });
                          // },
                          cells: [
                          // DataCell(Container(child: Text('8:30 - 10:30'))),
                          DataCell(Text('')),
                          DataCell(Text(tid)),
                          DataCell(Text(day),),
                          DataCell(Text(teacher)),
                          DataCell(Text(subject)),
                          DataCell(Text(venue)),
                          DataCell(Text(time)),
                          DataCell(Text(ftenm)),
                          DataCell(Text(mtenm)),
                          DataCell(Text(ltenm)),
                          DataCell(
                            Icon(Icons.edit_outlined, color: Colors.blue,),
                            onTap: (){
                            int mcid=widget.sectiontimetable[index].mcid;
                      
                            List<MakeUpClass> mcidData=[];
                            for(int i=0;i<widget.sectiontimetable.length;i++)
                            {
                              if(widget.sectiontimetable[i].mcid==mcid)
                                mcidData.add(widget.sectiontimetable[i]);
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SectionMakeUpOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: mcidData)));
                          }
                          ),
                          DataCell(
                            Icon(Icons.delete_forever_rounded, color: Colors.redAccent,),
                            onTap: (){
                              deleteMakeUpClass(widget.sectiontimetable[index].mcid.toString());
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
    );
  } 
}