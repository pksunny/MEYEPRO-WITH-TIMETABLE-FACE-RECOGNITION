import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:m_eye_gui/7-Setting%20Screen/3-Facial%20Recognition%20Screen/TeacherImageUploadPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FacialRecognitionPage extends StatefulWidget {
  const FacialRecognitionPage({Key? key}) : super(key: key);

  @override
  _FacialRecognitionPageState createState() => _FacialRecognitionPageState();
}

class _FacialRecognitionPageState extends State<FacialRecognitionPage> {

  var feedback = "Successfulyy Applied";

  final CheckBoxList = [
    CheckBoxState(title: 'Verify Specific Teacher'),
    CheckBoxState(title: 'Verify All Teacher'),
  ];


  // IMAGE PICKER //
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar : AppBar(
          title: Text('Facial Recognition'),
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
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            height: 60,
            color: Colors.black12,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherImageUploadPage(),),);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: Theme.of(context).accentColor,
                    ),
                    Text('Add New Teacher Photo'),
                  ],
                ),
              ),
            ),
          ),
        ),
    
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(5),
                width: width*0.8,
                height: height*0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  color: Colors.transparent,
                ),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.blue,
                  margin: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: height*0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(height: height*0.03,),
            
                      ...CheckBoxList.map(buildSingleCheckBox).toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.03,),
              Padding(
                padding: EdgeInsets.only(left: 70,right: 70),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueAccent,
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: (){},
                    child: Text("Apply",textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            
          ),
        ),
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
    value: checkbox.value,
    onChanged: (val){
      setState(() {
        checkbox.value = val!;
      });
    },
    activeColor: Colors.blue,
    title: Text(checkbox.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
  );

}


class CheckBoxState
{
  final String title;
  bool value;

  CheckBoxState({required this.title,this.value = false});
}
