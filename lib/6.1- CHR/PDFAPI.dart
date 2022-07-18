import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:m_eye_gui/6.1-%20CHR/GetSpecificCHR.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'CHR.dart';

String? sectionnamepdf;
String? dayy = DateFormat('EEEE').format(DateTime.now());
// String? dayy = DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()));

List<CHRTable> chrList = [];

class PdfApi {

  static Future<File> generateTable() async {
    var response =
        await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getCHR'));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final Document pdf = Document();

      for(int i=0; i<data.length; i++)
      {

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          Text('{$dayy}'),
          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),
          SizedBox(height: 15),

          Table.fromTextArray(
          cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));
      }
      return saveDocument(name: 'chr.pdf', pdf: pdf);
    } else {
      throw Exception('Failed to load data');
    }
      
  }

  // ---->>> STIME PDF API <<<---- 

  static Future<File> generateTable2() async {

    var response1=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFirstSlotCHR'));
    var response2=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getSecondSlotCHR'));
    var response3=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getThirdSlotCHR'));
    var response4=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFourthSlotCHR'));
    var response5=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/CHR/getFifthSlotCHR'));

    Iterable listt1 = jsonDecode(response1.body);
    print(listt1);

    Iterable listt2 = jsonDecode(response2.body);
    print(listt2);

    Iterable listt3 = jsonDecode(response3.body);
    print(listt3);

    Iterable listt4 = jsonDecode(response4.body);
    print(listt4);

    Iterable listt5 = jsonDecode(response5.body);
    print(listt5);

    var data1 = listt1.map((e) => CHRTable.fromJson(e)).toList();
    var data2 = listt2.map((e) => CHRTable.fromJson(e)).toList();
    var data3 = listt3.map((e) => CHRTable.fromJson(e)).toList();
    var data4 = listt4.map((e) => CHRTable.fromJson(e)).toList();
    var data5 = listt5.map((e) => CHRTable.fromJson(e)).toList();

      final Document pdf = Document();

      final headers = [
        // 'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          Text('{$dayy}'),
          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),
          SizedBox(height: 15),


          Container(
          color: PdfColors.blueGrey,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('08:30 AM - 10:00 AM')
          ),

          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data2[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),
          
          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt1.length; i++)
              <String>[
                
                // '${i + 1}) ${'     '}',
                '${'    ' + data1.elementAt(i).name}',
                '${data1.elementAt(i).intime}',
                '${data1.elementAt(i).outime}',
                '${data1.elementAt(i).indate}',
                '${data1.elementAt(i).dayy}',
                '${data1.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data1.elementAt(i).coursename}',
                '${data1.elementAt(i).venue}',
                '${data1.elementAt(i).stime}',
                '${data1.elementAt(i).etime}'
              ],
          ],
        ),

          Container(
          color: PdfColors.blueGrey,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('10:00 AM - 11:30 AM')
          ),

          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data2[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          // headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt2.length; i++)
              <String>[
                
                // '${i + 1}) ${'     '}',
                '${'    ' + data2.elementAt(i).name}',
                '${data2.elementAt(i).intime}',
                '${data2.elementAt(i).outime}',
                '${data2.elementAt(i).indate}',
                '${data2.elementAt(i).dayy}',
                '${data2.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data2.elementAt(i).coursename}',
                '${data2.elementAt(i).venue}',
                '${data2.elementAt(i).stime}',
                '${data2.elementAt(i).etime}'
              ],
          ],
        ),

        Container(
          color: PdfColors.blueGrey,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('11:30 AM - 01:00 PM')
        ),

        Table.fromTextArray(
          // cellStyle: TextStyle(color: (data3[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          // headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt3.length; i++)
              <String>[
                
                // '${i + 1}) ${'     '}',
                '${'    ' + data3.elementAt(i).name}',
                '${data3.elementAt(i).intime}',
                '${data3.elementAt(i).outime}',
                '${data3.elementAt(i).indate}',
                '${data3.elementAt(i).dayy}',
                '${data3.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data3.elementAt(i).coursename}',
                '${data3.elementAt(i).venue}',
                '${data3.elementAt(i).stime}',
                '${data3.elementAt(i).etime}'
              ],
          ],
        ),


        Container(
          color: PdfColors.blueGrey,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('01:30 PM - 03:00 PM')
          ),

          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data2[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          // headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt4.length; i++)
              <String>[
                
                // '${i + 1}) ${'     '}',
                '${'    ' + data4.elementAt(i).name}',
                '${data4.elementAt(i).intime}',
                '${data4.elementAt(i).outime}',
                '${data4.elementAt(i).indate}',
                '${data4.elementAt(i).dayy}',
                '${data4.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data4.elementAt(i).coursename}',
                '${data4.elementAt(i).venue}',
                '${data4.elementAt(i).stime}',
                '${data4.elementAt(i).etime}'
              ],
          ],
        ),


        Container(
          color: PdfColors.blueGrey,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('03:00 PM - 04:30 PM')
          ),

          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data2[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          // headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt5.length; i++)
              <String>[
                
                // '${i + 1}) ${'     '}',
                '${'    ' + data5.elementAt(i).name}',
                '${data5.elementAt(i).intime}',
                '${data5.elementAt(i).outime}',
                '${data5.elementAt(i).indate}',
                '${data5.elementAt(i).dayy}',
                '${data5.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data5.elementAt(i).coursename}',
                '${data5.elementAt(i).venue}',
                '${data5.elementAt(i).stime}',
                '${data5.elementAt(i).etime}'
              ],
          ],
        ),

        ]
      ));
      return saveDocument(name: 'chr.pdf', pdf: pdf);   
  }

  // ---->>> SPECIFIC TEACHER PDF API <<<----
  static Future<File> SpecificTeacherCHR() async {
    print('Name Controller Value'+ nameController.toString());
    var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getTeacherCHR?name=" + nameController!.text));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final pdf = Document();

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          Text('{$dayy}'),
          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),
          SizedBox(height: 15),

          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));

      return saveDocument(name: 'chr.pdf', pdf: pdf);
      
    } else {
      throw Exception('Failed to load data');
    }
      
  }
  
  // ---->>> SPECIFIC DATE PDF API <<<----
   static Future<File> SpecificDateCHR() async {
    print('Controller Value'+ indateController.toString());
    var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getDateCHR?indate=" + indateController!.text));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final pdf = Document();

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}'),

          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),

          SizedBox(height: 10),
          Center(
            child: Text('Class Held Report ${indateController?.text.toString()}',
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold)
              ),
          ),

          SizedBox(height: 15),


          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));

      return saveDocument(name: 'chr.pdf', pdf: pdf);
      
    } else {
      throw Exception('Failed to load data');
    }
      
  }
  

  // ---->>> SPECIFIC DAY PDF API <<<----
   static Future<File> SpecificDayCHR() async {
    print('Controller Value'+ indateController.toString());
    var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getDayCHR?dayy=" + dayyController!.text));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final pdf = Document();

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          // Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}'),

          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),

          SizedBox(height: 10),
          Center(
            child: Text('Class Held Report >${dayyController?.text.toString()}<',
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold)
              ),
          ),

          SizedBox(height: 15),


          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));

      return saveDocument(name: 'chr.pdf', pdf: pdf);
      
    } else {
      throw Exception('Failed to load data');
    }
      
  }
  

  // ---->>> SPECIFIC SECTION PDF API <<<----
   static Future<File> SpecificSectionCHR() async {
    print('Controller Value'+ indateController.toString());
    var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getSectionCHR?sectionname=" + sectionController!.text));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final pdf = Document();

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          // Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}'),

          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),

          SizedBox(height: 10),
          Center(
            child: Text('Class Held Report *${sectionController?.text.toString()}*',
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold)
              ),
          ),

          SizedBox(height: 15),


          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));

      return saveDocument(name: 'chr.pdf', pdf: pdf);
      
    } else {
      throw Exception('Failed to load data');
    }
      
  }
  
  // ---->>> TEACHER+DATE PDF API <<<----
   static Future<File> TeacherDateCHR() async {
    print('Controller Value'+ indateController.toString());
    var response = await http.get(Uri.parse(ApiUrl.apiUrl + 
        "meyepro/api/CHR/getTeacherDateCHR?name=" + nameController!.text + 
        "&indate=" + indateController!.text
      ));
    if (response.statusCode == 200) {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      var data = listt.map((e) => CHRTable.fromJson(e)).toList();

      final pdf = Document();

      final headers = [
        'ID',
        'Name',
        'In Time',
        'Out Time',
        'In Date',
        'Day',
        'Section',
        'Course',
        'Venue',
        'Stime',
        'Etime'
      ];

      // final users = [
      //   User(name: 'James', age: 19),
      //   User(name: 'Sarah', age: 21),
      //   User(name: 'Emma', age: 28),
      // ];
      // final data = listt.map<CHRTable>((json) => CHRTable.fromJson(json)).toList();

      // --------------->>>>>> SOURCE >>> https://stackoverflow.com/questions/63372311/how-can-i-create-a-pdf-file-in-flutter-after-doing-some-math-on-a-json-response

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        // header: headers,
        build: (context) => <Widget>[
          
          Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}'),

          SizedBox(height: 10),
          Center(
            child: Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY', 
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold))
              ),

          SizedBox(height: 10),
          Center(
            child: Text('Class Held Report ${indateController?.text.toString()}',
              style: TextStyle(color: PdfColors.blue,letterSpacing: 1,fontWeight: FontWeight.bold)
              ),
          ),

          SizedBox(height: 15),


          Table.fromTextArray(
          // cellStyle: TextStyle(color: (data[i].sectionname.contains('BSCS-1A')) ? PdfColors.red : PdfColors.green),

          headers: headers,
          data: <List<String>>[
            for (int i = 0; i < listt.length; i++)
              <String>[
                
                '${i + 1}) ${'     '}',
                '${'    ' + data.elementAt(i).name}',
                '${data.elementAt(i).intime}',
                '${data.elementAt(i).outime}',
                '${data.elementAt(i).indate}',
                '${data.elementAt(i).dayy}',
                '${data.elementAt(i).sectionname}',
                // '${Text(data.elementAt(i).sectionname,style: TextStyle(color: (data.elementAt(i).sectionname == 'BSCS-1A') ? PdfColors.red : PdfColors.green))}',
                '${data.elementAt(i).coursename}',
                '${data.elementAt(i).venue}',
                '${data.elementAt(i).stime}',
                '${data.elementAt(i).etime}'
              ],
          ],
        ),
        ]
      ));

      return saveDocument(name: 'chr.pdf', pdf: pdf);
      
    } else {
      throw Exception('Failed to load data');
    }
      
  }
  

  // ---> IMAGE PDF <---
  static Future<File> generateImage() async {
    final pdf = Document();

    final imageSvg = await rootBundle.loadString('assets/fruit.svg');
    final imageJpg =
        (await rootBundle.load('assets/person.jpg')).buffer.asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
          );
        } else {
          return Container();
        }
      },
    );

    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          Container(
            height: pageTheme.pageFormat.availableHeight - 1,
            child: Center(
              child: Text(
                'Foreground Text',
                style: TextStyle(color: PdfColors.white, fontSize: 48),
              ),
            ),
          ),
          SvgImage(svg: imageSvg),
          Image(MemoryImage(imageJpg)),
          Center(
            child: ClipRRect(
              horizontalRadius: 32,
              verticalRadius: 32,
              child: Image(
                MemoryImage(imageJpg),
                width: pageTheme.pageFormat.availableWidth / 2,
              ),
            ),
          ),
          GridView(
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: [
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
            ],
          )
        ],
      ),
    );

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  // ---> SAVE DOCUMENT FUNCTION <---
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  // ---> OPEN FILE FUNCTION <---
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}