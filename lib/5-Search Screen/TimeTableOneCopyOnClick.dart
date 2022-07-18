// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/5-Search%20Screen/SearchScreen.dart';

// class TimeTableOneCopyOnClick extends StatelessWidget {
//   // const TimeTableOneCopyOnClick({ Key? key }) : super(key: key);

//   final TimeTableOneCopyTable _timeTableOneCopyTable;
//   TimeTableOneCopyOnClick(this._timeTableOneCopyTable);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(_timeTableOneCopyTable.teachername),
//       ),

//       body: Container(
//         child: Column(
//           children: [
//             InkWell(
//               child: Container(
//                 child: Card(
//                   child: ListTile(
//                     leading: CircleAvatar(child: Icon(Icons.account_circle),),
//                     title: Text(_timeTableOneCopyTable.teachername.toString()),
//                     // trailing: Text('\$${booksModel.bprice.toString()}'),
//                     // subtitle: Text(booksModel.bpubyear.toString())
//                   )
                  
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }