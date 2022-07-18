// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/RegistrationScreen.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Home%20Screen/TeacherHomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlotsOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/6.1-%20CHR/CHR.dart';
import 'package:m_eye_gui/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'PDFAPI.dart';

class GetSpecificCHR extends StatefulWidget {
  const GetSpecificCHR({Key? key}) : super(key: key);

  @override
  _GetSpecificCHRState createState() => _GetSpecificCHRState();
}

class _GetSpecificCHRState extends State<GetSpecificCHR> {

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController indateController = TextEditingController();
  final TextEditingController dayyController = TextEditingController();
  final TextEditingController sectionNameController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  // BUTTON CHANGED //
  bool changedButton = false;

  // PASSWORD HIDE & SHOW //
  bool hidePass = true;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // LOGIN FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getSpecificCHR?name=" + nameController.text +
            "&indate=" + indateController.text +
            "&dayy=" + dayyController.text +
            "&sectionname=" + sectionNameController.text +
            "&venue=" + venueController.text + 
            "&status=" + statusController.text
            )
      );
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //NAME
    final teacherNameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Teacher Name     Format: Mr Umer',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //INDATE
    final indateField = TextFormField(
      autofocus: false,
      controller: indateController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        indateController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Date     Format: 2022-06-17',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //DAY
    final dayyField = TextFormField(
      autofocus: false,
      controller: dayyController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        dayyController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Day     Format: Friday',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //SECTION
    final sectionNameField = TextFormField(
      autofocus: false,
      controller: sectionNameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        sectionNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Section Name     Format: BSCS-4B',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //VENUE
    final venueField = TextFormField(
      autofocus: false,
      controller: venueController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        venueController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Venue     Format: LT-2/LAB-2',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //Status
    final statusField = TextFormField(
      autofocus: false,
      controller: statusController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        statusController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Status     Format: Held On Time/Not Held On Time',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            SpecificCHR();
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Free Slots'),
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
                ]),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) {
          if(i == 0)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMakeUpClass()));
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: teacherNameField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: indateField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: dayyField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: sectionNameField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: venueField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: statusField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),
        
        
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
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
                      rows: List.generate(specificCHR.length, (index) {
                        // final dvrid = dvrTable[index].dvrid.toString();
                        final teachername = specificCHR[index].name.toString();
                        final intime = specificCHR[index].intime.toString();
                        final outtime = specificCHR[index].outime.toString();
                        final indate = specificCHR[index].indate.toString();
                        final dayy = specificCHR[index].dayy.toString();
                        final sectionname = specificCHR[index].sectionname.toString();
                        final coursename = specificCHR[index].coursename.toString();
                        final venue = specificCHR[index].venue.toString();
                        final stime = specificCHR[index].stime.toString();
                        final etime = specificCHR[index].etime.toString();
                        return DataRow(cells: [
                          // DataCell(Text(dvrid),showEditIcon: true),
                          DataCell(Text(teachername)),
                          DataCell(Text(intime)),
                          DataCell(Text(outtime)),
                          DataCell(Text(indate)),
                          DataCell(Text(dayy)),
                          DataCell(Text(sectionname)),
                          DataCell(Text(coursename)),
                          DataCell(Text(venue)),
                          DataCell(Text(stime)),
                          DataCell(Text(etime)),
                          
                        ]);
                      }),
                    ),
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



// ------------------ SPECIFIC TEACHER CHR PAGE ---------------------------
TextEditingController? nameController = TextEditingController();


class SpecificTeacherCHR extends StatefulWidget {
  const SpecificTeacherCHR({Key? key}) : super(key: key);

  @override
  _SpecificTeacherCHRState createState() => _SpecificTeacherCHRState();
}

class _SpecificTeacherCHRState extends State<SpecificTeacherCHR> {


  // EMAIL & PASSWORD CONTROLLER //
  // final TextEditingController nameController = TextEditingController();

  // BUTTON CHANGED //
  bool changedButton = false;


  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificTeacherCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getTeacherCHR?name=" + nameController!.text));
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //NAME
    final teacherNameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        nameController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Teacher Name     Format: Mr Umer',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            SpecificTeacherCHR();
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Specific Teacher CHR'),
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
                ]),
          ),
        ),
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
            final pdfFile = await PdfApi.SpecificTeacherCHR();

            PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: teacherNameField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),

                SizedBox(height: 15,),
                  Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 15,),
                  Text('Class Held Report',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 10,),
        
        
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: specificCHR.isNotEmpty ? DataTable(
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
                      rows: List.generate(specificCHR.length, (index) {
                        // final dvrid = dvrTable[index].dvrid.toString();
                        final teachername = specificCHR[index].name.toString();
                        final intime = specificCHR[index].intime.toString();
                        final outtime = specificCHR[index].outime.toString();
                        final indate = specificCHR[index].indate.toString();
                        final dayy = specificCHR[index].dayy.toString();
                        final sectionname = specificCHR[index].sectionname.toString();
                        final coursename = specificCHR[index].coursename.toString();
                        final venue = specificCHR[index].venue.toString();
                        final stime = specificCHR[index].stime.toString();
                        final etime = specificCHR[index].etime.toString();
                        return DataRow(cells: [
                          // DataCell(Text(dvrid),showEditIcon: true),
                          DataCell(Text(teachername)),
                          DataCell(Text(intime)),
                          DataCell(Text(outtime)),
                          DataCell(Text(indate)),
                          DataCell(Text(dayy)),
                          DataCell(Text(sectionname)),
                          DataCell(Text(coursename)),
                          DataCell(Text(venue)),
                          DataCell(Text(stime)),
                          DataCell(Text(etime)),
                          
                        ]);
                      }),
                    ) : Card(
                        elevation: 10,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Icon(Icons.search_off,size: 50,color: Colors.blue,),
                                Text('No Record Found!',style: TxtStyle.boldtxtstyleblue,)
                              ],
                            ),
                          )
                        ),
                      )
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



// ------------------ SPECIFIC DATE CHR PAGE ---------------------------
TextEditingController? indateController = TextEditingController();
String? indate;

class SpecificDateCHR extends StatefulWidget {
  const SpecificDateCHR({Key? key}) : super(key: key);

  @override
  _SpecificDateCHRState createState() => _SpecificDateCHRState();
}

class _SpecificDateCHRState extends State<SpecificDateCHR> {

  // BUTTON CHANGED //
  bool changedButton = false;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // LOGIN FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getDateCHR?indate=" + indateController!.text));
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {
          indate = indateController!.text.toString();
        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //

  final _formKey = GlobalKey<FormState>();

  // SCAFFOLD //
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // VALIDATOR //
  bool validateAndSave()
  {
    final form = _formKey.currentState;
    if(form!.validate())
    {
      form.save();
      return true;
    }
    return false;

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //INDATE
    final indateField = TextFormField(
      autofocus: false,
      controller: indateController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        indateController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Date Cannot Be Empty';
        }
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Date     Format: 2022-06-17',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 1));
            if(validateAndSave()){
              setState(() {
                isApiCallProcess = true;
              });
            }
            SpecificCHR().then((value) {
              setState(() {
                isApiCallProcess = false; 
              });
            });
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Specific Date CHR'),
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
                ]),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async {
          if(i == 0)
          {
             final pdfFile = await PdfApi.SpecificDateCHR();

             PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: indateField,
                  ),
                  
                  Container(
                    margin: EdgeInsets.all(7),
                    child: applyButton,
                  ),
                  

                  SizedBox(height: 15),
                  indateController!.text.isNotEmpty 
                      ? Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}', style: TxtStyle.cardtextstyle2) 
                      : Text('{invalid date}'),
          
                  SizedBox(height: 15,),
                  Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 15,),
                  Text('Class Held Report ${indateController?.text.toString()}',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 10,),
                  
                  
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: specificCHR.isNotEmpty ? DataTable(
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
                        rows: List.generate(specificCHR.length, (index) {
                          // final dvrid = dvrTable[index].dvrid.toString();
                          final teachername = specificCHR[index].name.toString();
                          final intime = specificCHR[index].intime.toString();
                          final outtime = specificCHR[index].outime.toString();
                          final indate = specificCHR[index].indate.toString();
                          final dayy = specificCHR[index].dayy.toString();
                          final sectionname = specificCHR[index].sectionname.toString();
                          final coursename = specificCHR[index].coursename.toString();
                          final venue = specificCHR[index].venue.toString();
                          final stime = specificCHR[index].stime.toString();
                          final etime = specificCHR[index].etime.toString();
                          return DataRow(cells: [
                            // DataCell(Text(dvrid),showEditIcon: true),
                            DataCell(Text(teachername)),
                            DataCell(Text(intime)),
                            DataCell(Text(outtime)),
                            DataCell(Text(indate)),
                            DataCell(Text(dayy)),
                            DataCell(Text(sectionname)),
                            DataCell(Text(coursename)),
                            DataCell(Text(venue)),
                            DataCell(Text(stime)),
                            DataCell(Text(etime)),
                            
                          ]);
                        }),
                      ) : Card(
                        elevation: 10,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Icon(Icons.search_off,size: 50,color: Colors.blue,),
                                Text('No Record Found!',style: TxtStyle.boldtxtstyleblue,)
                              ],
                            ),
                          )
                        ),
                      )
                    ),
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



// ------------------ SPECIFIC DAY CHR PAGE ---------------------------
TextEditingController? dayyController = TextEditingController();

class SpecificDayCHR extends StatefulWidget {
  const SpecificDayCHR({Key? key}) : super(key: key);

  @override
  _SpecificDayCHRState createState() => _SpecificDayCHRState();
}

class _SpecificDayCHRState extends State<SpecificDayCHR> {

  // BUTTON CHANGED //
  bool changedButton = false;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // LOGIN FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getDayCHR?dayy=" + dayyController!.text));
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //DAY
    final dayField = TextFormField(
      autofocus: false,
      controller: dayyController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        dayyController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Day     Format: Friday',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),        
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            SpecificCHR();
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Specific Day CHR'),
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
                ]),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async {
          if(i == 0)
          {
             final pdfFile = await PdfApi.SpecificDayCHR();

             PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: dayField,
                ),
                
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),
        
        
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
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
                      rows: List.generate(specificCHR.length, (index) {
                        // final dvrid = dvrTable[index].dvrid.toString();
                        final teachername = specificCHR[index].name.toString();
                        final intime = specificCHR[index].intime.toString();
                        final outtime = specificCHR[index].outime.toString();
                        final indate = specificCHR[index].indate.toString();
                        final dayy = specificCHR[index].dayy.toString();
                        final sectionname = specificCHR[index].sectionname.toString();
                        final coursename = specificCHR[index].coursename.toString();
                        final venue = specificCHR[index].venue.toString();
                        final stime = specificCHR[index].stime.toString();
                        final etime = specificCHR[index].etime.toString();
                        return DataRow(cells: [
                          // DataCell(Text(dvrid),showEditIcon: true),
                          DataCell(Text(teachername)),
                          DataCell(Text(intime)),
                          DataCell(Text(outtime)),
                          DataCell(Text(indate)),
                          DataCell(Text(dayy)),
                          DataCell(Text(sectionname)),
                          DataCell(Text(coursename)),
                          DataCell(Text(venue)),
                          DataCell(Text(stime)),
                          DataCell(Text(etime)),
                          
                        ]);
                      }),
                    ),
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


// ------------------ SPECIFIC SECTION CHR PAGE ---------------------------
TextEditingController? sectionController = TextEditingController();

class SpecificSectionCHR extends StatefulWidget {
  const SpecificSectionCHR({Key? key}) : super(key: key);

  @override
  _SpecificSectionCHRState createState() => _SpecificSectionCHRState();
}

class _SpecificSectionCHRState extends State<SpecificSectionCHR> {


  // BUTTON CHANGED //
  bool changedButton = false;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // LOGIN FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + "meyepro/api/CHR/getSectionCHR?sectionname=" + sectionController!.text));
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //DAY
    final dayField = TextFormField(
      autofocus: false,
      controller: sectionController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        sectionController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Section     Format: BSCS-1A',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            SpecificCHR();
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Specific Section CHR'),
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
                ]),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async {
          if(i == 0)
          {
             final pdfFile = await PdfApi.SpecificSectionCHR();

             PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: dayField,
                ),
                
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),
        
        
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
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
                      rows: List.generate(specificCHR.length, (index) {
                        // final dvrid = dvrTable[index].dvrid.toString();
                        final teachername = specificCHR[index].name.toString();
                        final intime = specificCHR[index].intime.toString();
                        final outtime = specificCHR[index].outime.toString();
                        final indate = specificCHR[index].indate.toString();
                        final dayy = specificCHR[index].dayy.toString();
                        final sectionname = specificCHR[index].sectionname.toString();
                        final coursename = specificCHR[index].coursename.toString();
                        final venue = specificCHR[index].venue.toString();
                        final stime = specificCHR[index].stime.toString();
                        final etime = specificCHR[index].etime.toString();
                        return DataRow(cells: [
                          // DataCell(Text(dvrid),showEditIcon: true),
                          DataCell(Text(teachername)),
                          DataCell(Text(intime)),
                          DataCell(Text(outtime)),
                          DataCell(Text(indate)),
                          DataCell(Text(dayy)),
                          DataCell(Text(sectionname)),
                          DataCell(Text(coursename)),
                          DataCell(Text(venue)),
                          DataCell(Text(stime)),
                          DataCell(Text(etime)),
                          
                        ]);
                      }),
                    ),
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


// ------------------ TEACHER+DATE CHR PAGE ---------------------------
// TextEditingController? sectionController = TextEditingController();

class TeacherDateCHR extends StatefulWidget {
  const TeacherDateCHR({Key? key}) : super(key: key);

  @override
  _TeacherDateCHRState createState() => _TeacherDateCHRState();
}

class _TeacherDateCHRState extends State<TeacherDateCHR> {


  // BUTTON CHANGED //
  bool changedButton = false;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));

  // LOGIN FUNCTION //
  List<CHRTable> specificCHR = [];

  Future<void> SpecificCHR() async { 
      var response = await http.get(Uri.parse(ApiUrl.apiUrl + 
        "meyepro/api/CHR/getTeacherDateCHR?name=" + nameController!.text + 
        "&indate=" + indateController!.text
      ));
      if (response.statusCode == 200) 
      {
        Iterable listt = jsonDecode(response.body);
        specificCHR = listt.map((e) => CHRTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });
      }
      else
        throw Exception('Failed to load data');
    
  }

  // CIRCULAR PROGRESS INDICATOR //
  bool isApiCallProcess = false;
  // CIRCULAR PROGRESS INDICATOR FUNCTION //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }


  @override
  Widget _uiSetup(BuildContext context) {
    //NAME
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        nameController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Name     Format: Mr Umer',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //IN DATE
    final indateField = TextFormField(
      autofocus: false,
      controller: indateController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        indateController!.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'In Date     Format: 2022-06-17',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Apply BUTTON //
    final applyButton = AnimatedContainer(
      width: changedButton ? 85 : MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            SpecificCHR();
          },
          child: Text(
            "Apply",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher+Date CHR'),
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
                ]),
          ),
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.picture_as_pdf
          , title: 'Generate PDF'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        elevation: 10,
        onTap: (int i) async {
          if(i == 0)
          {
             final pdfFile = await PdfApi.TeacherDateCHR();

             PdfApi.openFile(pdfFile);
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: nameField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: indateField,
                ),
                
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),

                SizedBox(height: 15),
                  indateController!.text.isNotEmpty 
                      ? Text('{${DateFormat('EEEE').format(DateTime.parse(indateController!.text.toString()))}}', style: TxtStyle.cardtextstyle2) 
                      : Text('{invalid date}'),
          
                  SizedBox(height: 15,),
                  Text('BARANI INSTITUTE OF INFORMATION AND TECHNOLOGY',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 15,),
                  Text('Class Held Report ${indateController?.text.toString()}',style: TxtStyle.boldtxtstyleblue,),
          
                  SizedBox(height: 10,),
        
        
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: specificCHR.isNotEmpty ? DataTable(
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
                      rows: List.generate(specificCHR.length, (index) {
                        // final dvrid = dvrTable[index].dvrid.toString();
                        final teachername = specificCHR[index].name.toString();
                        final intime = specificCHR[index].intime.toString();
                        final outtime = specificCHR[index].outime.toString();
                        final indate = specificCHR[index].indate.toString();
                        final dayy = specificCHR[index].dayy.toString();
                        final sectionname = specificCHR[index].sectionname.toString();
                        final coursename = specificCHR[index].coursename.toString();
                        final venue = specificCHR[index].venue.toString();
                        final stime = specificCHR[index].stime.toString();
                        final etime = specificCHR[index].etime.toString();
                        return DataRow(cells: [
                          // DataCell(Text(dvrid),showEditIcon: true),
                          DataCell(Text(teachername)),
                          DataCell(Text(intime)),
                          DataCell(Text(outtime)),
                          DataCell(Text(indate)),
                          DataCell(Text(dayy)),
                          DataCell(Text(sectionname)),
                          DataCell(Text(coursename)),
                          DataCell(Text(venue)),
                          DataCell(Text(stime)),
                          DataCell(Text(etime)),
                          
                        ]);
                      }),
                    ) : Card(
                        elevation: 10,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Icon(Icons.search_off,size: 50,color: Colors.blue,),
                                Text('No Record Found!',style: TxtStyle.boldtxtstyleblue,)
                              ],
                            ),
                          )
                        ),
                      )
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


