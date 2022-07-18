import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class AddNewChannelPage extends StatefulWidget {
  const AddNewChannelPage({Key? key}) : super(key: key);

  @override
  _AddNewChannelPageState createState() => _AddNewChannelPageState();
}

class _AddNewChannelPageState extends State<AddNewChannelPage> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController cameraNameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController channelNumController = new TextEditingController();

  // ADD DVR FUNCTION //
  addCamera() async
  {
    var response=null;
    if(cameraNameController.text.isNotEmpty && channelNumController.text.isNotEmpty)
    {
      response=await http.post(Uri.parse(ApiUrl.apiUrl + "meyepro/api/Camera/addCamera"),
              body:
              {
                "cameraname":cameraNameController.text,
                "venue":venueController.text,
                "channelnum":channelNumController.text,
              }
          );
          if(response.statusCode==200)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Camera Successfully added!"),));
          }
          else
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid data."),));
          }
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("blank field not allowed."),));
    }
  }


  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // CAMERA NAME FIELD
    final cameraField = TextFormField(
      controller: cameraNameController,


      onSaved: (value){
        cameraNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'Camera Name',
        hintText: 'Enter Camera Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Camera name cannot be empty';
        }
        return null;
      },
    );

    // VENUE FIELD
    final venueField = TextFormField(
      controller: cameraNameController,


      onSaved: (value){
        cameraNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'Venue Name',
        hintText: 'Enter Venue Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Venue name cannot be empty';
        }
        return null;
      },
    );

    // CHANNEL NUM FIELD
    final channelNumField = TextFormField(
      controller: channelNumController,

      onSaved: (value){
        channelNumController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'Channel Num',
        hintText: 'Enter Channel Num',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Channel Num cannot be empty';
        }
        return null;
      },
    );

    // APPLY BUTTON FIELD
    final applyButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            addCamera();
          }
        },
        child: Text("Apply",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );


    return Scaffold(
      appBar : AppBar(
        title: Text('Add Camera'),
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
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*0.02,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Card(
                      elevation: 20,
                      shadowColor: Colors.black ,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white60,
                              Colors.white12,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height*0.03),
                            cameraField,
                            SizedBox(height: height*0.05,),
                            venueField,
                            SizedBox(height: height*0.05,),
                            channelNumField,
                            SizedBox(height: height*0.05,),
                            applyButton,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

