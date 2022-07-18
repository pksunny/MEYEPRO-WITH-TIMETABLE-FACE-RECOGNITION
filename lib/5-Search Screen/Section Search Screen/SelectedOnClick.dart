import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SelectedOnClick extends StatefulWidget {
  const SelectedOnClick({ Key? key, required this.selectedOverall,required this.selectedTimeTable }) : super(key: key);

  final TimeTable selectedOverall;
  final List<TimeTable> selectedTimeTable;
  // SectionOnClickPage(this._overall);
  // final String sectionname;

  @override
  State<SelectedOnClick> createState() => _SelectedOnClickState();
}

class _SelectedOnClickState extends State<SelectedOnClick> {

  // -->> SELECTED SECTIONS <<-- //
  //List<TimeTable> selectedSectionTimeTable = [];
  //late TimeTable timeTable;

  final MaskTextInputFormatter timeMaskFormatter = MaskTextInputFormatter(mask: '##:##:##', filter: {"#": RegExp(r'[0-9]')});

  String hrCounter = '00';
  String minCounter = '00';
  String secCounter = '00';
  String temp="";

  final TextEditingController tidController = new TextEditingController();
  final TextEditingController teachernameController = new TextEditingController();
  final TextEditingController dayyController = new TextEditingController();
  final TextEditingController coursenameController = new TextEditingController();
  final TextEditingController sectionnameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController stimeController = new TextEditingController();
  final TextEditingController etimeController = new TextEditingController();
  final TextEditingController ftenmController = new TextEditingController();
  final TextEditingController mtenmController = new TextEditingController();
  final TextEditingController ltenmController = new TextEditingController();
  // -->> UPDATE API <<-- //
  updateTimeTable() async {

    setState(() {
      tidController.text = widget.selectedOverall.tid.toString();
      teachernameController.text = widget.selectedOverall.teachername.toString();
      dayyController.text = widget.selectedOverall.dayy.toString();
      coursenameController.text = widget.selectedOverall.coursename.toString();
      sectionnameController.text = widget.selectedOverall.sectionname.toString();
      venueController.text = widget.selectedOverall.venue.toString();
      stimeController.text = widget.selectedOverall.stime.toString();
      etimeController.text = widget.selectedOverall.etime.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/updateall'),
      body:{
        'tid': tidController.text,
        'teachername': teachernameController.text,
        'dayy': dayyController.text,
        'coursename': coursenameController.text,
        'sectionname': sectionnameController.text,
        'venue': venueController.text,
        'stime': stimeController.text,
        'etime': etimeController.text,
        'ftenm': ftenmController.text,
        'mtenm': mtenmController.text,
        'ltenm': ltenmController.text
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) { 

    // UPDATE BUTTON //
    final updateButton = AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            updateTimeTable();
          },
          child: Text("Update",textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat Regular',
              fontSize: 20,color: 
              Colors.white,fontWeight: 
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.selectedOverall.tid.toString()),
        ),
    
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('TID: '+'${widget.selectedOverall.tid.toString()}',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  txtField(tidController, widget.selectedOverall.tid.toString(), widget.selectedOverall.tid.toString(), true),
                  // SizedBox(height: 10,),
                  // txtField(teachernameController, widget.selectedOverall.teachername.toString(), 'Teacher Name', true),
                  // SizedBox(height: 10,),
                  // txtField(dayyController, widget.selectedOverall.dayy.toString(), 'Day', true),
                  // SizedBox(height: 10,),
                  // txtField(coursenameController, widget.selectedOverall.coursename.toString(), 'Course', true),
                  // SizedBox(height: 10,),
                  // txtField(sectionnameController, widget.selectedOverall.sectionname.toString(), 'Section', true),
                  // SizedBox(height: 10,),
                  // txtField(venueController, widget.selectedOverall.venue.toString(), 'Venue', true),
                  SizedBox(height: 10,),
                  txtField(stimeController, widget.selectedOverall.stime.toString(), 'Start Time', true),
                  SizedBox(height: 10,),
                  txtField(etimeController, widget.selectedOverall.etime.toString(), 'End Time', true),
                  SizedBox(height: 10,),
                  timeTxtField(ftenmController, widget.selectedOverall.ftenm.toString(), 'First Ten Minutes', false),
                  SizedBox(height: 10,),
                  timeTxtField(mtenmController, widget.selectedOverall.mtenm.toString(), 'Middle Ten Minutes', false),
                  SizedBox(height: 10,),
                  timeTxtField(ltenmController, widget.selectedOverall.ltenm.toString(), 'Last Ten Minutes', false),
                  SizedBox(height: 10,),
                  updateButton,
                ], 
              ),
            ),
          ),
        ),
      );
  } 

  TextFormField txtField(TextEditingController ctrl, String htext,String ltext, bool read){
  return TextFormField(
      controller: ctrl,
      readOnly: read,
      decoration: InputDecoration(
        labelText: ltext,
        hintText: htext,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
}

TextFormField timeTxtField(TextEditingController ctrl, String htext,String ltext, bool read){
  return TextFormField(
      controller: ctrl,
      readOnly: read,
      decoration: InputDecoration(
        labelText: ltext,
        hintText: htext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),

      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],

      onChanged: (val) {
          String y = "";
          switch (val.length) {
            case 0:
              setState(() {
                hrCounter = "00";
                minCounter = "00";
                secCounter = "00";
              });
              break;
            case 1:
              setState(() {
                secCounter = "0" + val;
                temp = val;
                ctrl.value = ctrl.value.copyWith(
                  text: hrCounter + ":" + minCounter + ":" + secCounter,
                  selection: const TextSelection.collapsed(offset: 8),
                );
              });
              break;
            default:
              setState(() {
                for (int i = 1; i <= val.length - 1; i++) {
                  y = y + val.substring(i, i + 1);
                }
                y = y.replaceAll(":", "");
                val = y.substring(0, 2) +
                    ":" +
                    y.substring(2, 4) +
                    ":" +
                    y.substring(4, 6);
                temp = val;
                ctrl.value = ctrl.value.copyWith(
                  text: val,
                  selection: const TextSelection.collapsed(offset: 8),
                );
              });
              break;
          }
       }
    );
}

}



// --->>> DATA TABLE BODY <<<--- //
// body: SafeArea(
//           child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Text('TID: '+'${widget.selectedOverall.tid.toString()}',style: TextStyle(fontSize: 20),),
//                 SizedBox(height: 20,),

//                 DataTable(
//                       columnSpacing: 38.0,
//                       border: TableBorder.all(color: Colors.blue,borderRadius: BorderRadius.circular(10),width: 3 ),
//                       columns: [
//                         DataColumn(label: Text('ID: ${widget.selectedOverall.tid}')),
//                         DataColumn(label: Text('Tid')),
//                         DataColumn(label: Text('Day')),
//                         DataColumn(label: Text('Teacher')),
//                         DataColumn(label: Text('Course')),
//                         DataColumn(label: Text('Venue')),
//                         DataColumn(label: Text('Time')),
//                       ],
//                       rows: List.generate(widget.selectedTimeTable.length, (index) {
//                         final sectionname = widget.selectedTimeTable[index].sectionname.toString();
//                         final tid = widget.selectedTimeTable[index].tid.toString();
//                         final day = widget.selectedTimeTable[index].dayy.toString();
//                         final teacher = widget.selectedTimeTable[index].teachername.toString();
//                         final subject = widget.selectedTimeTable[index].coursename.toString();
//                         final venue = widget.selectedTimeTable[index].venue.toString();
//                         final time = widget.selectedTimeTable[index].stime.toString() + ' - ' + widget.selectedTimeTable[index].etime.toString();
//                         // print(index);
//                         // print(sectionname);
//                         // print(day);
//                         // print(teacher);
//                         // print(subject);
//                         // print(venue);
//                         // print(time);
//                         // final _cid = sectionTable[index].subject.toString() + '_(${sectionTable[index].teachername.toString()})';
//                         // final _cname = sectionTable[index].subject.toString() + '_(${sectionTable[index].teachername.toString()})';
//                         // final _sid = timeTable[index].sid.toString();
//                         // final _sname = timeTable[index].sname.toString();
//                         // final _ctid = timeTable[index].ctid.toString();
//                         // final _ctname = timeTable[index].ctname.toString();
                  
//                         return DataRow(
//                           cells: [
//                           // DataCell(Container(child: Text('8:30 - 10:30'))),
//                           DataCell(Text('')),
//                           DataCell(Text(tid)),
//                           DataCell(
//                             Text(day),
//                             showEditIcon: true,
//                             ),
//                           DataCell(Text(teacher)),
//                           DataCell(Text(subject)),
//                           DataCell(Text(venue)),
//                           DataCell(Text(time)),
//                           // DataCell(Container(child: Text(_sid))),
//                           // DataCell(Container(child: Text(_sname))),
//                           // DataCell(Container(child: Text(_ctid))),
//                           // DataCell(Container(child: Text(_ctname))),
//                         ]);
//                       }
                      
//                       // rows: [
//                       //   DataRow(
//                       //     cells: [
//                       //       DataCell(Container(child: Text(''))),
//                       //     DataCell(Container(child: Text(_overall.day))),
//                       //     DataCell(Container(child: Text(_overall.teachername))),
//                       //     DataCell(Container(child: Text(_overall.subject))),
//                       //     DataCell(Container(child: Text(_overall.venue))),
//                       //     DataCell(Container(child: Text(_overall.time))),
//                       //     ]
//                       //   )
//                       // ],
                      
//                       ),
//                     ),
                
//                 SizedBox(height: 20,),
//                 //Expanded(child: dayField),
                
//               ], 
//             ),
//           ),
//             ),
//         ),