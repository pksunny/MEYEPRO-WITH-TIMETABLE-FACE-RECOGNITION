import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../main.dart';

class EditDVRPage extends StatefulWidget {
  const EditDVRPage({Key? key}) : super(key: key);

  @override
  _EditDVRPageState createState() => _EditDVRPageState();
}

class _EditDVRPageState extends State<EditDVRPage> {

  void initState() {
    super.initState();
    
    // dvrNameController = TextEditingController(text: dvrTable[index].dvrname.toString());

    ShowAllDVR();
  }

  late TextEditingController dvrNameController;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

  List<DVRTable> dvrTable = [];

  Future<void> ShowAllDVR() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/getDVR'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      dvrTable = listt.map((e) => DVRTable.fromJson(e)).toList();
      // final uniqueJsonList = sectionTable.toSet().toList();
      setState(() {

      });
      //var res=json.decode(response.body);
      //return res.map<student>((json)=>student.fromJson(json)).toList();
    }
    else
      throw Exception('Failed to load data');

  }

  // DELETE FUNCTION //
  Future<DVRTable> deleteDVR(String dvrid) async {
    final http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/deleteDVR?dvrid='+dvrid),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final respnse = json.decode(response.body);


    print(dvrid);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted!"),));
      print('SuccessFull Deleted');

      setState(() {
        
      });

      return DVRTable.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete Child');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: RefreshIndicator(
        onRefresh: ShowAllDVR,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Expanded(
                      // SOURCE DATATABLE FILL API => https://stackoverflow.com/questions/66981236/flutter-datatable-from-api //
            
                      child: DataTable(
                        // columnSpacing: 38.0,
                        // border: TableBorder.all(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(10),
                        //     width: 3),
                        columns: [
                          // DataColumn(label: Text('DVR ID',style: cardtextstyle2,)),
                          DataColumn(label: Text('DVR Name',style: cardtextstyle2,)),
                          DataColumn(label: Text('IP Address',style: cardtextstyle2,)),
                          DataColumn(label: Text('User Name',style: cardtextstyle2,)),
                          DataColumn(label: Text('Password', style: cardtextstyle2,)),
                          DataColumn(label: Text('Max Channel', style: cardtextstyle2,)),
                          DataColumn(label: Text('Edit', style: editTextStyle,)),
                          DataColumn(label: Text('Delete', style: cardtextstyle2)),
                        ],
                        rows: List.generate(dvrTable.length, (index) {
                          // final dvrid = dvrTable[index].dvrid.toString();
                          final dvrname = dvrTable[index].dvrname.toString();
                          final ipaddress = dvrTable[index].ipaddress.toString();
                          final usrname = dvrTable[index].username.toString();
                          final password = dvrTable[index].password.toString();
                          final maxchannel = dvrTable[index].maxchannel.toString();
                          final delete = dvrTable[index].dvrid.toString();

                          return DataRow(cells: [
                            // DataCell(Text(dvrid),showEditIcon: true),
                            DataCell(
                              Text(dvrname),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DVRNameEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),
                            DataCell(
                              Text(ipaddress),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => IPAddressEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),
                            DataCell(
                              Text(usrname),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserNameEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),
                            DataCell(
                              Text(password),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                            ),
                            DataCell(
                              Text(maxchannel),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MaxChannelEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),
                            DataCell(
                              Icon(Icons.edit_outlined, color: Colors.blue),
                              onTap: (){
                                int dvrid=dvrTable[index].dvrid;
                          
                                List<DVRTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].dvrid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditDVRPageOnClick(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),

                              DataCell(
                                Icon(Icons.delete_forever_rounded, color: Colors.redAccent,),
                                onTap: (){
                                  deleteDVR(dvrTable[index].dvrid.toString());
                                }
                              ),
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
      ),
    );
  }

}


class DVRTable
{
  late int dvrid;
  late String dvrname;
  late String ipaddress;
  late String username;
  late String password;
  late int maxchannel;
  
  DVRTable({
    required this.dvrid,
    required this.dvrname,
    required this.ipaddress,
    required this.username,
    required this.password,
    required this.maxchannel,
    });

  factory DVRTable.fromJson(Map<String,dynamic>json)
  {
    return DVRTable(
      dvrid:json['dvrid'],
      dvrname:json['dvrname'],
      ipaddress:json['ipaddress'],
      username:json['username'],
      password:json['password'],
      maxchannel:json['maxchannel'],
    );
  }
}







// ----->>>>> ALL DVR EDIT/UPDATE <<<<<----- //


class EditDVRPageOnClick extends StatefulWidget {
  const EditDVRPageOnClick({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _EditDVRPageOnClickState createState() => _EditDVRPageOnClickState();
}

class _EditDVRPageOnClickState extends State<EditDVRPageOnClick> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      // dvrNameController.text = widget.selectedOverall.dvrname.toString();
      // ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      // userNameController.text = widget.selectedOverall.username.toString();
      // passwordController.text = widget.selectedOverall.password.toString();
      // maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // DVRID NAME FIELD
    final dvridField = TextFormField(
      controller: dvridController,

      onSaved: (value){
        dvridController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.dvrid.toString(),
        hintText: widget.selectedOverall.dvrid.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'DVR ID cannot be empty';
        }
        return null;
      },
    );

    // DVR NAME FIELD
    final dvrField = TextFormField(
      controller: dvrNameController,

      onSaved: (value){
        dvrNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.dvrname.toString(),
        hintText: widget.selectedOverall.dvrname.toString(),
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
        labelText: widget.selectedOverall.ipaddress.toString(),
        hintText: widget.selectedOverall.ipaddress.toString(),
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
        labelText: widget.selectedOverall.username.toString(),
        hintText: widget.selectedOverall.username.toString(),
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
        labelText: widget.selectedOverall.password.toString(),
        hintText: widget.selectedOverall.password.toString(),
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
        labelText: widget.selectedOverall.maxchannel.toString(),
        hintText: widget.selectedOverall.maxchannel.toString(),
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

    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            updateButton,
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


// ----->>>>> DVR NAME EDIT/UPDATE <<<<<----- //


class DVRNameEdit extends StatefulWidget {
  const DVRNameEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _DVRNameEditState createState() => _DVRNameEditState();
}

class _DVRNameEditState extends State<DVRNameEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      // dvrNameController.text = widget.selectedOverall.dvrname.toString();
      ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      userNameController.text = widget.selectedOverall.username.toString();
      passwordController.text = widget.selectedOverall.password.toString();
      maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("DVR Name Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
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
        labelText: widget.selectedOverall.dvrname.toString(),
        hintText: widget.selectedOverall.dvrname.toString(),
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
    
    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR Name",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            updateButton,
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


// ----->>>>> IP ADDRESS EDIT/UPDATE <<<<<----- //


class IPAddressEdit extends StatefulWidget {
  const IPAddressEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _IPAddressEditState createState() => _IPAddressEditState();
}

class _IPAddressEditState extends State<IPAddressEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      dvrNameController.text = widget.selectedOverall.dvrname.toString();
      // ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      userNameController.text = widget.selectedOverall.username.toString();
      passwordController.text = widget.selectedOverall.password.toString();
      maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("IP Address Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // IP ADDRESS FIELD
    final ipaddressField = TextFormField(
      controller: ipAddressController,

      onSaved: (value){
        ipAddressController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.ipaddress.toString(),
        hintText: widget.selectedOverall.ipaddress.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'IP Address cannot be empty';
        }
        return null;
      },
    );
    
    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR IP Address",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            ipaddressField,
                            SizedBox(height: height*0.05,),
                            updateButton,
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


// ----->>>>> USER NAME EDIT/UPDATE <<<<<----- //


class UserNameEdit extends StatefulWidget {
  const UserNameEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _UserNameEditState createState() => _UserNameEditState();
}

class _UserNameEditState extends State<UserNameEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      dvrNameController.text = widget.selectedOverall.dvrname.toString();
      ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      // userNameController.text = widget.selectedOverall.username.toString();
      passwordController.text = widget.selectedOverall.password.toString();
      maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Name Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // IP ADDRESS FIELD
    final usernameField = TextFormField(
      controller: userNameController,

      onSaved: (value){
        userNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.username.toString(),
        hintText: widget.selectedOverall.username.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'User Name cannot be empty';
        }
        return null;
      },
    );
    
    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR User Name",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            usernameField,
                            SizedBox(height: height*0.05,),
                            updateButton,
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


// ----->>>>> PASSWORD EDIT/UPDATE <<<<<----- //


class PasswordEdit extends StatefulWidget {
  const PasswordEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _PasswordEditState createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      dvrNameController.text = widget.selectedOverall.dvrname.toString();
      ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      userNameController.text = widget.selectedOverall.username.toString();
      // passwordController.text = widget.selectedOverall.password.toString();
      maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // PASSWORD FIELD
    final passwordField = TextFormField(
      controller: passwordController,

      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.password.toString(),
        hintText: widget.selectedOverall.password.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Password name cannot be empty';
        }
        return null;
      },
    );
    
    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR Password",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            passwordField,
                            SizedBox(height: height*0.05,),
                            updateButton,
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


// ----->>>>> MAX CHANNEL EDIT/UPDATE <<<<<----- //


class MaxChannelEdit extends StatefulWidget {
  const MaxChannelEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final DVRTable selectedOverall;
  final List<DVRTable> selectedDVRTable;

  @override
  _MaxChannelEditState createState() => _MaxChannelEditState();
}

class _MaxChannelEditState extends State<MaxChannelEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController dvridController = new TextEditingController();
  final TextEditingController dvrNameController = new TextEditingController();
  final TextEditingController ipAddressController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController maxChannelController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateDVR() async {

    setState(() {
      dvridController.text = widget.selectedOverall.dvrid.toString();
      dvrNameController.text = widget.selectedOverall.dvrname.toString();
      ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      userNameController.text = widget.selectedOverall.username.toString();
      passwordController.text = widget.selectedOverall.password.toString();
      // maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/DVR/UpdateDVR'),
      body:{
        'dvrid': dvridController.text,
        'dvrname': dvrNameController.text,
        'ipaddress': ipAddressController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'maxchannel': maxChannelController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Max Channel Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // PASSWORD FIELD
    final passwordField = TextFormField(
      controller: maxChannelController,

      onSaved: (value){
        maxChannelController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.maxchannel.toString(),
        hintText: widget.selectedOverall.maxchannel.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Max Channel cannot be empty';
        }
        return null;
      },
    );
    
    // UPDATE BUTTON FIELD
    final updateButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formKey.currentState!.validate()){
            updateDVR();
          }
        },
        child: Text("Update DVR Password",textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update DVR'),
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

      body: SingleChildScrollView(
        child: SafeArea(
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
                            passwordField,
                            SizedBox(height: height*0.05,),
                            updateButton,
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