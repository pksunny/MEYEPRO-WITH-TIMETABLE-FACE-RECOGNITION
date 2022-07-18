import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../main.dart';


class SignupTeacher extends StatefulWidget {
  const SignupTeacher({Key? key}) : super(key: key);

  @override
  _SignupTeacherState createState() => _SignupTeacherState();
}

class _SignupTeacherState extends State<SignupTeacher> {

  final _formKey = GlobalKey<FormState>();

  // final TextEditingController firstNameEditingController = new TextEditingController();
  // final TextEditingController lastNameEditingController = new TextEditingController();
  final TextEditingController nameEditingController = new TextEditingController();
  final TextEditingController emailEditingController = new TextEditingController();
  final TextEditingController passwordEditingController = new TextEditingController();
  final TextEditingController confirmpasswordEditingController = new TextEditingController();

  var mode = 'teacher';
  addTeacher() async
  {
    var response=null;
    if(emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty && confirmpasswordEditingController.text.isNotEmpty)
    {
      if(passwordEditingController.text==confirmpasswordEditingController.text){


          response=await http.post(Uri.parse(ApiUrl.apiUrl + "meyepro/api/MultiLogin/addAdminTeacher"),
              body:
              {
                "name": nameEditingController.text,
                "email":emailEditingController.text,
                "password":passwordEditingController.text,
                "mode":mode.toString()
              }
          );
          if(response.statusCode==200)
          {

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Teacher Successfully added!"),));
            // if(mode=="teacher"){
            //   // Navigator.push(context, MaterialPageRoute(builder: (context) => CarePerson(),),);
            // }
            // if(mode=="teacher"){
            //   // Navigator.push(context, MaterialPageRoute(builder: (context) => Set_for_Child(),),);
            // }
          }
          else
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid data."),));
          }
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password not mached."),));
      }
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("blank field not allowed."),));
    }
  }

  @override
  Widget build(BuildContext context) {

    // // FIRSTNAME //
    // final firsNameField = TextFormField(
    //   autofocus: false,
    //   controller: firstNameEditingController,
    //   keyboardType: TextInputType.name,

    //   onSaved: (value){
    //     firstNameEditingController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.account_circle),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: 'First Name',
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       )
    //   ),
    // );

    // // LAST NAME
    // final lastNameField = TextFormField(
    //   autofocus: false,
    //   controller: lastNameEditingController,
    //   keyboardType: TextInputType.name,

    //   onSaved: (value){
    //     lastNameEditingController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.account_circle),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: 'Last Name',
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       )
    //   ),
    // );

    //NAME
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.text,

      onSaved: (value){
        nameEditingController.text = value!;
      },
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Name Cannot Be Empty';
        }
        
        // else if(input == input.contains(emailEditingController.text))
        // {
        //   return 'Email Already Exist';
        // }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //EMAIL
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,

      onSaved: (value){
        emailEditingController.text = value!;
      },
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Email Cannot Be Empty';
        }
        else if(input != input.contains('@'))
        {
          return 'Email Must Have @';
        }
        // else if(input == input.contains(emailEditingController.text))
        // {
        //   return 'Email Already Exist';
        // }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //PASSWORD
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordEditingController,
      keyboardType: TextInputType.text,

      onSaved: (value){
        passwordEditingController.text = value!;
      },
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Password Cannot Be Empty';
        }
        else if(input.length < 5)
        {
          return 'Password Must be greater than 5';
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //CONFIRM PASSWORD
    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpasswordEditingController,
      keyboardType: TextInputType.text,

      onSaved: (value){
        confirmpasswordEditingController.text = value!;
      },
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Password Cannot Be Empty';
        }
        else if(input.length < 5)
        {
          return 'Password Must be greater than 5';
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Confirm Password',
          // hintStyle: TxtStyle.editTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //SIGNUP BUTTON
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async{
          await addTeacher();
        },
        child: Text("Signup",textAlign: TextAlign.center,
          style: TxtStyle.appbartextstyle
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        title: Text('SignUp',style: TxtStyle.appbartextstyle,),
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
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 150,
                        child: Image.asset('assets/images/cctv.png',fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text('M EYE PRO',textAlign: TextAlign.center,
                        style: TxtStyle.boldtxtstyle,
                      ),
                      // SizedBox(height: 15,),
                      // firsNameField,
                      // SizedBox(height: 20,),
                      // lastNameField,
                      SizedBox(height: 30,),
                      nameField,
                      SizedBox(height: 20,),
                      emailField,
                      SizedBox(height: 20,),
                      passwordField,
                      SizedBox(height: 20,),
                      confirmPasswordField,
                      SizedBox(height: 25,),
                      signupButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
