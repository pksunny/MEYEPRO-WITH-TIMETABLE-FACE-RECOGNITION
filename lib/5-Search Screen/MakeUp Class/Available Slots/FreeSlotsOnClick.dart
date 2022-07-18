
// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlots.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlotsOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/TeacherOnClick.dart';
import 'package:queries/collections.dart';
import 'package:darq/darq.dart';

import '../../../main.dart';


class FreeSlotsOnClick extends StatefulWidget {
  const FreeSlotsOnClick({Key? key}) : super(key: key);

  @override
  _FreeSlotsOnClickState createState() => _FreeSlotsOnClickState();
}

class _FreeSlotsOnClickState extends State<FreeSlotsOnClick> {
  // FOR TEXT STYLE
  var textstyle = TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));
  // FOR SEARCH ANIMATION
  bool _folded = true;
  // FOR TEXT EDITING CONTROLLER
  TextEditingController? _textEditingController = TextEditingController(); 

  // FOR LOAD DATA ON SCREEN SHOW //
  void initState(){
   super.initState();
    ShowFreeSlots();
  }


  // FOR HANDLE SECTION SEARCH RESULT
  List<TimeTable> sectionListOnSearch = [];
  // FETCH TEACHER FROM API //
  List<TimeTable> sectionTable=[];
  // DISTICT LIST //

  Future<void> ShowFreeSlots() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/TimeTable/FetchVaccantClasses?tname=" +
            teachername1.toString() +
            "&classname=" +
            sectionname1.toString())
            );
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

  @override
  Widget build(BuildContext context) {

    // var seen = Set<String>();
    // List<TimeTable> uniquelist = sectionTable.where((s) => seen.add(s.sectionname)).toList();

    return Scaffold(
      appBar : AppBar(
        title: Text('Search'),
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

        // actions: [
        //     PopupMenuButton(
        //         itemBuilder: (context) => [
        //           PopupMenuItem(
        //             child: InkWell(
        //               onTap: (){
        //                 Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        //               },
        //               child: Text("Teacher Search")
        //               ),
        //             value: 1,
        //           ),
        //           PopupMenuItem(
        //             child: InkWell(
        //               onTap: (){
        //                 Navigator.push(context, MaterialPageRoute(builder: (context) => SectionSearchScreen()));
        //               },
        //               child: Text("Section Search")
        //               ),
        //             value: 2,
        //           )
        //         ]
        //     )
        //   ],

      ),


      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.note_add_rounded, title: 'Add MakeUp Class'),
          // TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.home, title: 'Home'),
          // TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.view_array_rounded, title: 'View MakeUp'),
        ],
        initialActiveIndex: 1, //optional, default as 0
        elevation: 10,
        onTap: (int i) {
          if(i == 0)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMakeUpClass()));
          }
          else if(i == 1)
          {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
          else if(i == 2)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewSectionMakeUpClass()));
          }
        }
      ),

      body: RefreshIndicator(
        onRefresh: ShowFreeSlots,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 15,),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: _folded ? 56 : 300,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child: !_folded ? TextField(
                            onChanged: (value){
                              setState(() {
                                sectionListOnSearch = sectionTable.where((element) => 
                                  element.sectionname.toLowerCase().contains(value.toLowerCase()) ||
                                  element.teachername.toLowerCase().contains(value.toLowerCase()) ||
                                  element.sectionname.toLowerCase().contains(value.toLowerCase()) ||
                                  element.dayy.toLowerCase().contains(value.toLowerCase()) ||
                                  element.venue.toLowerCase().contains(value.toLowerCase()) ||
                                  element.stime.toLowerCase().contains(value.toLowerCase())
                                
                                ).toList();
                              });
                            },
      
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Search Section',
                              hintStyle: TextStyle(color: Colors.blue),
                              border: InputBorder.none,
                            ),
                          ) : null,
                        ),
                      ),
      
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: Material(
                          type:  MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: Radius.circular(32),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                _folded ? Icons.search : Icons.close,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                _folded = !_folded;
                                sectionListOnSearch.clear();
                                _textEditingController!.clear();
                                _textEditingController!.text = '';
                              });
                            },
                          ),
                        ),
                      ),
      
                      // LIST VIEW FOR SEARCH
                    ],
                  ),
                ),
      
                Expanded(
                  child: _textEditingController!.text.isNotEmpty && sectionListOnSearch.isEmpty?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,size: 50,color: Colors.blue,),
                        Text('No Result Found',style: textstyle,),
                      ],
                    ),
                  ) :
                  ListView.builder(
                  itemCount: _textEditingController!.text.isNotEmpty ? sectionListOnSearch.length : sectionTable.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(sectionTable[index].venue),
                          subtitle: Text(sectionTable[index].dayy + '   ' + sectionTable[index].stime),
                        )
                        ),
                      // onTap: (){
                      //   String sectionname=sectionTable[index].sectionname;
                        
                      //   List<TimeTable> data=[];
                      //   for(int i=0;i<sectionTable.length;i++)
                      //   {
                      //     if(sectionTable[i].sectionname==sectionname)
                      //     data.add(sectionTable[i]);
                      //   }
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => SectionOnClick(overall: sectionTable[index],sectiontimetable:data,)));
                      //   },
                    ); 
                  },
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ----------> USING TIMETABLE SEARCH AVAILABLE SLOTS <--------------------- //

// // ignore_for_file: prefer_const_constructors

// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
// import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';

// import '../../../main.dart';

// class AvailableSlots extends StatefulWidget {
//   const AvailableSlots({Key? key}) : super(key: key);

//   @override
//   State<AvailableSlots> createState() => _AvailableSlotsState();
// }

// class _AvailableSlotsState extends State<AvailableSlots> {

//   void initState() {
//       super.initState();
//       ShowAllTeachers();
//     }

//     List<TimeTable> teacherTable = [];

//     Future<void> ShowAllTeachers() async{
//     var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/getTimeTable'));
//     if(response.statusCode==200)
//     {
//       //return json.decode(response.body)['response'];
//       print("Successfull Show Record");
//       //print(response.body);

//       Iterable listt = jsonDecode(response.body);
//       teacherTable = listt.map((e) => TimeTable.fromJson(e)).toList();
//       // final uniqueJsonList = sectionTable.toSet().toList();
//       setState(() {

//       });
//       //var res=json.decode(response.body);
//       //return res.map<student>((json)=>student.fromJson(json)).toList();
//     }
//     else
//       throw Exception('Failed to load data');

//   }

//   bool val1 = false;

//   var stime = '08:30:00',etime='10:00:00';

//   var cardtextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 20,color: Color.fromRGBO(63, 63, 63, 1));
//   var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

//   List<TimeTable> timelist = [];

//   // FOR SEARCH ANIMATION
//   bool _folded = true;
//   // FOR TEXT EDITING CONTROLLER
//   TextEditingController? _textEditingController = TextEditingController(); 

//   List<TimeTable> ListOnSearch = [];

//   // BOTTOM NAV BAR CODE //
//   int selectedindex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       selectedindex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     timelist = teacherTable.where((element) => (element.stime == stime && element.etime == etime)).toList();

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Slots'),
//       ),

//       bottomNavigationBar: SafeArea(
//          child: ConvexAppBar(
//           items: [
//             TabItem(icon: Icons.note_add_rounded, title: 'Add MakeUp Class',),
//           ],
//           initialActiveIndex: 0, //optional, default as 0
//           elevation: 10,
//           onTap: (int i) {
//             if(i == 0)
//             {
//               Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMakeUpClass()));
//             }
//           }
//              ),
//        ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Column(
//               children: [
                
//                 // Container(
//                 //   margin: EdgeInsets.symmetric(horizontal: 50),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //     children: [
//                 //       Text(
//                 //         "Time 08:30-10:00",
//                 //         style: cardtextstyle,
//                 //       ),
//                 //       Checkbox(
//                 //         value: this.val1,
//                 //         onChanged: (bool? value) {
//                 //           setState(() {
//                 //             this.val1 = value!;
//                 //           });
//                 //         },
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),

//                 SizedBox(height: 15,),
//                 Text('Please Check out the Free Slots and Than Add MakeUp Class!',style: cardtextstyle,),
          
//                 SizedBox(height: 15,),
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 400),
//                     width: _folded ? 56 : 300,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(32),
//                       color: Colors.white,
//                       boxShadow: kElevationToShadow[6],
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.only(left: 16),
//                             child: !_folded ? TextField(
//                               onChanged: (value){
//                                 setState(() {
//                                   ListOnSearch = teacherTable.where((element) => 
//                                     (
//                                       element.teachername.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.dayy.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.coursename.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.sectionname.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.venue.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.stime.toLowerCase().contains(value.toLowerCase()) ||
//                                       element.etime.toLowerCase().contains(value.toLowerCase()) 
//                                     )
//                                     ).toList();
//                                 });
//                               },
                
//                               controller: _textEditingController,
//                               decoration: InputDecoration(
//                                 hintText: 'Search From TimeTable',
//                                 hintStyle: TextStyle(color: Colors.blue),
//                                 border: InputBorder.none,
//                               ),
//                             ) : null,
//                           ),
//                         ),
                
//                         AnimatedContainer(
//                           duration: Duration(milliseconds: 400),
//                           child: Material(
//                             type:  MaterialType.transparency,
//                             child: InkWell(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(_folded ? 32 : 0),
//                                 topRight: Radius.circular(32),
//                                 bottomLeft: Radius.circular(_folded ? 32 : 0),
//                                 bottomRight: Radius.circular(32),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(16.0),
//                                 child: Icon(
//                                   _folded ? Icons.search : Icons.close,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               onTap: (){
//                                 setState(() {
//                                   _folded = !_folded;
//                                   ListOnSearch.clear();
//                                   _textEditingController!.clear();
//                                   _textEditingController!.text = '';
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
                
//                         // LIST VIEW FOR SEARCH
//                       ],
//                     ),
//                   ),
          
//                   SizedBox(height: 25,),
//                   Container(
//                     child: _textEditingController!.text.isNotEmpty &&
//                             ListOnSearch.isEmpty
//                         ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.search_off,
//                                   size: 50,
//                                   color: Colors.blue,
//                                 ),
//                                 Text(
//                                   'No Result Found',
//                                   style: cardtextstyle,
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(
//                             padding: EdgeInsets.all(15),
//                             child: Expanded(
//                               // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
          
//                               child: DataTable(
//                                 columnSpacing: 38.0,
//                                 border: TableBorder.all(
//                                     color: Colors.blue,
//                                     borderRadius: BorderRadius.circular(10),
//                                     width: 3),
//                                 columns: [
//                                   DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('tid',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Day',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Time',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('First Ten Min',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Middle Ten Min',style: cardtextstyle2,)),
//                                   DataColumn(label: Text('Last Ten Min',style: cardtextstyle2,)),
//                                 ],
//                                 rows: List.generate(_textEditingController!.text.isNotEmpty ? ListOnSearch.length : teacherTable.length, (index) {
//                                   final sectionname = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].sectionname : teacherTable[index].sectionname;
//                                   final tid = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].tid.toString() : teacherTable[index].tid.toString();
//                                   final day = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].dayy : teacherTable[index].dayy.toString();
//                                   final teacher =  _textEditingController!.text.isNotEmpty ? ListOnSearch[index].teachername : teacherTable[index].teachername.toString();
//                                   final subject = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].coursename : teacherTable[index].coursename.toString();
//                                   final venue = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].venue : teacherTable[index].venue.toString();
//                                   final time = (_textEditingController!.text.isNotEmpty ? ListOnSearch[index].stime : teacherTable[index].stime.toString()) +
//                                                ' - ' + 
//                                                (_textEditingController!.text.isNotEmpty ? ListOnSearch[index].etime : teacherTable[index].etime.toString());
//                                   final ftenm =
//                                       teacherTable[index].ftenm.toString();
//                                   final mtenm =
//                                       teacherTable[index].mtenm.toString();
//                                   final ltenm =
//                                       teacherTable[index].ltenm.toString();
//                                   return DataRow(cells: [
//                                     // DataCell(Container(child: Text('8:30 - 10:30'))),
//                                     DataCell(Text(sectionname)),
//                                     DataCell(Text(tid)),
//                                     DataCell(Text(day)),
//                                     DataCell(Text(teacher)),
//                                     DataCell(Text(subject)),
//                                     DataCell(Text(venue)),
//                                     DataCell(Text(time)),
//                                     DataCell(Text(ftenm)),
//                                     DataCell(Text(mtenm)),
//                                     DataCell(Text(ltenm)),
//                                   ]);
//                                 }),
//                               ),
//                             ),
//                           ))
//                   // DataTableAll(context)
//                 // DataTableTime(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget DataTableAll(context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: Expanded(
//         // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //

//         child: DataTable(
//           columnSpacing: 38.0,
//           border: TableBorder.all(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//               width: 3),
//           columns: [
//             DataColumn(label: Text('Teacher:')),
//             DataColumn(label: Text('tid')),
//             DataColumn(label: Text('Day')),
//             DataColumn(label: Text('Teacher')),
//             DataColumn(label: Text('Course')),
//             DataColumn(label: Text('Venue')),
//             DataColumn(label: Text('Time')),
//             DataColumn(label: Text('First Ten Min')),
//             DataColumn(label: Text('Middle Ten Min')),
//             DataColumn(label: Text('Last Ten Min')),
//           ],
//           rows: List.generate(teacherTable.length, (index) {
//             final sectionname = teacherTable[index].teachername.toString();
//             final tid = teacherTable[index].tid.toString();
//             final day = teacherTable[index].dayy.toString();
//             final teacher = teacherTable[index].teachername.toString();
//             final subject = teacherTable[index].coursename.toString();
//             final venue = teacherTable[index].venue.toString();
//             final time = teacherTable[index].stime.toString() +
//                 ' - ' +
//                 teacherTable[index].etime.toString();
//             final ftenm = teacherTable[index].ftenm.toString();
//             final mtenm = teacherTable[index].mtenm.toString();
//             final ltenm = teacherTable[index].ltenm.toString();
//             return DataRow(cells: [
//               // DataCell(Container(child: Text('8:30 - 10:30'))),
//               DataCell(Text('')),
//               DataCell(
//                 Text(tid),
//                 //   onTap: (){
//                 //   int mcid=widget.sectiontimetable[index].mcid;

//                 //   List<MakeUpClass> mcidData=[];
//                 //   for(int i=0;i<widget.sectiontimetable.length;i++)
//                 //   {
//                 //     if(widget.sectiontimetable[i].mcid==mcid)
//                 //       mcidData.add(widget.sectiontimetable[i]);
//                 //   }
//                 //   Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherMakeUpOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: mcidData)));
//                 // }
//               ),
//               DataCell(
//                 Text(day),
//                 // onTap: () {
//                 //   String mcid=widget.sectiontimetable[index].mcid.toString();

//                 //   List<MakeUpClass> mcidData=[];
//                 //   for(int i=0;i<widget.sectiontimetable.length;i++)
//                 //   {
//                 //     if(widget.sectiontimetable[i].mcid==mcid)
//                 //     mcidData.add(widget.sectiontimetable[i]);
//                 //   }
//                 //   Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherMakeUpOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: mcidData )));
//                 // }
//               ),
//               DataCell(Text(teacher)),
//               DataCell(Text(subject)),
//               DataCell(Text(venue)),
//               DataCell(Text(time)),
//               DataCell(Text(ftenm)),
//               DataCell(Text(mtenm)),
//               DataCell(Text(ltenm)),
//             ]);
//           }),
//         ),
//       ),
//     );
//   }

//   Widget DataTableTime(context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: Expanded(
//         // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //

//         child: DataTable(
//           columnSpacing: 38.0,
//           border: TableBorder.all(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//               width: 3),
//           columns: [
//             DataColumn(label: Text('Teacher:')),
//             DataColumn(label: Text('tid')),
//             DataColumn(label: Text('Day')),
//             DataColumn(label: Text('Teacher')),
//             DataColumn(label: Text('Course')),
//             DataColumn(label: Text('Venue')),
//             DataColumn(label: Text('Time')),
//             DataColumn(label: Text('First Ten Min')),
//             DataColumn(label: Text('Middle Ten Min')),
//             DataColumn(label: Text('Last Ten Min')),
//           ],
//           rows: List.generate(timelist.length, (index) {
//             final sectionname = timelist[index].teachername.toString();
//             final tid = timelist[index].tid.toString();
//             final day = timelist[index].dayy.toString();
//             final teacher = timelist[index].teachername.toString();
//             final subject = timelist[index].coursename.toString();
//             final venue = timelist[index].venue.toString();
//             final time = timelist[index].stime.toString() +
//                 ' - ' +
//                 timelist[index].etime.toString();
//             final ftenm = timelist[index].ftenm.toString();
//             final mtenm = timelist[index].mtenm.toString();
//             final ltenm = timelist[index].ltenm.toString();
//             return DataRow(cells: [
//               // DataCell(Container(child: Text('8:30 - 10:30'))),
//               DataCell(Text('')),
//               DataCell(
//                 Text(tid),
//                 //   onTap: (){
//                 //   int mcid=widget.sectiontimetable[index].mcid;

//                 //   List<MakeUpClass> mcidData=[];
//                 //   for(int i=0;i<widget.sectiontimetable.length;i++)
//                 //   {
//                 //     if(widget.sectiontimetable[i].mcid==mcid)
//                 //       mcidData.add(widget.sectiontimetable[i]);
//                 //   }
//                 //   Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherMakeUpOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: mcidData)));
//                 // }
//               ),
//               DataCell(
//                 Text(day),
//                 // onTap: () {
//                 //   String mcid=widget.sectiontimetable[index].mcid.toString();

//                 //   List<MakeUpClass> mcidData=[];
//                 //   for(int i=0;i<widget.sectiontimetable.length;i++)
//                 //   {
//                 //     if(widget.sectiontimetable[i].mcid==mcid)
//                 //     mcidData.add(widget.sectiontimetable[i]);
//                 //   }
//                 //   Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherMakeUpOnClickCheckBox(selectedOverall: widget.sectiontimetable[index], selectedTimeTable: mcidData )));
//                 // }
//               ),
//               DataCell(Text(teacher)),
//               DataCell(Text(subject)),
//               DataCell(Text(venue)),
//               DataCell(Text(time)),
//               DataCell(Text(ftenm)),
//               DataCell(Text(mtenm)),
//               DataCell(Text(ltenm)),
//             ]);
//           }),
//         ),
//       ),
//     );
//   }
// }