import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddMakeUpClass extends StatefulWidget {
  const AddMakeUpClass({ Key? key}) : super(key: key);

  @override
  State<AddMakeUpClass> createState() => _AddMakeUpClassState();
}

class _AddMakeUpClassState extends State<AddMakeUpClass> {


  String hrCounter = '00';
  String minCounter = '00';
  String secCounter = '00';
  String temp="";

  final TextEditingController mcidController = new TextEditingController();
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
  addMakeUpClass() async {

    setState(() {
      // tidController.text = widget.selectedOverall.tid.toString();
      // teachernameController.text = widget.selectedOverall.teachername.toString();
      // dayyController.text = widget.selectedOverall.dayy.toString();
      // coursenameController.text = widget.selectedOverall.coursename.toString();
      // sectionnameController.text = widget.selectedOverall.sectionname.toString();
      // venueController.text = widget.selectedOverall.venue.toString();
      // stimeController.text = widget.selectedOverall.stime.toString();
      // etimeController.text = widget.selectedOverall.etime.toString();
      ftenmController.text = "00:00:00";
      mtenmController.text = "00:00:00";
      ltenmController.text = "00:00:00";
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/MakeUpClass/addMakeUpClass'),
      body:{
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("MakeUp Class Added Successfully!",style: TextStyle(fontFamily: 'Montserrat Regular')),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Add MakeUp Class!');
    }
  }

  @override
  Widget build(BuildContext context) { 

    // ADD BUTTON //
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
            addMakeUpClass();
          },
          child: Text("Add",textAlign: TextAlign.center,
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
          title: Text('Add MakeUp Class'),
        ),
    
        // bottomNavigationBar: SafeArea(
        //     child: Container(
        //           width: double.infinity,
        //           padding: EdgeInsets.all(12),
        //           // color: Colors.black,
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               shape: StadiumBorder(),
        //               minimumSize: Size.fromHeight(40),
        //             ),
        //             child: Text('Select ${selectedSections.length} Records'),
        //             onPressed: (){
        //               //Navigator.push(context, MaterialPageRoute(builder: (context) => SectionOnClick(overall: uniquelist[index],sectiontimetable:data,)));
        //             },
        //           ),
        //         )
        //   ),
    
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  txtField(teachernameController, 'Enter Teacer Name', 'Teacher Name', false),
                  SizedBox(height: 10,),
                  txtField(dayyController, 'Enter Day', 'Day', false),
                  SizedBox(height: 10,),
                  txtField(coursenameController, 'Enter Course Name', 'Course', false),
                  SizedBox(height: 10,),
                  txtField(sectionnameController, 'Enter Section Name', 'Section', false),
                  SizedBox(height: 10,),
                  txtField(venueController, 'Enter Venue', 'Venue', false),
                  SizedBox(height: 10,),
                  timeTxtField(stimeController, 'Enter Class Start Time: 00:00:00', 'Start Time', false),
                  SizedBox(height: 10,),
                  timeTxtField(etimeController, 'Enter Class End Time: 00:00:00', 'End Time', false),
                  // SizedBox(height: 10,),
                  // timeTxtField(ftenmController, '', 'First Ten Minutes', false),
                  // SizedBox(height: 10,),
                  // timeTxtField(mtenmController, '', 'Middle Ten Minutes', false),
                  // SizedBox(height: 10,),
                  // timeTxtField(ltenmController, '', 'Last Ten Minutes', false),
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


