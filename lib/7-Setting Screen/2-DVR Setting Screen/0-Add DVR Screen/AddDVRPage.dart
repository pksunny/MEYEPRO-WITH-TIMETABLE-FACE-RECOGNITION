import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class AddDVRPage extends StatefulWidget {
  const AddDVRPage({Key? key}) : super(key: key);

  @override
  _AddDVRPageState createState() => _AddDVRPageState();
}

class _AddDVRPageState extends State<AddDVRPage> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // ADD DVR FUNCTION //
  addDVR() async
  {
    var response=null;
    if(dvrNameController.text.isNotEmpty && ipAddressController.text.isNotEmpty && userNameController.text.isNotEmpty && passwordController.text.isNotEmpty && maxChannelController.text.isNotEmpty)
    {
      response=await http.post(Uri.parse(ApiUrl.apiUrl + "meyepro/api/DVR/addDVR"),
              body:
              {
                "dvrname":dvrNameController.text,
                "ipaddress":ipAddressController.text,
                "username":userNameController.text,
                "password":passwordController.text,
                "maxchannel":maxChannelController.text,
                // "role":_role.toString()
              }
          );
          if(response.statusCode==200)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("DVR Successfully added!"),));
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

    // DVR NAME FIELD
    final dvrField = TextFormField(
      controller: dvrNameController,


      onSaved: (value){
        dvrNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'DVR Name',
        hintText: 'Enter DVR Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'DVR name cannot be empty';
        }
        return null;
      },
    );

    // IP ADDRESS FIELD
    final ipAddressField = TextFormField(
      controller: ipAddressController,

      onSaved: (value){
        ipAddressController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'IP Address',
        hintText: 'Enter IP Address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'IP address cannot be empty';
        }
        return null;
      },
    );

    // USER NAME FIELD
    final userNameField = TextFormField(
      controller: userNameController,

      onSaved: (value){
        userNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'Enter User Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'User name cannot be empty';
        }
        return null;
      },
    );

    //PASSWORD FIELD
    final passwordField = TextFormField(
      controller: passwordController,

      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Password cannot be empty';
        }
        return null;
      },
    );

    // MAX CHANNEL FIELD
    final maxChannelField = TextFormField(
      controller: maxChannelController,

      keyboardType: TextInputType.number,

      onSaved: (value){
        maxChannelController.text = value!;
      },
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        labelText: 'Max Channel',
        hintText: 'Enter Max Channel',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Max channel cannot be empty';
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
            addDVR();
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
        title: Text('Add DVR'),
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
                            dvrField,
                            SizedBox(height: height*0.05,),
                            ipAddressField,
                            SizedBox(height: height*0.05,),
                            userNameField,
                            SizedBox(height: height*0.05,),
                            passwordField,
                            SizedBox(height: height*0.05,),
                            maxChannelField,
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

