// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/1-Login+Signup%20Screen/RegistrationScreen.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:m_eye_gui/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
  Future<void> loginUser() async
  {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      
      var response = await http.post(
        Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Login/loginUser'),

        body: ({
          'email': emailController.text,
          'password': passwordController.text,
        }),

      );
      if (response.statusCode == 200) {
        print('Successfull Login');

        // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),);
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid email or password"),));
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
            loginUser().then((value) {
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

class LoginTable{
  late String? email,password;
  late int lgid;
  LoginTable(
      {
        required this.lgid,
        required this.email,
        required this.password,
      });
  factory LoginTable.fromJson(Map<String,dynamic>json)
  {
    return LoginTable(
      lgid:json['lgid'],
      email:json['email'],
      password:json['password'],
    );
  }
}
