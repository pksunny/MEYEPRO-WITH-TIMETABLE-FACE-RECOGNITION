// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Teacher%20Search%20Screen/SearchScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TeacherMakeUpOnClickCheckBox extends StatefulWidget {
  const TeacherMakeUpOnClickCheckBox({ Key? key, required this.selectedOverall,required this.selectedTimeTable }) : super(key: key);

  final MakeUpClass selectedOverall;
  final List<MakeUpClass> selectedTimeTable;
  // SectionOnClickPage(this._overall);
  // final String sectionname;

  @override
  State<TeacherMakeUpOnClickCheckBox> createState() => _TeacherMakeUpOnClickCheckBoxState();
}

class _TeacherMakeUpOnClickCheckBoxState extends State<TeacherMakeUpOnClickCheckBox> {

  var stime1 = "08:30:00", etime1 = "10:00:00";
  var stime2 = "10:00:00", etime2 = "11:30:00";
  var stime3 = "11:30:00", etime3 = "01:00:00";
  var stime4 = "01:30:00", etime4 = "03:00:00";
  var stime5 = "03:00:00", etime5 = "04:30:00";

  var val1 = false, val2 = false, val3 = false;

  var ftenm1 = "08:30:00",mtenm1 = "09:10:00",ltenm1 = "09:50:00";
  var ftenm2 = "10:00:00",mtenm2 = "10:40:00",ltenm2 = "11:20:00";
  var ftenm3 = "11:30:00",mtenm3 = "12:10:00",ltenm3 = "12:50:00";
  var ftenm4 = "01:30:00",mtenm4 = "02:10:00",ltenm4 = "02:50:00";
  var ftenm5 = "03:00:00",mtenm5 = "03:40:00",ltenm5 = "04:20:00";

  var res1 = "00:00:00",res2="00:00:00",res3="00:00:00";

  var cardtextstyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 20,color: Color.fromRGBO(63, 63, 63, 1));

  final TextEditingController mcidController = new TextEditingController();
  final TextEditingController teachernameController = new TextEditingController();
  final TextEditingController dayyController = new TextEditingController();
  final TextEditingController coursenameController = new TextEditingController();
  final TextEditingController sectionnameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController stimeController = new TextEditingController();
  final TextEditingController etimeController = new TextEditingController();


  // -->> UPDATE API <<-- //
  updateTimeTable() async {

    setState(() {
      mcidController.text = widget.selectedOverall.mcid.toString();
      teachernameController.text = widget.selectedOverall.teachername.toString();
      dayyController.text = widget.selectedOverall.dayy.toString();
      coursenameController.text = widget.selectedOverall.coursename.toString();
      sectionnameController.text = widget.selectedOverall.sectionname.toString();
      venueController.text = widget.selectedOverall.venue.toString();
      stimeController.text = widget.selectedOverall.stime.toString();
      etimeController.text = widget.selectedOverall.etime.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/MakeUpClass/UpdateMakeUpClass'),
      body:{
        'mcid': mcidController.text,
        'teachername': teachernameController.text,
        'dayy': dayyController.text,
        'coursename': coursenameController.text,
        'sectionname': sectionnameController.text,
        'venue': venueController.text,
        'stime': stimeController.text,
        'etime': etimeController.text,
        'ftenm': res1.toString(),
        'mtenm': res2.toString(),
        'ltenm': res3.toString()
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
          title: Text(widget.selectedOverall.mcid.toString()),
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
            padding: EdgeInsets.all(5),
            width: double.infinity,
            //height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Colors.transparent,
            ),
            child: Card(
              elevation: 15,
              shadowColor: Colors.blue,
              margin:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'TID: ' + '${widget.selectedOverall.mcid.toString()}',
                    style: cardtextstyle,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("First Ten Minutes",style: cardtextstyle,),
                        Checkbox(
                          value: this.val1,
                          onChanged: (bool? value) {
                            setState(() {
                              if (widget.selectedOverall.stime == stime1 && widget.selectedOverall.etime == etime1) 
                              {
                                this.val1 = value!;
                                res1 = ftenm1;
                              } 
                              else if (widget.selectedOverall.stime == stime2 &&  widget.selectedOverall.etime == etime2) 
                              {
                                this.val1 = value!;
                                res1 = ftenm2;
                              }
                              else if (widget.selectedOverall.stime == stime3 && widget.selectedOverall.etime == etime3) 
                              {
                                this.val1 = value!;
                                res1 = ftenm3;
                              }
                              else if (widget.selectedOverall.stime == stime4 && widget.selectedOverall.etime == etime4) 
                              {
                                this.val1 = value!;
                                res1 = ftenm4;
                              }
                              else if (widget.selectedOverall.stime == stime5 && widget.selectedOverall.etime == etime5) 
                              {
                                this.val1 = value!;
                                res1 = ftenm5;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Middle Ten Minutes",style: cardtextstyle,),
                        Checkbox(
                          value: this.val2,
                          onChanged: (bool? value) {
                            setState(() {
                              if (widget.selectedOverall.stime == stime1 && widget.selectedOverall.etime == etime1) 
                              {
                                this.val2 = value!;
                                res2 = mtenm1;
                              } 
                              else if (widget.selectedOverall.stime == stime2 &&  widget.selectedOverall.etime == etime2) 
                              {
                                this.val2 = value!;
                                res2 = mtenm2;
                              }
                              else if (widget.selectedOverall.stime == stime3 && widget.selectedOverall.etime == etime3) 
                              {
                                this.val2 = value!;
                                res2 = mtenm3;
                              }
                              else if (widget.selectedOverall.stime == stime4 && widget.selectedOverall.etime == etime4) 
                              {
                                this.val2 = value!;
                                res2 = mtenm4;
                              }
                              else if (widget.selectedOverall.stime == stime5 && widget.selectedOverall.etime == etime5) 
                              {
                                this.val2 = value!;
                                res2 = mtenm5;
                              }
                              //etime = '10:00';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Last Ten Minutes",style: cardtextstyle,),
                        Checkbox(
                          value: this.val3,
                          onChanged: (bool? value) {
                            setState(() {
                              print(stime1);
                              if (widget.selectedOverall.stime == stime1 && widget.selectedOverall.etime == etime1) 
                              {
                                this.val3 = value!;
                                res3 = ltenm1;
                              } 
                              else if (widget.selectedOverall.stime == stime2 && widget.selectedOverall.etime == etime2) 
                              {
                                this.val3 = value!;
                                res3 = ltenm2;
                              }
                              else if (widget.selectedOverall.stime == stime3 && widget.selectedOverall.etime == etime3) 
                              {
                                this.val3 = value!;
                                res3 = ltenm3;
                              }
                              else if (widget.selectedOverall.stime == stime4 && widget.selectedOverall.etime == etime4) 
                              {
                                this.val3 = value!;
                                res3 = ltenm4;
                              }
                              else if (widget.selectedOverall.stime == stime5 && widget.selectedOverall.etime == etime5) 
                              {
                                this.val3 = value!;
                                res3 = ltenm5;
                              }
                              //etime = '10:00';
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: updateButton
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      );
  } 
}