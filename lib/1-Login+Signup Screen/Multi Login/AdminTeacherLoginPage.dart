// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/RegistrationScreen.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/3-HomeScreen/Teacher%20Home%20Screen/TeacherHomeScreen.dart';
import 'package:m_eye_gui/5-Search%20Screen/Section%20Search%20Screen/SectionSearchScreen.dart';
import 'package:m_eye_gui/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// GLOBAL VAR //

int? mlid;
String? name1,email1,mode1;

class AdminTeacherLoginPage extends StatefulWidget {
  const AdminTeacherLoginPage({Key? key}) : super(key: key);

  @override
  _AdminTeacherLoginPageState createState() => _AdminTeacherLoginPageState();
}

class _AdminTeacherLoginPageState extends State<AdminTeacherLoginPage> {

  void initState(){
   super.initState();
    // SetNotifications();
  }

  //_-_-_-_- SET NOTIFICATION API _-_-_-_-//
  SetNotifications() async {
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/TimeTable/SetNotifications'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Called!");
      //print(response.body);
      
      setState(() {

      });
    }
    else
    {
      throw Exception('Failed to update Record!');
    }
  }

  //_-_-_-_- NOTIFICATION END _-_-_-_-//



  // SCAFFOLD //
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // FORM VALIDATION //
  final _formKey = GlobalKey<FormState>();

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // BUTTON CHANGED //
  bool changedButton = false;

  // PASSWORD HIDE & SHOW //
  bool hidePass = true;

  // LOGIN FUNCTION //
  Future<void> adminteacherLogin() async
  {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {

      var response = await http.post(
        Uri.parse(ApiUrl.apiUrl + "meyepro/api/MultiLogin/LoginUser?email=" +
            emailController.text +
            "&password=" +
            passwordController.text ),

        // body: ({  
        //   'email': emailController.text,
        //   'password': passwordController.text,
        // }),

      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
         print(responseData);
         mlid=responseData[0]['mlid'];
         name1=responseData[0]['name'];
         email1=responseData[0]['email'];
         mode1 = responseData[0]['mode'];

         print(mlid.toString() + ' ' + name1.toString() + ' ' + mode1.toString());

        if (mode1 == 'admin') {
          // var mode = 'admin';
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        }
        if (mode1 == 'teacher') {
          // var mode = 'teacher';
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherHomeScreen()),);
        }
      }
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
  Widget _uiSetup(BuildContext context) {

    //EMAIL
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,

      onSaved: (value){
        emailController.text = value!;
      },
      validator: (input) {
        if(input!.isEmpty)
        {
          return 'Email Cannot Be Empty';
        }
        // else if(input != input.contains('@'))
        // {
        //   return 'Email Must Have @';
        // }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    //PASSWORD
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: hidePass,
      controller: passwordController,

      onSaved: (value){
        passwordController.text = value!;
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePass = !hidePass;
              });
            },
            icon: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    // LOGIN BUTTON //
    final loginButton = AnimatedContainer(
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
            changedButton = true;
            await Future.delayed(const Duration(seconds: 1));
            if(validateAndSave()){
              setState(() {
                isApiCallProcess = true;
              });
            }
            adminteacherLogin().then((value) {
              setState(() {
                isApiCallProcess = false; 
              });
            });
            changedButton = false;
            
          },
          child: changedButton ? const Icon(Icons.done,color: Colors.white,) : const Text("Login",textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
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
                      const SizedBox(height: 10,),
                      const Text('M EYE PRO',textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                      ),

                      const SizedBox(height: 45,),
                      emailField,
                      const SizedBox(height: 25,),
                      passwordField,
                      const SizedBox(height: 25,),
                      loginButton,

                      const SizedBox(height: 15,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     const Text("Don't Have an Account? "),
                      //     InkWell(
                      //       onTap: (){
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                      //       },
                      //       child: const Text(
                      //         "Signup",
                      //         style: TextStyle(
                      //           color: Colors.blueAccent,
                      //           fontWeight: FontWeight.w400,fontSize: 15
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
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
