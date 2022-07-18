// // ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_string_interpolations

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:project_logincheck/Global.dart';

// import 'mainviewcomplain.dart';
// import 'map.dart';
// //import 'package:viiewcomplain_api/complainview%20screen.dart';
// //import 'package:viiewcomplain_api/viewcomplain.dart';

// class viewcomplaindetail extends StatefulWidget {
//   //const SectionOnClickPage({ Key? key, required this.overall }) : super(key: key);

//   final Complian overall;
//   final List<Complain> complainList;
//   viewcomplaindetail(this.overall, this.complainList);
//   // final String sectionname;

//   @override
//   State<viewcomplaindetail> createState() => _viewcomplaindetailState();
// }

// class _viewcomplaindetailState extends State<viewcomplaindetail> {

//   var baseUrl = 'http://$ip/';
//   // FETCH TEACHER FROM API //
//   List<Complian> complainList=[];
//   Future<void> GetComplain() async{
//     var response=await http.get(Uri.parse('http://$ip/MyFirstApi/api/Complain/getImage'));
//     if(response.statusCode==200)
//     {
//       print("Successfull Show Record");

//       Iterable listt = jsonDecode(response.body);
//       complainList = listt.map((e) => Complian.fromJson(e)).toList();
//       setState(() {

//       });
//     }
//     else
//       throw Exception('Failed to load data');

//   }
//   @override
//   Widget build(BuildContext context) { 
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.overall.description.toString()),
//       ),

//       body: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               //Text('MR UNKNOWN',style: TextStyle(fontSize: 20),),
//               SizedBox(height: 20,),
        
//               Padding(
//               padding: EdgeInsets.all(10),
//               child: Expanded(
        
//                 // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
        
//                 child: DataTable(
//                   columnSpacing: 38.0,
//                   border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
//                   columns: [
//                     DataColumn(label: Text(': ${widget.overall.id}')),
//                     DataColumn(label: Text('description')),
//                     DataColumn(label: Text('type')),
//                     DataColumn(label: Text('category')),
//                     // DataColumn(label: Text('lat')),
//                     DataColumn(label: IconButton(
//                     onPressed: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
//                     }, 
//                     icon: Icon(Icons.location_pin,size: 30,)
//                     ),),
                    
//                     DataColumn(label: Text('longg')),
//                     DataColumn(label: Text('status')),
//                     DataColumn(label: Text('picture')),
//                     DataColumn(label: Text('Edit')),
                    
//                   ],
//                   rows: List.generate(1, (index) {
//                     final id = widget.overall.id.toString();
//                     final description = widget.overall.description.toString();
//                     final type = widget.overall.type.toString();
//                     final Category = widget.overall.category.toString();
//                     final lat = widget.overall.lat.toString();
//                     final latt=double.parse('$lat');
//                     final longg = widget.overall.longg.toString();
//                     final long=double.parse('$longg');
//                     final status = widget.overall.status.toString();
//                     final Picture= widget.overall.picture.toString();
//                    // final time = widget.overall.time.toString();

              
//                     return DataRow(cells: [
//                       // DataCell(Container(child: Text('8:30 - 10:30'))),
//                       DataCell(Container(child: Text(id))),
//                       DataCell(Container(child: Text(description))),
//                       DataCell(Container(child: Text(type))),
//                       DataCell(Container(child: Text(Category))),
//                       DataCell(Container(child: Text(lat))),
//                       DataCell(Container(child: Text(longg))),
//                       DataCell(Container(child: Text(status))),
//                       //DataCell(Container(child: Text(Picture))),
//                       DataCell(Container(child: 
//                       CircleAvatar(
//                               //backgroundImage: NetworkImage("http://192.168.111.157//MyFirstApi/Content/Uploads/images.jpg"),
//                               backgroundImage: NetworkImage(
//                                   'http://$ip//'+Picture
//                             ),),
//                       ),
//                       ),
//                       DataCell(
//                               Icon(Icons.edit_outlined, color: Colors.blue),
//                               onTap: (){
//                                 int id=widget.complainList[index].id.toString();
                          
//                                 List<Complain> Data=[];
//                                 for(int i=0;i<widget.complainList.length;i++)
//                                 {
//                                   if(complainList[i].id==id)
//                                   Data.add(complainList[i]);
//                                 }
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditDVRPageOnClick(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
//                               }
//                               ),
//                       // DataCell(Container(child: Text(_sid))),
//                       // DataCell(Container(child: Text(_sname))),
//                       // DataCell(Container(child: Text(_ctid))),
//                       // DataCell(Container(child: Text(_ctname))),
//                     ]);
//                   }
                  
//                   // rows: [
//                   //   DataRow(
//                   //     cells: [
//                   //       DataCell(Container(child: Text(''))),
//                   //     DataCell(Container(child: Text(_overall.day))),
//                   //     DataCell(Container(child: Text(_overall.teachername))),
//                   //     DataCell(Container(child: Text(_overall.subject))),
//                   //     DataCell(Container(child: Text(_overall.venue))),
//                   //     DataCell(Container(child: Text(_overall.time))),
//                   //     ]
//                   //   )
//                   // ],
                  
//                   ),
//                 ),
//               ),
//             ),
//             ], 
//           ),
//         ),
//       ),
//     ),
//     );
//   }
// }


// class StatusUpdate extends StatefulWidget {
//   const StatusUpdate({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

//   final Complain selectedOverall;
//   final List<Complain> selectedDVRTable;

//   @override
//   _StatusUpdateState createState() => _StatusUpdateState();
// }

// class _StatusUpdateState extends State<StatusUpdate> {

//   var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController statusController = new TextEditingController();

//   updateStatus() async {

//     setState(() {
//       statusController.text = "1";
//     });

//     var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/UpdateTeacherStatus?status=' + 
//       statusController.text
//       ));

      
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Viewed!"),));
//       // return TimeTable.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to update Record!');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     // DVR NAME FIELD
//     final dvrField = TextFormField(
//       controller: statusController,

//       onSaved: (value){
//         statusController.text = value!;
//       },
//       textInputAction: TextInputAction.next,

//       decoration: InputDecoration(
//         labelText: '',
//         hintText: '',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       validator: (value){
//         if(value!.isEmpty){
//           return 'DVR name cannot be empty';
//         }
//         return null;
//       },
//     );
    
//     // UPDATE BUTTON FIELD
//     final updateButton = Material(
//       elevation: 10,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.blueAccent,
//       child: MaterialButton(
//         padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//         minWidth: MediaQuery.of(context).size.width,
//         onPressed: (){
//           if(_formKey.currentState!.validate()){
//             updateStatus();
//           }
//         },
//         child: Text("Update DVR Name",textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar : AppBar(
//         title: Text('Edit/Update DVR'),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [
//                   Color(0xFF03E5B7),
//                   Color(0xFF08C8F6),
//                   Color(0xFF48A9FE),
//                 ]
//             ),
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(height: height*0.02,),
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Center(
//                     child: Card(
//                       elevation: 20,
//                       shadowColor: Colors.black ,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
//                       ),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.white,
//                               Colors.white60,
//                               Colors.white12,
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             SizedBox(height: height*0.03),
//                             dvrField,
//                             SizedBox(height: height*0.05,),
//                             updateButton,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }