import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import '../../../../main.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io'; 
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'PDFAPI.dart';

List<CHRTable> chrTable = [];

class CHR extends StatefulWidget {
  const CHR({Key? key}) : super(key: key);

  @override
  _CHRState createState() => _CHRState();
}

class _CHRState extends State<CHR> {

  void initState() {
    super.initState();
    
    // dvrNameController = TextEditingController(text: dvrTable[index].dvrname.toString());

    ShowAllCHR();
  }

  late TextEditingController dvrNameController;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

  List<CHRTable> chrTable = [];

  Future<void> ShowAllCHR() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getCHR'));
    // var response=await http.get(Uri.parse('https://localhost:44353/api/CHR/getCHR'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      chrTable = listt.map((e) => CHRTable.fromJson(e)).toList();
      // final uniqueJsonList = sectionTable.toSet().toList();
      setState(() {

      });

      //var res=json.decode(response.body);
      //return res.map<student>((json)=>student.fromJson(json)).toList();
    }
    else
      throw Exception('Failed to load data');

  }


//   Future<void> _createPDF() async {
//     //Create a PDF document.
//     var document = PdfDocument();
//     //Add page and draw text to the page.
//     document.pages.add().graphics.drawString(
//         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: Rect.fromLTWH(0, 0, 500, 30));
//     //Save the document
//     var bytes = document.save();
//    // Dispose the document
//    document.dispose();

//    //Get external storage directory
//     Directory directory = (await getApplicationDocumentsDirectory())!;
//     //Get directory path
//     String path = directory.path;
//     //Create an empty file to write PDF data
//     File file = File('$path/Output.pdf');
//     //Write PDF data
//     await file.writeAsBytes(bytes, flush: true);
//     //Open the PDF document in mobile
//     OpenFile.open('$path/Output.pdf');
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('CHR', style: TxtStyle.appbartextstyle,),
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
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificTeacherCHR()));
                          },
                          child: Text("Specific Teacher CHR")),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDateCHR()));
                          },
                          child: Text("Specific Date CHR")),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDayCHR()));
                          },
                          child: Text("Specific Day CHR")),
                      value: 3,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificSectionCHR()));
                          },
                          child: Text("Specific Section CHR")),
                      value: 4,
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherDateCHR()));
                          },
                          child: Text("Teacher+Date CHR")),
                      value: 5,
                    )
                  ])
        ],

      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async{
          if(i == 0)
          {
            final pdfFile = await PdfApi.generateTable();

            PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: RefreshIndicator(
        onRefresh: ShowAllCHR,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  
                  SizedBox(height: 15),
                  // Container(
                  //   margin: EdgeInsets.only(right: 1100),
                  //   child: Text('{$dayy}', style: TxtStyle.cardtextstyle2)
                  //   ),

                  SizedBox(height: 15,),
                  Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),

                  SizedBox(height: 15,),
                  Text('Class Held Report',style: TxtStyle.boldtxtstyleblue,),

                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Expanded(
                      // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
                      child: DataTable(

                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
                        // columnSpacing: 38.0,
                        // border: TableBorder.all(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(10),
                        //     width: 3),
                        columns: [
                          // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
                          DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
                          DataColumn(label: Text('In Time',style: cardtextstyle2,)),
                          DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
                          DataColumn(label: Text('In Date', style: cardtextstyle2,)),
                          DataColumn(label: Text('Day ', style: cardtextstyle2,)),
                          DataColumn(label: Text('Section',style: cardtextstyle2,)),
                          DataColumn(label: Text('Course',style: cardtextstyle2,)),
                          DataColumn(label: Text('Venue',style: cardtextstyle2,)),
                          DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
                          DataColumn(label: Text('Etime', style: cardtextstyle2,)),
                        ],
                        rows: List.generate(chrTable.length, (index) {
                          // final dvrid = dvrTable[index].dvrid.toString();
                          final teachername = chrTable[index].name.toString();
                          final intime = chrTable[index].intime.toString();
                          final outtime = chrTable[index].outime.toString();
                          final indate = chrTable[index].indate.toString();
                          final dayy = chrTable[index].dayy.toString();
                          final sectionname = chrTable[index].sectionname.toString();
                          final coursename = chrTable[index].coursename.toString();
                          final venue = chrTable[index].venue.toString();
                          final stime = chrTable[index].stime.toString();
                          final etime = chrTable[index].etime.toString();
                          return DataRow(
                            // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
                            cells: [
                            // DataCell(Text(dvrid),showEditIcon: true),
                            DataCell(Text(teachername)),
                            DataCell(Text(intime)),
                            DataCell(Text(outtime)),
                            DataCell(Text(indate)),
                            DataCell(Text(dayy)),
                            DataCell(Text(sectionname)),
                            // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
                            DataCell(Text(coursename)),
                            DataCell(Text(venue)),
                            DataCell(Text(stime)),
                            DataCell(Text(etime)),
                            
                          ]);
                        }),
                      ),
                    ),
                  ),

                  // TextButton(
                  //   child: Text(
                  //     'Generate PDF',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.resolveWith(
                  //           (states) => Colors.blue)),
                  //   // onPressed: _createPDF,
                  //   onPressed: () async {
                  //     final pdfFile = await PdfApi.generateTable();

                  //     PdfApi.openFile(pdfFile);
                  //   },
                  //)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}


class CHRTable
{
  late int chrid;
  late String name;
  late String intime;
  late String outime;
  late String indate;
  late String dayy;
  late String sectionname;
  late String coursename;
  late String venue;
  late String stime;
  late String etime;
  
  
  CHRTable({
    required this.chrid,
    required this.name,
    required this.intime,
    required this.outime,
    required this.indate,
    required this.dayy,
    required this.sectionname,
     required this.coursename,
    required this.venue,
    required this.stime,
    required this.etime,
    });

  factory CHRTable.fromJson(Map<String,dynamic>json)
  {
    return CHRTable(
      chrid:json['chrid'],
      name:json['name'],
      intime:json['intime'],
      outime:json['outime'],
      indate:json['indate'],
      dayy:json['dayy'],
      sectionname:json['sectionname'],
      coursename:json['coursename'],
      venue:json['venue'],
      stime:json['stime'],
      etime:json['etime'],
    );
  }
}




// // --------------->>>>> PAGINATED DATATABLE <<<<----------------------------------

// // import 'dart:math';

// // import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// // import 'package:flutter/material.dart';
// // import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
// // import 'dart:convert';
// // import 'package:pdf/widgets.dart' as pw;
// // import '../../../../main.dart';
// // import 'package:syncfusion_flutter_pdf/pdf.dart';
// // import 'dart:io'; 
// // import 'package:path_provider/path_provider.dart';
// // import 'package:open_file/open_file.dart';

// // import 'PDFAPI.dart';

// // List<CHRTable>? chrTable = [];

// // class CHR extends StatefulWidget {
// //   const CHR({Key? key}) : super(key: key);

// //   @override
// //   _CHRState createState() => _CHRState();
// // }

// // class _CHRState extends State<CHR> {

// //   void initState() {
// //     super.initState();
    
// //     // dvrNameController = TextEditingController(text: dvrTable[index].dvrname.toString());

// //     ShowAllCHR();
// //   }

// //   late TextEditingController dvrNameController;

// //   var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
// //   var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

// //   // List<CHRTable> chrTable = [];

// //   Future<void> ShowAllCHR() async{
// //     var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getCHR'));
// //     if(response.statusCode==200)
// //     {
// //       //return json.decode(response.body)['response'];
// //       print("Successfull Show Record");
// //       //print(response.body);

// //       Iterable listt = jsonDecode(response.body);
// //       print(listt);
// //       chrTable = listt.map((e) => CHRTable.fromJson(e)).toList();
// //       // final uniqueJsonList = sectionTable.toSet().toList();
// //       setState(() {

// //       });
// //       //var res=json.decode(response.body);
// //       //return res.map<student>((json)=>student.fromJson(json)).toList();
// //     }
// //     else
// //       throw Exception('Failed to load data');

// //   }


// // //   Future<void> _createPDF() async {
// // //     //Create a PDF document.
// // //     var document = PdfDocument();
// // //     //Add page and draw text to the page.
// // //     document.pages.add().graphics.drawString(
// // //         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
// // //         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
// // //         bounds: Rect.fromLTWH(0, 0, 500, 30));
// // //     //Save the document
// // //     var bytes = document.save();
// // //    // Dispose the document
// // //    document.dispose();

// // //    //Get external storage directory
// // //     Directory directory = (await getApplicationDocumentsDirectory())!;
// // //     //Get directory path
// // //     String path = directory.path;
// // //     //Create an empty file to write PDF data
// // //     File file = File('$path/Output.pdf');
// // //     //Write PDF data
// // //     await file.writeAsBytes(bytes, flush: true);
// // //     //Open the PDF document in mobile
// // //     OpenFile.open('$path/Output.pdf');
// // //  }

// //   var tableRow = MyData();

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar : AppBar(
// //           title: Text('CHR'),
// //           flexibleSpace: Container(
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(50),
// //               gradient: LinearGradient(
// //                   begin: Alignment.centerLeft,
// //                   end: Alignment.centerRight,
// //                   colors: [
// //                     Color(0xFF03E5B7),
// //                     Color(0xFF08C8F6),
// //                     Color(0xFF48A9FE),
// //                   ]
// //               ),
// //             ),
// //           ),
    
// //           actions: [
// //             PopupMenuButton(
// //                 offset: Offset(0.0, AppBar().preferredSize.height),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.only(
// //                     bottomLeft: Radius.circular(8.0),
// //                     bottomRight: Radius.circular(8.0),
// //                     topLeft: Radius.circular(8.0),
// //                     topRight: Radius.circular(8.0),
// //                   ),
// //                 ),
                
// //                 itemBuilder: (context) => [
// //                       PopupMenuItem(
// //                         child: InkWell(
// //                             onTap: () {
// //                               Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificTeacherCHR()));
// //                             },
// //                             child: Text("Specific Teacher CHR")),
// //                         value: 1,
// //                       ),
// //                       PopupMenuItem(
// //                         child: InkWell(
// //                             onTap: () {
// //                               Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDateCHR()));
// //                             },
// //                             child: Text("Specific Date CHR")),
// //                         value: 2,
// //                       ),
// //                       PopupMenuItem(
// //                         child: InkWell(
// //                             onTap: () {
// //                               Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDayCHR()));
// //                             },
// //                             child: Text("Specific Day CHR")),
// //                         value: 3,
// //                       ),
// //                       PopupMenuItem(
// //                         child: InkWell(
// //                             onTap: () {
// //                               Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificSectionCHR()));
// //                             },
// //                             child: Text("Specific Section CHR")),
// //                         value: 4,
// //                       ),
// //                       PopupMenuItem(
// //                         child: InkWell(
// //                             onTap: () {
// //                               Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherDateCHR()));
// //                             },
// //                             child: Text("Teacher+Date CHR")),
// //                         value: 5,
// //                       )
// //                     ])
// //           ],
    
// //         ),
    
// //         bottomNavigationBar: ConvexAppBar(
// //           items: [
// //             TabItem(icon: Icons.picture_as_pdf
// //             , title: 'Generate PDF'),
// //           ],
// //           initialActiveIndex: 0, //optional, default as 0
// //           elevation: 10,
// //           onTap: (int i) async{
// //             if(i == 0)
// //             {
// //               final pdfFile = await PdfApi.generateTable();
    
// //               PdfApi.openFile(pdfFile);
// //             }
// //           }
// //         ),
    
// //         body: RefreshIndicator(
// //           onRefresh: ShowAllCHR,
// //           child: SafeArea(
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.vertical,
// //               child: SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       padding: EdgeInsets.all(15),
// //                       child: Expanded(
// //                         // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
              
// //                         child: PaginatedDataTable(
// //                           header: Text('CHR'),
// //                           onRowsPerPageChanged: (perPage) {},
// //                           rowsPerPage: 3,
// //                           columnSpacing: 100,
// //                           horizontalMargin: 10,
// //                           columns: [
// //                             // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
// //                             DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
// //                             DataColumn(label: Text('In Time',style: cardtextstyle2,)),
// //                             DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('In Date', style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Day ', style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Section',style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Course',style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Venue',style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
// //                             // DataColumn(label: Text('Etime', style: cardtextstyle2,)),
// //                           ],
                          
// //                           source: tableRow,
// //                         ),
// //                       ),
// //                     ),
    
// //                     // TextButton(
// //                     //   child: Text(
// //                     //     'Generate PDF',
// //                     //     style: TextStyle(color: Colors.white),
// //                     //   ),
// //                     //   style: ButtonStyle(
// //                     //       backgroundColor: MaterialStateProperty.resolveWith(
// //                     //           (states) => Colors.blue)),
// //                     //   // onPressed: _createPDF,
// //                     //   onPressed: () async {
// //                     //     final pdfFile = await PdfApi.generateTable();
    
// //                     //     PdfApi.openFile(pdfFile);
// //                     //   },
// //                     //)
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
  
// //   // DataTableSource dataSource(List<CHRTable> chrList) =>
// //   //     MyData(dataList: chrList);

// // }

// // class MyData extends DataTableSource {
// //   @override
// //   DataRow? getRow(int index) {
// //     return DataRow.byIndex(index: index, cells: [
// //       DataCell(Text("Cell $index")),
// //       DataCell(Text("Cell $index")),
// //       DataCell(Text("Cell $index")),
// //     ]);
// //   }

// //   @override
// //   bool get isRowCountApproximate => true;

// //   @override
// //   int get rowCount => 50;

// //   @override
// //   int get selectedRowCount => 0;
// // }


// // // class MyData extends DataTableSource {
// // //   // Generate some made-up data

// // //   @override
// // //   bool get isRowCountApproximate => true;
// // //   @override
// // //   int get rowCount => chrTable!.length;
// // //   @override
// // //   int get selectedRowCount => 0;
// // //   @override
// // //   DataRow getRow(int index) {
// // //     return DataRow(
// // //       cells: [
// // //         DataCell(
// // //           Text(chrTable![index].name.toString()),
// // //         ),
// // //         DataCell(
// // //           Text(chrTable![index].intime.toString()),
// // //         ),
// // //         DataCell(
// // //           Text(chrTable![index].outime.toString()),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }

// // class CHRTable
// // {
// //   late int chrid;
// //   late String name;
// //   late String intime;
// //   late String outime;
// //   late String indate;
// //   late String dayy;
// //   late String sectionname;
// //   late String coursename;
// //   late String venue;
// //   late String stime;
// //   late String etime;
  
  
// //   CHRTable({
// //     required this.chrid,
// //     required this.name,
// //     required this.intime,
// //     required this.outime,
// //     required this.indate,
// //     required this.dayy,
// //     required this.sectionname,
// //      required this.coursename,
// //     required this.venue,
// //     required this.stime,
// //     required this.etime,
// //     });

// //   factory CHRTable.fromJson(Map<String,dynamic>json)
// //   {
// //     return CHRTable(
// //       chrid:json['chrid'],
// //       name:json['name'],
// //       intime:json['intime'],
// //       outime:json['outime'],
// //       indate:json['indate'],
// //       dayy:json['dayy'],
// //       sectionname:json['sectionname'],
// //       coursename:json['coursename'],
// //       venue:json['venue'],
// //       stime:json['stime'],
// //       etime:json['etime'],
// //     );
// //   }
// // }



// _-_-_-_-_-_-_-_-_-_- CHR WITH STIME _-_-_-_-_-_-_-_-_-_-  // 

// import 'dart:math';

// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
// import 'package:http/http.dart' as http;
// import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
// import 'dart:convert';
// import 'package:pdf/widgets.dart' as pw;
// import '../../../../main.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'dart:io'; 
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

// import 'PDFAPI.dart';

// List<CHRTable> chrTable = [];

// class CHR extends StatefulWidget {
//   const CHR({Key? key}) : super(key: key);

//   @override
//   _CHRState createState() => _CHRState();
// }

// class _CHRState extends State<CHR> {

//   void initState() {
//     super.initState();
//     ShowSlotCHR();
//   }

//   late TextEditingController dvrNameController;

//   var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
//   var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);


//   List<CHRTable> chrTable1 = [];
//   List<CHRTable> chrTable2 = [];
//   List<CHRTable> chrTable3 = [];
//   List<CHRTable> chrTable4 = [];
//   List<CHRTable> chrTable5 = [];

//   Future<void> ShowSlotCHR() async{

//     var response1=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFirstSlotCHR'));
//     var response2=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getSecondSlotCHR'));
//     var response3=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getThirdSlotCHR'));
//     var response4=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFourthSlotCHR'));
//     var response5=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFifthSlotCHR'));

//     Iterable listt1 = jsonDecode(response1.body);
//     print(listt1);

//     Iterable listt2 = jsonDecode(response2.body);
//     print(listt2);

//     Iterable listt3 = jsonDecode(response3.body);
//     print(listt3);

//     Iterable listt4 = jsonDecode(response4.body);
//     print(listt4);

//     Iterable listt5 = jsonDecode(response5.body);
//     print(listt5);

//     chrTable1 = listt1.map((e) => CHRTable.fromJson(e)).toList();
//     chrTable2 = listt2.map((e) => CHRTable.fromJson(e)).toList();
//     chrTable3 = listt3.map((e) => CHRTable.fromJson(e)).toList();
//     chrTable4 = listt4.map((e) => CHRTable.fromJson(e)).toList();
//     chrTable5 = listt5.map((e) => CHRTable.fromJson(e)).toList();

//     setState(() {

//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar : AppBar(
//         title: Text('CHR', style: TxtStyle.appbartextstyle,),
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

//         actions: [
//           PopupMenuButton(
//               offset: Offset(0.0, AppBar().preferredSize.height),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(8.0),
//                   bottomRight: Radius.circular(8.0),
//                   topLeft: Radius.circular(8.0),
//                   topRight: Radius.circular(8.0),
//                 ),
//               ),
              
//               itemBuilder: (context) => [
//                     PopupMenuItem(
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificTeacherCHR()));
//                           },
//                           child: Text("Specific Teacher CHR")),
//                       value: 1,
//                     ),
//                     PopupMenuItem(
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDateCHR()));
//                           },
//                           child: Text("Specific Date CHR")),
//                       value: 2,
//                     ),
//                     PopupMenuItem(
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificDayCHR()));
//                           },
//                           child: Text("Specific Day CHR")),
//                       value: 3,
//                     ),
//                     PopupMenuItem(
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificSectionCHR()));
//                           },
//                           child: Text("Specific Section CHR")),
//                       value: 4,
//                     ),
//                     PopupMenuItem(
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherDateCHR()));
//                           },
//                           child: Text("Teacher+Date CHR")),
//                       value: 5,
//                     )
//                   ])
//         ],

//       ),

//       bottomNavigationBar: ConvexAppBar(
//         items: [
//           TabItem(icon: Icons.picture_as_pdf
//           , title: 'Generate PDF'),
//         ],
//         initialActiveIndex: 0, //optional, default as 0
//         elevation: 10,
//         onTap: (int i) async{
//           if(i == 0)
//           {
//             final pdfFile = await PdfApi.generateTable2();

//             PdfApi.openFile(pdfFile);
//           }
//         }
//       ),

//       body: RefreshIndicator(
//         onRefresh: ShowSlotCHR,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Column(
//                 children: [
                  
//                   SizedBox(height: 15),
//                   // Container(
//                   //   margin: EdgeInsets.only(right: 1100),
//                   //   child: Text('{$dayy}', style: TxtStyle.cardtextstyle2)
//                   //   ),

//                   SizedBox(height: 15,),
//                   Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),

//                   SizedBox(height: 15,),
//                   Text('Class Held Report',style: TxtStyle.boldtxtstyleblue,),
//                   SizedBox(height: 15,),

//                   Container(
//                     padding: EdgeInsets.only(left: 7.5, right: 7.5),
//                     color: Colors.blueGrey,
//                     width: MediaQuery.of(context).size.width,
//                     alignment: Alignment.center,
//                     child: Text('08:30 AM - 10:00 AM',style: TxtStyle.appbartextstyle,)
//                     ),

//                   // SizedBox(height: 10,),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Expanded(
//                       // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
//                       child: DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
//                         // columnSpacing: 38.0,
//                         // border: TableBorder.all(
//                         //     color: Colors.blue,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     width: 3),
//                         columns: [
//                           // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Date', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Day ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Etime', style: cardtextstyle2,)),
//                         ],
//                         rows: List.generate(chrTable1.length, (index) {
//                           // final dvrid = dvrTable[index].dvrid.toString();
//                           final teachername = chrTable1[index].name.toString();
//                           final intime = chrTable1[index].intime.toString();
//                           final outtime = chrTable1[index].outime.toString();
//                           final indate = chrTable1[index].indate.toString();
//                           final dayy = chrTable1[index].dayy.toString();
//                           final sectionname = chrTable1[index].sectionname.toString();
//                           final coursename = chrTable1[index].coursename.toString();
//                           final venue = chrTable1[index].venue.toString();
//                           final stime = chrTable1[index].stime.toString();
//                           final etime = chrTable1[index].etime.toString();
//                           return DataRow(
//                             // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
//                             cells: [
//                             // DataCell(Text(dvrid),showEditIcon: true),
//                             DataCell(Text(teachername)),
//                             DataCell(Text(intime)),
//                             DataCell(Text(outtime)),
//                             DataCell(Text(indate)),
//                             DataCell(Text(dayy)),
//                             DataCell(Text(sectionname)),
//                             // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
//                             DataCell(Text(coursename)),
//                             DataCell(Text(venue)),
//                             DataCell(Text(stime)),
//                             DataCell(Text(etime)),
                            
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),


//                   Container(
//                     padding: EdgeInsets.only(left: 7.5, right: 7.5),
//                     color: Colors.blueGrey,
//                     width: MediaQuery.of(context).size.width,
//                     alignment: Alignment.center,
//                     child: Text('10:00 AM - 11:30 AM',style: TxtStyle.appbartextstyle,)
//                     ),

//                   // SizedBox(height: 10,),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Expanded(
//                       // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
//                       child: DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
//                         // columnSpacing: 38.0,
//                         // border: TableBorder.all(
//                         //     color: Colors.blue,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     width: 3),
//                         columns: [
//                           // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Date', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Day ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Etime', style: cardtextstyle2,)),
//                         ],
//                         rows: List.generate(chrTable2.length, (index) {
//                           // final dvrid = dvrTable[index].dvrid.toString();
//                           final teachername = chrTable2[index].name.toString();
//                           final intime = chrTable2[index].intime.toString();
//                           final outtime = chrTable2[index].outime.toString();
//                           final indate = chrTable2[index].indate.toString();
//                           final dayy = chrTable2[index].dayy.toString();
//                           final sectionname = chrTable2[index].sectionname.toString();
//                           final coursename = chrTable2[index].coursename.toString();
//                           final venue = chrTable2[index].venue.toString();
//                           final stime = chrTable2[index].stime.toString();
//                           final etime = chrTable2[index].etime.toString();
//                           return DataRow(
//                             // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
//                             cells: [
//                             // DataCell(Text(dvrid),showEditIcon: true),
//                             DataCell(Text(teachername)),
//                             DataCell(Text(intime)),
//                             DataCell(Text(outtime)),
//                             DataCell(Text(indate)),
//                             DataCell(Text(dayy)),
//                             DataCell(Text(sectionname)),
//                             // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
//                             DataCell(Text(coursename)),
//                             DataCell(Text(venue)),
//                             DataCell(Text(stime)),
//                             DataCell(Text(etime)),
                            
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),


//                   Container(
//                     color: Colors.blueGrey,
//                     width: MediaQuery.of(context).size.width,
//                     alignment: Alignment.center,
//                     child: Text('11:30 AM - 01:00 PM',style: TxtStyle.appbartextstyle,)
//                     ),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Expanded(
//                       // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
//                       child: DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
//                         // columnSpacing: 38.0,
//                         // border: TableBorder.all(
//                         //     color: Colors.blue,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     width: 3),
//                         columns: [
//                           // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Date', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Day ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Etime', style: cardtextstyle2,)),
//                         ],
//                         rows: List.generate(chrTable3.length, (index) {
//                           // final dvrid = dvrTable[index].dvrid.toString();
//                           final teachername = chrTable3[index].name.toString();
//                           final intime = chrTable3[index].intime.toString();
//                           final outtime = chrTable3[index].outime.toString();
//                           final indate = chrTable3[index].indate.toString();
//                           final dayy = chrTable3[index].dayy.toString();
//                           final sectionname = chrTable3[index].sectionname.toString();
//                           final coursename = chrTable3[index].coursename.toString();
//                           final venue = chrTable3[index].venue.toString();
//                           final stime = chrTable3[index].stime.toString();
//                           final etime = chrTable3[index].etime.toString();
//                           return DataRow(
//                             // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
//                             cells: [
//                             // DataCell(Text(dvrid),showEditIcon: true),
//                             DataCell(Text(teachername)),
//                             DataCell(Text(intime)),
//                             DataCell(Text(outtime)),
//                             DataCell(Text(indate)),
//                             DataCell(Text(dayy)),
//                             DataCell(Text(sectionname)),
//                             // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
//                             DataCell(Text(coursename)),
//                             DataCell(Text(venue)),
//                             DataCell(Text(stime)),
//                             DataCell(Text(etime)),
                            
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),

//                   Container(
//                     color: Colors.blueGrey,
//                     width: MediaQuery.of(context).size.width,
//                     alignment: Alignment.center,
//                     child: Text('01:30 PM - 03:00 PM',style: TxtStyle.appbartextstyle,)
//                     ),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Expanded(
//                       // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
//                       child: DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
//                         // columnSpacing: 38.0,
//                         // border: TableBorder.all(
//                         //     color: Colors.blue,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     width: 3),
//                         columns: [
//                           // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Date', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Day ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Etime', style: cardtextstyle2,)),
//                         ],
//                         rows: List.generate(chrTable4.length, (index) {
//                           // final dvrid = dvrTable[index].dvrid.toString();
//                           final teachername = chrTable4[index].name.toString();
//                           final intime = chrTable4[index].intime.toString();
//                           final outtime = chrTable4[index].outime.toString();
//                           final indate = chrTable4[index].indate.toString();
//                           final dayy = chrTable4[index].dayy.toString();
//                           final sectionname = chrTable4[index].sectionname.toString();
//                           final coursename = chrTable4[index].coursename.toString();
//                           final venue = chrTable4[index].venue.toString();
//                           final stime = chrTable4[index].stime.toString();
//                           final etime = chrTable4[index].etime.toString();
//                           return DataRow(
//                             // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
//                             cells: [
//                             // DataCell(Text(dvrid),showEditIcon: true),
//                             DataCell(Text(teachername)),
//                             DataCell(Text(intime)),
//                             DataCell(Text(outtime)),
//                             DataCell(Text(indate)),
//                             DataCell(Text(dayy)),
//                             DataCell(Text(sectionname)),
//                             // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
//                             DataCell(Text(coursename)),
//                             DataCell(Text(venue)),
//                             DataCell(Text(stime)),
//                             DataCell(Text(etime)),
                            
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),


//                   Container(
//                     color: Colors.blueGrey,
//                     width: MediaQuery.of(context).size.width,
//                     alignment: Alignment.center,
//                     child: Text('03:00 PM - 04:30 PM',style: TxtStyle.appbartextstyle,)
//                     ),
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     child: Expanded(
//                       // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
//                       child: DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade300),
                        
//                         // columnSpacing: 38.0,
//                         // border: TableBorder.all(
//                         //     color: Colors.blue,
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     width: 3),
//                         columns: [
//                           // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Teacher',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Out Time',style: cardtextstyle2,)),
//                           DataColumn(label: Text('In Date', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Day ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Section',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Course',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Venue',style: cardtextstyle2,)),
//                           DataColumn(label: Text('Stime ', style: cardtextstyle2,)),
//                           DataColumn(label: Text('Etime', style: cardtextstyle2,)),
//                         ],
//                         rows: List.generate(chrTable5.length, (index) {
//                           // final dvrid = dvrTable[index].dvrid.toString();
//                           final teachername = chrTable5[index].name.toString();
//                           final intime = chrTable5[index].intime.toString();
//                           final outtime = chrTable5[index].outime.toString();
//                           final indate = chrTable5[index].indate.toString();
//                           final dayy = chrTable5[index].dayy.toString();
//                           final sectionname = chrTable5[index].sectionname.toString();
//                           final coursename = chrTable5[index].coursename.toString();
//                           final venue = chrTable5[index].venue.toString();
//                           final stime = chrTable5[index].stime.toString();
//                           final etime = chrTable5[index].etime.toString();
//                           return DataRow(
//                             // color: MaterialStateProperty.resolveWith((states) => (sectionname == 'BSCS-1A') ? Colors.red : Colors.blue),
//                             cells: [
//                             // DataCell(Text(dvrid),showEditIcon: true),
//                             DataCell(Text(teachername)),
//                             DataCell(Text(intime)),
//                             DataCell(Text(outtime)),
//                             DataCell(Text(indate)),
//                             DataCell(Text(dayy)),
//                             DataCell(Text(sectionname)),
//                             // DataCell(Text(sectionname,style: TextStyle(backgroundColor: (sectionname == 'BSCS-1A') ? Colors.yellow : Colors.white),)),
//                             DataCell(Text(coursename)),
//                             DataCell(Text(venue)),
//                             DataCell(Text(stime)),
//                             DataCell(Text(etime)),
                            
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),

                  
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// }


// class CHRTable
// {
//   late int chrid;
//   late String name;
//   late String intime;
//   late String outime;
//   late String indate;
//   late String dayy;
//   late String sectionname;
//   late String coursename;
//   late String venue;
//   late String stime;
//   late String etime;
  
  
//   CHRTable({
//     required this.chrid,
//     required this.name,
//     required this.intime,
//     required this.outime,
//     required this.indate,
//     required this.dayy,
//     required this.sectionname,
//      required this.coursename,
//     required this.venue,
//     required this.stime,
//     required this.etime,
//     });

//   factory CHRTable.fromJson(Map<String,dynamic>json)
//   {
//     return CHRTable(
//       chrid:json['chrid'],
//       name:json['name'],
//       intime:json['intime'],
//       outime:json['outime'],
//       indate:json['indate'],
//       dayy:json['dayy'],
//       sectionname:json['sectionname'],
//       coursename:json['coursename'],
//       venue:json['venue'],
//       stime:json['stime'],
//       etime:json['etime'],
//     );
//   }
// }




