// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/2-Channel%20Setting%20Screen/0-Add%20New%20Channel%20Screen/AddNewChannelPage.dart';
// import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/2-Channel%20Setting%20Screen/1-Update%20Channel%20Screen/UpdateChannelPage.dart';

// class ChannelSettingPage extends StatefulWidget {
//   const ChannelSettingPage({Key? key}) : super(key: key);

//   @override
//   _ChannelSettingPageState createState() => _ChannelSettingPageState();
// }

// class _ChannelSettingPageState extends State<ChannelSettingPage> {
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

//     return Scaffold(
//       appBar : AppBar(
//         title: Text('Channel Setting'),
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

//       body: SafeArea(
//         child: GridView.count(
//           crossAxisCount: 1,
//           children: [
//           Column(
//           children: [
//             SizedBox(height: height*0.03,),
//             Flexible(
//               child: Center(
//                 child: Card(
//                   elevation: 10,
//                   shadowColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Container(
//                     width: width*0.8,
//                     height: height*0.4,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Channel                     12',style: textstyle,),
//                           Text('IP Address                  cam_1',style: textstyle,),
//                           Text('Venue                       LT_3',style: textstyle,),

//                           IconButton(
//                               onPressed: (){},
//                               icon: Icon(Icons.delete_forever,color: Colors.red)
//                           ),
//                         ],
//                       ),
//                     ),

//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: height*0.03,),
//             Flexible(
//               child: Center(
//                 child: Card(
//                   elevation: 10,
//                   shadowColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Container(
//                     width: width*0.8,
//                     height: height*0.4,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Channel                     16',style: textstyle,),
//                           Text('IP Address                  cam_2',style: textstyle,),
//                           Text('Venue                       LT_9',style: textstyle,),

//                           IconButton(
//                               onPressed: (){},
//                               icon: Icon(Icons.delete_forever,color: Colors.red)
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height*0.03,),
//           ],
//         ),
//             Column(
//               children: [
//                 Card(
//                   elevation: 10,
//                   shadowColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Container(
//                     width: width*0.7,
//                     height: height*0.07,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.blue,
//                     ),
//                     child: MaterialButton(
//                       onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewChannelPage()));
//                       },
//                       child: Text('Add New Channel',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height*0.025,),
//                 Card(
//                   elevation: 10,
//                   shadowColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Container(
//                     width: width*0.7,
//                     height: height*0.07,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.blue,
//                     ),
//                     child: MaterialButton(
//                       onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateChannelPage()));
//                       },
//                       child: Text('Update Channel',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
