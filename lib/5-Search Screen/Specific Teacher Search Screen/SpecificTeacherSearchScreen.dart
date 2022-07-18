// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/1-Login+Signup%20Screen/Multi%20Login/AdminTeacherLoginPage.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';

import '../../../main.dart';

class SpecificTeacherSearchScreen extends StatefulWidget {
  const SpecificTeacherSearchScreen({Key? key}) : super(key: key);

  @override
  State<SpecificTeacherSearchScreen> createState() => _SpecificTeacherSearchScreenState();
}

class _SpecificTeacherSearchScreenState extends State<SpecificTeacherSearchScreen> {

  void initState() {
      super.initState();
      ShowAllTeachers();
    }

    List<TimeTable> teacherTable = [];

    Future<void> ShowAllTeachers() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/getTeacherTimeTable?teachername='+name1.toString()));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      teacherTable = listt.map((e) => TimeTable.fromJson(e)).toList();
      // final uniqueJsonList = sectionTable.toSet().toList();
      setState(() {

      });
      //var res=json.decode(response.body);
      //return res.map<student>((json)=>student.fromJson(json)).toList();
    }
    else
      throw Exception('Failed to load data');

  }

  bool val1 = false;

  var stime = '08:30:00',etime='10:00:00';

  var cardtextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 20,color: Color.fromRGBO(63, 63, 63, 1));
  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  List<TimeTable> timelist = [];

  // FOR SEARCH ANIMATION
  bool _folded = true;
  // FOR TEXT EDITING CONTROLLER
  TextEditingController? _textEditingController = TextEditingController(); 

  List<TimeTable> ListOnSearch = [];

  // BOTTOM NAV BAR CODE //
  int selectedindex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    timelist = teacherTable.where((element) => (element.stime == stime && element.etime == etime)).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name1.toString(),style: TxtStyle.appbartextstyle),
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

      // bottomNavigationBar: SafeArea(
      //    child: ConvexAppBar(
      //     items: [
      //       TabItem(icon: Icons.note_add_rounded, title: 'Add MakeUp Class',),
      //     ],
      //     initialActiveIndex: 0, //optional, default as 0
      //     elevation: 10,
      //     onTap: (int i) {
      //       if(i == 0)
      //       {
      //         Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMakeUpClass()));
      //       }
      //     }
      //        ),
      //  ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 50),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Time 08:30-10:00",
                //         style: cardtextstyle,
                //       ),
                //       Checkbox(
                //         value: this.val1,
                //         onChanged: (bool? value) {
                //           setState(() {
                //             this.val1 = value!;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),

                // SizedBox(height: 15,),
                // Text('Please Check out the Free Slots and Than Add MakeUp Class!',style: cardtextstyle,),
          
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
                                  ListOnSearch = teacherTable.where((element) => 
                                    (
                                      element.teachername.toLowerCase().contains(value.toLowerCase()) ||
                                      element.dayy.toLowerCase().contains(value.toLowerCase()) ||
                                      element.coursename.toLowerCase().contains(value.toLowerCase()) ||
                                      element.sectionname.toLowerCase().contains(value.toLowerCase()) ||
                                      element.venue.toLowerCase().contains(value.toLowerCase()) ||
                                      element.stime.toLowerCase().contains(value.toLowerCase()) ||
                                      element.etime.toLowerCase().contains(value.toLowerCase()) 
                                    )
                                    ).toList();
                                });
                              },
                
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Search From TimeTable',
                                hintStyle: TxtStyle.editTextStyle,
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
                                  ListOnSearch.clear();
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
          
                  SizedBox(height: 25,),
                  Container(
                    child: _textEditingController!.text.isNotEmpty &&
                            ListOnSearch.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'No Result Found',
                                  style: cardtextstyle,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(15),
                            child: Expanded(
                              // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
          
                              child: DataTable(
                                columnSpacing: 38.0,
                                border: TableBorder.all(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    width: 3),
                                columns: [
                                  DataColumn(label: Text('Section',style: cardtextstyle2,)),
                                  // DataColumn(label: Text('tid',style: cardtextstyle2,)),
                                  DataColumn(label: Text('Day',style: cardtextstyle2,)),
                                  DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
                                  DataColumn(label: Text('Course',style: cardtextstyle2,)),
                                  DataColumn(label: Text('Venue',style: cardtextstyle2,)),
                                  DataColumn(label: Text('Time',style: cardtextstyle2,)),
                                  // DataColumn(label: Text('First Ten Min',style: cardtextstyle2,)),
                                  // DataColumn(label: Text('Middle Ten Min',style: cardtextstyle2,)),
                                  // DataColumn(label: Text('Last Ten Min',style: cardtextstyle2,)),
                                ],
                                rows: List.generate(_textEditingController!.text.isNotEmpty ? ListOnSearch.length : teacherTable.length, (index) {
                                  final sectionname = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].sectionname : teacherTable[index].sectionname;
                                  // final tid = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].tid.toString() : teacherTable[index].tid.toString();
                                  final day = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].dayy : teacherTable[index].dayy.toString();
                                  final teacher =  _textEditingController!.text.isNotEmpty ? ListOnSearch[index].teachername : teacherTable[index].teachername.toString();
                                  final subject = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].coursename : teacherTable[index].coursename.toString();
                                  final venue = _textEditingController!.text.isNotEmpty ? ListOnSearch[index].venue : teacherTable[index].venue.toString();
                                  final time = (_textEditingController!.text.isNotEmpty ? ListOnSearch[index].stime : teacherTable[index].stime.toString()) +
                                               ' - ' + 
                                               (_textEditingController!.text.isNotEmpty ? ListOnSearch[index].etime : teacherTable[index].etime.toString());
                                  // final ftenm = teacherTable[index].ftenm.toString();
                                  // final mtenm =  teacherTable[index].mtenm.toString();
                                  // final ltenm = teacherTable[index].ltenm.toString();
                                  return DataRow(cells: [
                                    // DataCell(Container(child: Text('8:30 - 10:30'))),
                                    DataCell(Text(sectionname)),
                                    // DataCell(Text(tid)),
                                    DataCell(Text(day)),
                                    DataCell(Text(teacher)),
                                    DataCell(Text(subject)),
                                    DataCell(Text(venue)),
                                    DataCell(Text(time)),
                                    // DataCell(Text(ftenm)),
                                    // DataCell(Text(mtenm)),
                                    // DataCell(Text(ltenm)),
                                  ]);
                                }),
                              ),
                            ),
                          ))
                  // DataTableAll(context)
                // DataTableTime(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}