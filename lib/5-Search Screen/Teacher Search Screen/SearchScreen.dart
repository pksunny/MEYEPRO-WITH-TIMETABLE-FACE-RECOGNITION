// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlots.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlotsOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/TeacherOnClick.dart';

import '../../main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // FOR TEXT STYLE
  var textstyle = TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));
  // FOR SEARCH ANIMATION
  bool _folded = true;
  // FOR TEXT EDITING CONTROLLER
  TextEditingController? _textEditingController = TextEditingController(); 

  // FOR LOAD DATA ON SCREEN SHOW //
  void initState(){
   super.initState();
    // const fiveSeconds = const Duration(seconds: 5);
    // Timer.periodic(fiveSeconds, (Timer t) => ShowAllTeachers());
    ShowAllTeachers();
  }


  // FOR HANDLE SECTION SEARCH RESULT
  List<TimeTable> sectionListOnSearch = [];
  // FETCH TEACHER FROM API //
  List<TimeTable> sectionTable=[];
  // DISTICT LIST //

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


  // Future<void> ShowOnlySections(String sname) async{
  //   var response=await http.get(Uri.parse('http://192.168.56.1/meyepro/api/TimeTableOverall/getOnlySection?sname='+sname));
  //   if(response.statusCode==200)
  //   {
  //     //return json.decode(response.body)['response'];
  //     print("Successfull Show Record");
  //     //print(response.body);

  //     Iterable listt = jsonDecode(response.body);
  //     sectionTable = listt.map((e) => TimeTableOverall.fromJson(e)).toList();
  //     // final uniqueJsonList = sectionTable.toSet().toList();
  //     setState(() {

  //     });
  //     //var res=json.decode(response.body);
  //     //return res.map<student>((json)=>student.fromJson(json)).toList();
  //   }
  //   else
  //     throw Exception('Failed to load data');

  // }

  @override
  Widget build(BuildContext context) {

    var seen = Set<String>();
    List<TimeTable> uniquelist = sectionTable.where((s) => seen.add(s.teachername)).toList();

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                          },
                          child: Text("Teacher Search")),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SectionSearchScreen()));
                          },
                          child: Text("Section Search")),
                      value: 2,
                    )
                  ])
        ],
      ),


      //  bottomNavigationBar: SafeArea(
      //    child: ConvexAppBar(
      //     items: [
      //       TabItem(icon: Icons.note_add_rounded, title: 'Add MakeUp Class'),
      //       // TabItem(icon: Icons.map, title: 'Discovery'),
      //       TabItem(icon: Icons.home, title: 'Home'),
      //       // TabItem(icon: Icons.message, title: 'Message'),
      //       TabItem(icon: Icons.view_array_rounded, title: 'View MakeUp'),
      //     ],
      //     initialActiveIndex: 1, //optional, default as 0
      //     elevation: 10,
      //     onTap: (int i) {
      //       if(i == 0)
      //       {
      //         Navigator.push(context,MaterialPageRoute(builder: (context) => const FreeSlots()));
      //       }
      //       else if(i == 1)
      //       {
      //         // Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
      //       }
      //       else if(i == 2)
      //       {
      //         Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewSectionMakeUpClass()));
      //       }
      //     }
      //        ),
      //  ),

      body: RefreshIndicator(
        onRefresh: ShowAllTeachers,
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
                                sectionListOnSearch = uniquelist.where((element) => element.teachername.toLowerCase().contains(value.toLowerCase())).toList();
                              });
                            },
      
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Search Teacher',
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
                  itemCount: _textEditingController!.text.isNotEmpty ? sectionListOnSearch.length : uniquelist.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.account_circle),
                            ),
                            SizedBox(width: 5,),
                            Text(_textEditingController!.text.isNotEmpty ? sectionListOnSearch[index].teachername : uniquelist[index].teachername,style: textstyle,),
                          ],
                        ),
                      ),
                      onTap: (){
                        String teachername=uniquelist[index].teachername;
                        
                        List<TimeTable> data=[];
                        for(int i=0;i<sectionTable.length;i++)
                        {
                          if(sectionTable[i].teachername==teachername)
                          data.add(sectionTable[i]);
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherOnClick(overall: uniquelist[index],teachertimetable:data,)));
                        },
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