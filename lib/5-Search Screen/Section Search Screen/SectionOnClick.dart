// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/5-Search%20Screen/SearchScreen.dart';
// import 'package:m_eye_gui/5-Search%20Screen/SectionSearchScreen.dart';
// import 'package:m_eye_gui/5-Search%20Screen/SelectedOnClick.dart';
// import 'package:m_eye_gui/5-Search%20Screen/TimeTable/SectionSearchPage.dart';

// class SectionOnClick extends StatefulWidget {
//   const SectionOnClick({ Key? key, required this.overall,required this.sectiontimetable }) : super(key: key);

//   final TimeTable overall;
//   final List<TimeTable> sectiontimetable;
//   // SectionOnClickPage(this._overall);
//   // final String sectionname;

//   @override
//   State<SectionOnClick> createState() => _SectionOnClickState();
// }

// class _SectionOnClickState extends State<SectionOnClick> {

//   // -->> SELECTED SECTIONS <<-- //
//   List<TimeTable> selectedSections = [];
//   late TimeTable timeTable;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.overall.sectionname),
//       ),

//       bottomNavigationBar: SafeArea(
//           child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(12),
//                 // color: Colors.black,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: StadiumBorder(),
//                     minimumSize: Size.fromHeight(40),
//                   ),
//                   child: Text('Select ${selectedSections.length} Records'),
//                   onPressed: (){
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedOnClick(selectedOverall: selectedSections.toSt, selectedTimeTable: selectedTimeTable)));
//                   },
//                 ),
//               )
//         ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Text('SECTION: '+'${widget.overall.sectionname.toString()}',style: TextStyle(fontSize: 20),),
//                 SizedBox(height: 20,),

//                 Container(
//                   padding: EdgeInsets.all(15),
//                   child: Expanded(

//                     // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //

//                     child: DataTable(

//                       onSelectAll: (isSelectedAll){

//                         setState(() {
//                           selectedSections = isSelectedAll! ? widget.sectiontimetable : [];

//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Selected: $isSelectedAll")));
//                         });
//                       },

//                       columnSpacing: 38.0,
//                       border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
//                       columns: [
//                         DataColumn(label: Text('Section: ${widget.overall.sectionname}')),
//                         DataColumn(label: Text('Tid')),
//                         DataColumn(label: Text('Day')),
//                         DataColumn(label: Text('Teacher')),
//                         DataColumn(label: Text('Course')),
//                         DataColumn(label: Text('Venue')),
//                         DataColumn(label: Text('Time')),
//                       ],
//                       rows: List.generate(widget.sectiontimetable.length, (index) {
//                         final sectionname = widget.sectiontimetable[index].sectionname.toString();
//                         final tid = widget.sectiontimetable[index].tid.toString();
//                         final day = widget.sectiontimetable[index].dayy.toString();
//                         final teacher = widget.sectiontimetable[index].teachername.toString();
//                         final subject = widget.sectiontimetable[index].coursename.toString();
//                         final venue = widget.sectiontimetable[index].venue.toString();
//                         final time = widget.sectiontimetable[index].stime.toString() + ' - ' + widget.sectiontimetable[index].etime.toString();
//                         print(index);
//                         // print(sectionname);
//                         // print(day);
//                         // print(teacher);
//                         // print(subject);
//                         // print(venue);
//                         // print(time);
//                         // final _cid = sectionTable[index].subject.toString() + '_(${sectionTable[index].teachername.toString()})';
//                         // final _cname = sectionTable[index].subject.toString() + '_(${sectionTable[index].teachername.toString()})';
//                         // final _sid = timeTable[index].sid.toString();
//                         // final _sname = timeTable[index].sname.toString();
//                         // final _ctid = timeTable[index].ctid.toString();
//                         // final _ctname = timeTable[index].ctname.toString();

//                         return DataRow(
//                           selected: selectedSections.contains(widget.overall),
//                           onSelectChanged: (isSelected) {
//                             setState(() {
//                               final isAdding = isSelected != null && isSelected;

//                               isAdding ? selectedSections.add(widget.overall) : selectedSections.remove(widget.overall);
//                             });
//                           },
//                           cells: [
//                           // DataCell(Container(child: Text('8:30 - 10:30'))),
//                           DataCell(Container(child: Text(''))),
//                           DataCell(Container(child: Text(tid))),
//                           DataCell(Container(child: Text(day))),
//                           DataCell(Container(child: Text(teacher))),
//                           DataCell(Container(child: Text(subject))),
//                           DataCell(Container(child: Text(venue))),
//                           DataCell(Container(child: Text(time))),
//                           // DataCell(Container(child: Text(_sid))),
//                           // DataCell(Container(child: Text(_sname))),
//                           // DataCell(Container(child: Text(_ctid))),
//                           // DataCell(Container(child: Text(_ctname))),
//                         ]
//                         );
//                       }

//                       // rows: [
//                       //   DataRow(
//                       //     cells: [
//                       //       DataCell(Container(child: Text(''))),
//                       //     DataCell(Container(child: Text(_overall.day))),
//                       //     DataCell(Container(child: Text(_overall.teachername))),
//                       //     DataCell(Container(child: Text(_overall.subject))),
//                       //     DataCell(Container(child: Text(_overall.venue))),
//                       //     DataCell(Container(child: Text(_overall.time))),
//                       //     ]
//                       //   )
//                       // ],

//                       ),
//                     ),
//                   ),
//                 ),

//               ],
//             ),
//           ),
//         ),
//           ),
//       ),
//     );
//   }

//   // // --> DATA TABLE <<-- //
//   // Widget buildDataTable(){
//   //   final columns = ['Section: ${widget.overall.sectionname}','Day','Teacher','Course','Venue','Time'];

//   //   return DataTable(
//   //     columnSpacing: 38.0,
//   //     border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
//   //     columns: getColumns(columns),
//   //     rows: List.generate(widget.sectiontimetable.length, (index) {
//   //                       final sectionname = widget.sectiontimetable[index].sectionname.toString();
//   //                       final tid = widget.sectiontimetable[index].tid.toString();
//   //                       final day = widget.sectiontimetable[index].dayy.toString();
//   //                       final teacher = widget.sectiontimetable[index].teachername.toString();
//   //                       final subject = widget.sectiontimetable[index].coursename.toString();
//   //                       final venue = widget.sectiontimetable[index].venue.toString();
//   //                       final time = widget.sectiontimetable[index].stime.toString() + ' - ' + widget.sectiontimetable[index].etime.toString();
//   //                       print(index);
//   //     })
//   //     );
//   // }

//   // // --> DATA TABLE COLUMNS <<-- //
//   // List<DataColumn> getColumns(List<String> columns) => columns.map((String column) => DataColumn(label: Text(column))).toList();

//   // // --> DATA TABLE ROWS <<-- //
//   // List<DataRow> getRows(List<TimeTable> sectionTimeTable) => sectionTimeTable
//   //     .map((TimeTable tt) => DataRow(
//   //           selected: selectedSections.contains(tt),
//   //           onSelectChanged: (isSelected) => setState(() {
//   //             final isAdding = isSelected != null && isSelected;

//   //             isAdding
//   //                 ? selectedSections.add(tt)
//   //                 : selectedSections.remove(tt);
//   //           }),
//   //           cells: [
//   //             // DataCell(FlagWidget(code: country.code)),
//   //             DataCell(Container(child: Text(''))),
//   //             DataCell(Container(child: Text(tt.tid.toString()))),
//   //             DataCell(Container(child: Text(tt.dayy.toString()))),
//   //             DataCell(Container(child: Text(tt.teachername.toString()))),
//   //             DataCell(Container(child: Text(tt.coursename.toString()))),
//   //             DataCell(Container(child: Text(tt.venue.toString()))),
//   //             DataCell(Container(child: Text(tt.stime.toString() + ' - ' + tt.etime.toString()))),

//   //           ],
//   //         ))
//   //     .toList();
// }

// ---->>>> WITHOUT DATATABLE CHECKBOX <<<<---- //

import 'package:flutter/material.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SelectedOnClick_CheckBox.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/main.dart';

class SectionOnClick extends StatefulWidget {
  const SectionOnClick(
      {Key? key, required this.overall, required this.sectiontimetable})
      : super(key: key);

  final TimeTable overall;
  final List<TimeTable> sectiontimetable;
  // SectionOnClickPage(this._overall);
  // final String sectionname;

  @override
  State<SectionOnClick> createState() => _SectionOnClickState();
}

class _SectionOnClickState extends State<SectionOnClick> {
  // -->> SELECTED SECTIONS <<-- //
  List<TimeTable> selectedSections = [];
  late TimeTable timeTable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.overall.sectionname),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        // color: Colors.black,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size.fromHeight(40),
          ),
          child: Text('Select ${selectedSections.length} Records'),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedOnClick(selectedOverall: selectedSections.toSt, selectedTimeTable: selectedTimeTable)));
          },
        ),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'SECTION: ' + '${widget.overall.sectionname.toString()}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Expanded(
                      // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //

                      child: DataTable(
                        onSelectAll: (isSelectedAll) {
                          setState(() {
                            selectedSections =
                                isSelectedAll! ? widget.sectiontimetable : [];

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("All Selected: $isSelectedAll")));
                          });
                        },
                        columnSpacing: 38.0,
                        border: TableBorder.all(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            width: 3),
                        columns: [
                          DataColumn(
                              label: Text(
                                  'Section: ${widget.overall.sectionname}')),
                          // DataColumn(label: Text('Tid')),
                          DataColumn(
                              label:
                                  Text('Day', style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('Teacher',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('Course',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('Venue',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label:
                                  Text('Time', style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('First Ten Min',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('Middle Ten Min',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label: Text('Last Ten Min',
                                  style: TxtStyle.cardtextstyle2)),
                          DataColumn(
                              label:
                                  Text('Edit', style: TxtStyle.editTextStyle)),
                        ],
                        rows: List.generate(widget.sectiontimetable.length,
                            (index) {
                          final sectionname = widget
                              .sectiontimetable[index].sectionname
                              .toString();
                          // final tid = widget.sectiontimetable[index].tid.toString();
                          final day =
                              widget.sectiontimetable[index].dayy.toString();
                          final teacher = widget
                              .sectiontimetable[index].teachername
                              .toString();
                          final subject = widget
                              .sectiontimetable[index].coursename
                              .toString();
                          final venue =
                              widget.sectiontimetable[index].venue.toString();
                          final time = widget.sectiontimetable[index].stime
                                  .toString() +
                              ' - ' +
                              widget.sectiontimetable[index].etime.toString();
                          final ftenm =
                              widget.sectiontimetable[index].ftenm.toString();
                          final mtenm =
                              widget.sectiontimetable[index].mtenm.toString();
                          final ltenm =
                              widget.sectiontimetable[index].ltenm.toString();

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
                                //   int tid=widget.sectiontimetable[index].tid;

                                //   List<TimeTable> tidData=[];
                                //   for(int i=0;i<widget.sectiontimetable.length;i++)
                                //   {
                                //     if(widget.sectiontimetable[i].tid==tid)
                                //     tidData.add(widget.sectiontimetable[i]);
                                //   }
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: tidData)));
                                // }),
                                DataCell(
                                  Text(day),
                                ),
                                DataCell(
                                Text(teacher), 
                                onTap: () {
                                  String teachername= widget.overall.teachername;

                                  List<TimeTable> teacherData = [];
                                  for (int i = 0; i < widget.sectiontimetable.length;i++) 
                                  {
                                    if (widget.sectiontimetable[i].teachername == teachername)
                                      teacherData.add(widget.sectiontimetable[i]);
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllTeacherSelectedOnClickCheckBox(selectedTimeTable: teacherData)));
                                }),
                                DataCell(Text(subject)),
                                DataCell(Text(venue)),
                                DataCell(Text(time)),
                                DataCell(Text(ftenm)),
                                DataCell(Text(mtenm)),
                                DataCell(Text(ltenm)),
                                DataCell(
                                    Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                    ), onTap: () {
                                  String tid = widget
                                      .sectiontimetable[index].tid
                                      .toString();

                                  List<TimeTable> tidData = [];
                                  for (int i = 0;
                                      i < widget.sectiontimetable.length;
                                      i++) {
                                    if (widget.sectiontimetable[i].tid == tid)
                                      tidData.add(widget.sectiontimetable[i]);
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectedOnClickCheckBox(
                                                  selectedOverall: widget
                                                      .sectiontimetable[index],
                                                  selectedTimeTable: tidData)));
                                }),
                                // DataCell(Container(child: Text(_sid))),
                                // DataCell(Container(child: Text(_sname))),
                                // DataCell(Container(child: Text(_ctid))),
                                // DataCell(Container(child: Text(_ctname))),
                              ]);
                        }

                            // rows: [
                            //   DataRow(
                            //     cells: [
                            //       DataCell(Container(child: Text(''))),
                            //     DataCell(Container(child: Text(_overall.day))),
                            //     DataCell(Container(child: Text(_overall.teachername))),
                            //     DataCell(Container(child: Text(_overall.subject))),
                            //     DataCell(Container(child: Text(_overall.venue))),
                            //     DataCell(Container(child: Text(_overall.time))),
                            //     ]
                            //   )
                            // ],

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
