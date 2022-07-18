// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:convert';
// import 'dart:ui';

// import 'package:http/http.dart' as http;
// import 'package:m_eye_gui/5-Search%20Screen/SearchScreen.dart';

// class TimeTableScreen extends StatefulWidget {
//   const TimeTableScreen({ Key? key }) : super(key: key);

//   @override
//   State<TimeTableScreen> createState() => _TimeTableScreenState();
// }

// class _TimeTableScreenState extends State<TimeTableScreen> {

//   void initState(){
//    super.initState();
//     ShowTimeTable();
//   }

//   List<TimeTableOneCopyTable> timeTable=[];

//   Future<void> ShowTimeTable() async{
//     var response=await http.get(Uri.parse('http://192.168.56.1/meyepro/api/TimeTableOneCopy/getAll'));
//     if(response.statusCode==200)
//     {
//       //return json.decode(response.body)['response'];
//       print("Successfull Show Record");
//       //print(response.body);

//       Iterable listt = jsonDecode(response.body);
//       timeTable=listt.map((e) => TimeTableOneCopyTable.fromJson(e)).toList();
//       setState(() {

//       });
//       //var res=json.decode(response.body);
//       //return res.map<student>((json)=>student.fromJson(json)).toList();
//     }
//     else
//       throw Exception('Failed to load data');

//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Time Table'),
//         ),

//     body: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Container(
//         child: Column(
//           children: [
//             SizedBox(height: 20,),
//             Text('MR UNKNOWN',style: TextStyle(fontSize: 20),),
//             SizedBox(height: 20,),
      
//             Padding(
//             padding: EdgeInsets.all(10),
//             child: Expanded(
      
//               // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
      
//               child: DataTable(
//                 columnSpacing: 38.0,
//                 border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
//                 columns: [
//                   DataColumn(label: Text('Time Table: BCS_1A')),
//                   DataColumn(label: Text('Monday')),
//                   DataColumn(label: Text('Tuesday')),
//                   // DataColumn(label: Text('Wednesday')),
//                   // DataColumn(label: Text('Thursday')),
//                   // DataColumn(label: Text('Friday')),
//                 ],
//                 rows: List.generate(timeTable.length, (index) {
//                   final _cid = timeTable[index].coursename.toString() + '_(${timeTable[index].teachername.toString()})';
//                   final _cname = timeTable[index].coursename.toString() + '_(${timeTable[index].teachername.toString()})';
//                   // final _sid = timeTable[index].sid.toString();
//                   // final _sname = timeTable[index].sname.toString();
//                   // final _ctid = timeTable[index].ctid.toString();
//                   // final _ctname = timeTable[index].ctname.toString();
            
//                   return DataRow(cells: [
//                     DataCell(Container(child: Text('8:30 - 10:30'))),
//                     DataCell(Container(child: Text(_cid))),
//                     DataCell(Container(child: Text(_cname))),
//                     // DataCell(Container(child: Text(_sid))),
//                     // DataCell(Container(child: Text(_sname))),
//                     // DataCell(Container(child: Text(_ctid))),
//                     // DataCell(Container(child: Text(_ctname))),
//                   ]);
//                 }),
//               ),
//             ),
//           ),
//           ], 
//         ),
//       ),
//     ),
//       )
//     );
//   }
// }



