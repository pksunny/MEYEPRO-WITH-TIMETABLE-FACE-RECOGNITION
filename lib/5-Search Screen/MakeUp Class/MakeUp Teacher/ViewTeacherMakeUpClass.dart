// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Teacher/ViewTeacherMakeUpOnClick.dart';

import '../../../main.dart';

class ViewTeacherMakeUpClass extends StatefulWidget {
  const ViewTeacherMakeUpClass({Key? key}) : super(key: key);

  @override
  _ViewTeacherMakeUpClassState createState() => _ViewTeacherMakeUpClassState();
}

class _ViewTeacherMakeUpClassState extends State<ViewTeacherMakeUpClass> {
  // FOR TEXT STYLE
  var textstyle = TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));
  // FOR SEARCH ANIMATION
  bool _folded = true;
  // FOR TEXT EDITING CONTROLLER
  TextEditingController? _textEditingController = TextEditingController(); 

  late Timer timer;
  // FOR LOAD DATA ON SCREEN SHOW //
  void initState(){
   super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => ShowAllTeachers());
  }


  // FOR HANDLE SECTION SEARCH RESULT
  List<MakeUpClass> sectionListOnSearch = [];
  // FETCH TEACHER FROM API //
  List<MakeUpClass> sectionTable=[];
  // DISTICT LIST //

  Future<void> ShowAllTeachers() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/MakeUpClass/getMakeUpClass'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      sectionTable = listt.map((e) => MakeUpClass.fromJson(e)).toList();
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

    var seen = Set<String>();
    List<MakeUpClass> uniquelist = sectionTable.where((s) => seen.add(s.teachername)).toList();

    return Scaffold(
      appBar : AppBar(
        title: Text('Teachers'),
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
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTeacherMakeUpClass()));
                      },
                      child: Text("View Teacher")
                      ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSectionMakeUpClass()));
                      },
                      child: Text("View Section")
                      ),
                    value: 2,
                  )
                ]
            )
          ],

      ),

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
                        
                        List<MakeUpClass> data=[];
                        for(int i=0;i<sectionTable.length;i++)
                        {
                          if(sectionTable[i].teachername==teachername)
                          data.add(sectionTable[i]);
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTeacherMakeUpClassOnClick(overall: uniquelist[index],sectiontimetable:data,)));
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