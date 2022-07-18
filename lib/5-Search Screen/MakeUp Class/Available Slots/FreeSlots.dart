// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/RegistrationScreen.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Home%20Screen/TeacherHomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/AddMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/Available%20Slots/FreeSlotsOnClick.dart';
import 'package:m_eye_gui/5-Search%20Screen/MakeUp%20Class/MakeUp%20Section/ViewSectionMakeUpClass.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// GLOBAL VAR //

int? mlid;
String? teachername1, sectionname1;

class FreeSlots extends StatefulWidget {
  const FreeSlots({Key? key}) : super(key: key);

  @override
  _FreeSlotsState createState() => _FreeSlotsState();
}

class _FreeSlotsState extends State<FreeSlots> {
  // void initState() {
  //   super.initState();
  //   teacherSectionFreeSlots();
  // }

  // // SCAFFOLD //
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  // // FORM VALIDATION //
  // final _formKey = GlobalKey<FormState>();

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController teacherNameController = TextEditingController();
  final TextEditingController sectionNameController = TextEditingController();

  // BUTTON CHANGED //
  bool changedButton = false;

  // PASSWORD HIDE & SHOW //
  bool hidePass = true;

  // LOGIN FUNCTION //
  List<TimeTable> freeSlots = [];

  Future<void> teacherSectionFreeSlots() async {
    if (teacherNameController.text.isNotEmpty &&
        sectionNameController.text.isNotEmpty) {
      var response = await http.get(
        Uri.parse(ApiUrl.apiUrl +
            "meyepro/api/TimeTable/FetchVaccantClasses?teachername=" +
            teacherNameController.text +
            "&sectionname=" +
            sectionNameController.text),
      );
      if (response.statusCode == 200) {
        Iterable listt = jsonDecode(response.body);
        freeSlots = listt.map((e) => TimeTable.fromJson(e)).toList();
        print(listt);

        setState(() {

        });

        // teachername1 = responseData[0]['teachername'];
        // sectionname1 = responseData[0]['sectionname'];

        // print(teachername1.toString() + ' ' + sectionname1.toString());

        // Navigator.push(context, MaterialPageRoute(builder: (context) => FreeSlotsOnClick(),));
      }
      else
        throw Exception('Failed to load data');
    }
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

  // VALIDATOR //
  // bool validateAndSave() {
  //   final form = _formKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

  @override
  Widget _uiSetup(BuildContext context) {
    //EMAIL
    final teacherNameField = TextFormField(
      autofocus: false,
      controller: teacherNameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        teacherNameController.text = value!;
      },
      validator: (input) {
        if (input!.isEmpty) {
          return 'Teacher Name Cannot Be Empty';
        }
        // else if(input != input.contains('@'))
        // {
        //   return 'Email Must Have @';
        // }
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

    //PASSWORD
    final sectionNameField = TextFormField(
      autofocus: false,
      // obscureText: hidePass,
      controller: sectionNameController,

      onSaved: (value) {
        sectionNameController.text = value!;
      },
      validator: (input) {
        if (input!.isEmpty) {
          return 'Section Name Cannot Be Empty';
        }
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.class_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Section Name     Format: BSCS-8C',
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
            teacherSectionFreeSlots();
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
          TabItem(icon: Icons.note_add_rounded, title: 'Add MakeUp Class'),
          // TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.home, title: 'Home'),
          // TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.view_array_rounded, title: 'View MakeUp'),
        ],
        initialActiveIndex: 1, //optional, default as 0
        elevation: 10,
        onTap: (int i) {
          if(i == 0)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMakeUpClass()));
          }
          else if(i == 1)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
          else if(i == 2)
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const ViewSectionMakeUpClass()));
          }
        }
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
                  child: sectionNameField,
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: applyButton,
                ),
        
        
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: freeSlots.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(freeSlots[index].venue.toString() + ' (Free On) ' + freeSlots[index].dayy.toString()),
                              subtitle: Text(freeSlots[index].stime.toString() + ' - ' + freeSlots[index].etime.toString()),
                            ),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MultiLoginTable{
//   late String? email,password,mode;
//   late int mlid;
//   MultiLoginTable(
//       {
//         required this.mlid,
//         required this.email,
//         required this.password,
//         required this.mode,
//       });
//   factory MultiLoginTable.fromJson(Map<String,dynamic>json)
//   {
//     return MultiLoginTable(
//       mlid:json['mlid'],
//       email:json['email'],
//       password:json['password'],
//       mode: json['mode']
//     );
//   }
// }
