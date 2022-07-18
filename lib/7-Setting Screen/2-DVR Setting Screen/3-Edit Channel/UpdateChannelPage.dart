import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../main.dart';

class UpdateChannelPage extends StatefulWidget {
  const UpdateChannelPage({Key? key}) : super(key: key);

  @override
  _UpdateChannelPageState createState() => _UpdateChannelPageState();
}

class _UpdateChannelPageState extends State<UpdateChannelPage> {

  void initState() {
    super.initState();
    
    // dvrNameController = TextEditingController(text: dvrTable[index].dvrname.toString());

    ShowAllCamera();
  }

  late TextEditingController dvrNameController;

  var cardtextstyle2 = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Color.fromRGBO(63, 63, 63, 1));
  var editTextStyle = const TextStyle(fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue);

  List<CameraTable> dvrTable = [];

  Future<void> ShowAllCamera() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/getCamera'));
    if(response.statusCode==200)
    {
      //return json.decode(response.body)['response'];
      print("Successfull Show Record");
      //print(response.body);

      Iterable listt = jsonDecode(response.body);
      print(listt);
      dvrTable = listt.map((e) => CameraTable.fromJson(e)).toList();
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
  Future<CameraTable> deleteCamera(String camid) async {
    final http.Response response = await http.get(
      Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/deleteCamera?camid='+camid),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final respnse = json.decode(response.body);


    print(camid);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted!"),));
      print('SuccessFull Deleted');

      setState(() {
        
      });

      return CameraTable.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete Child');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update Camera'),
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
        onRefresh: ShowAllCamera,
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
                          DataColumn(label: Text('Camera Name',style: cardtextstyle2,)),
                          DataColumn(label: Text('Venue',style: cardtextstyle2,)),
                          DataColumn(label: Text('Channel Num',style: cardtextstyle2,)),
                          DataColumn(label: Text('Edit', style: editTextStyle,)),
                          DataColumn(label: Text('Delete', style: cardtextstyle2,)),
                        ],
                        rows: List.generate(dvrTable.length, (index) {
                          // final dvrid = dvrTable[index].dvrid.toString();
                          final cameraname = dvrTable[index].cameraname.toString();
                          final venue = dvrTable[index].venue.toString();
                          final channelnum = dvrTable[index].channelnum.toString();
                          final delete = dvrTable[index].camid.toString();
                          return DataRow(cells: [
                            // DataCell(Text(dvrid),showEditIcon: true),
                            DataCell(
                              Text(cameraname),
                              onTap: (){
                                int dvrid=dvrTable[index].camid;
                          
                                List<CameraTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].camid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraNameEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),

                              DataCell(
                              Text(venue),
                              onTap: (){
                                int dvrid=dvrTable[index].camid;
                          
                                List<CameraTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].camid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VenueEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),

                            DataCell(
                              Text(channelnum),
                              onTap: (){
                                int dvrid=dvrTable[index].camid;
                          
                                List<CameraTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].camid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChannelNumEdit(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),
                            
                            DataCell(
                              Icon(Icons.edit_outlined, color: Colors.blue),
                              onTap: (){
                                int dvrid=dvrTable[index].camid;
                          
                                List<CameraTable> dvridData=[];
                                for(int i=0;i<dvrTable.length;i++)
                                {
                                  if(dvrTable[i].camid==dvrid)
                                  dvridData.add(dvrTable[i]);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditCameraPageOnClick(selectedOverall: dvrTable[index], selectedDVRTable: dvridData)));
                              }
                              ),

                              DataCell(
                                Icon(Icons.delete_forever_rounded, color: Colors.redAccent,),
                                onTap: (){
                                  deleteCamera(dvrTable[index].camid.toString());
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


class CameraTable
{
  late int camid;
  late String cameraname;
  late String venue;
  late String channelnum;
  
  CameraTable({
    required this.camid,
    required this.cameraname,
    required this.venue,
    required this.channelnum,
    });

  factory CameraTable.fromJson(Map<String,dynamic>json)
  {
    return CameraTable(
      camid:json['camid'],
      cameraname:json['cameraname'],
      venue:json['venue'],
      channelnum:json['channelnum'],
    );
  }
}







// ----->>>>> ALL CAMERA EDIT/UPDATE <<<<<----- //


class EditCameraPageOnClick extends StatefulWidget {
  const EditCameraPageOnClick({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final CameraTable selectedOverall;
  final List<CameraTable> selectedDVRTable;

  @override
  _EditCameraPageOnClickState createState() => _EditCameraPageOnClickState();
}

class _EditCameraPageOnClickState extends State<EditCameraPageOnClick> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController camidController = new TextEditingController();
  final TextEditingController cameraNameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController channelNumController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateCamera() async {

    setState(() {
      camidController.text = widget.selectedOverall.camid.toString();
      // dvrNameController.text = widget.selectedOverall.dvrname.toString();
      // ipAddressController.text = widget.selectedOverall.ipaddress.toString();
      // userNameController.text = widget.selectedOverall.username.toString();
      // passwordController.text = widget.selectedOverall.password.toString();
      // maxChannelController.text = widget.selectedOverall.maxchannel.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/UpdateCamera'),
      body:{
        'camid': camidController.text,
        'cameraname': cameraNameController.text,
        'venue': venueController.text,
        'channelnum': channelNumController.text,
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

    // CAMID NAME FIELD
    final camidField = TextFormField(
      controller: camidController,

      onSaved: (value){
        camidController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.camid.toString(),
        hintText: widget.selectedOverall.camid.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Cam ID cannot be empty';
        }
        return null;
      },
    );

    // CAMERA NAME FIELD
    final cameranameField = TextFormField(
      controller: cameraNameController,

      onSaved: (value){
        cameraNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.cameraname.toString(),
        hintText: widget.selectedOverall.cameraname.toString(),
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
      controller: venueController,

      onSaved: (value){
        venueController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.venue.toString(),
        hintText: widget.selectedOverall.venue.toString(),
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
        labelText: widget.selectedOverall.channelnum.toString(),
        hintText: widget.selectedOverall.channelnum.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Channel num cannot be empty';
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
            updateCamera();
          }
        },
        child: Text("Update Camera",textAlign: TextAlign.center, style: TxtStyle.boldtxtstyle,
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Edit/Update Camera'),
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
                            cameranameField,
                            SizedBox(height: height*0.05,),
                            venueField,
                            SizedBox(height: height*0.05,),
                            channelNumField,
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


// ----->>>>> CAMERA NAME EDIT/UPDATE <<<<<----- //


class CameraNameEdit extends StatefulWidget {
  const CameraNameEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final CameraTable selectedOverall;
  final List<CameraTable> selectedDVRTable;

  @override
  _CameraNameEditState createState() => _CameraNameEditState();
}

class _CameraNameEditState extends State<CameraNameEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController camidController = new TextEditingController();
  final TextEditingController cameraNameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController channelNumController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateCamera() async {

    setState(() {
      camidController.text = widget.selectedOverall.camid.toString();
      venueController.text = widget.selectedOverall.venue.toString();
      channelNumController.text = widget.selectedOverall.channelnum.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/UpdateCamera'),
      body:{
        'camid': camidController.text,
        'cameraname': cameraNameController.text,
        'venue': venueController.text,
        'channelnum': channelNumController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Camera Name Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // CAMERA NAME FIELD
    final cameranameField = TextFormField(
      controller: cameraNameController,

      onSaved: (value){
        cameraNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.cameraname.toString(),
        hintText: widget.selectedOverall.cameraname.toString(),
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
            updateCamera();
          }
        },
        child: Text("Update Camera Name",textAlign: TextAlign.center, style: TxtStyle.boldtxtstyle,
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Update Camera Name'),
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
                            cameranameField,
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



// ----->>>>> VENUE EDIT/UPDATE <<<<<----- //


class VenueEdit extends StatefulWidget {
  const VenueEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final CameraTable selectedOverall;
  final List<CameraTable> selectedDVRTable;

  @override
  _VenueEditState createState() => _VenueEditState();
}

class _VenueEditState extends State<VenueEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController camidController = new TextEditingController();
  final TextEditingController cameraNameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController channelNumController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateCamera() async {

    setState(() {
      camidController.text = widget.selectedOverall.camid.toString();
      cameraNameController.text = widget.selectedOverall.cameraname.toString();
      channelNumController.text = widget.selectedOverall.channelnum.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/UpdateCamera'),
      body:{
        'camid': camidController.text,
        'cameraname': cameraNameController.text,
        'venue': venueController.text,
        'channelnum': channelNumController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Venue Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // VENUE FIELD
    final VENUEField = TextFormField(
      controller: venueController,

      onSaved: (value){
        venueController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.venue.toString(),
        hintText: widget.selectedOverall.venue.toString(),
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
            updateCamera();
          }
        },
        child: Text("Update Venue",textAlign: TextAlign.center, style: TxtStyle.boldtxtstyle,
        ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Update Venue'),
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
                            VENUEField,
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


// ----->>>>> CHANNEL NUM EDIT/UPDATE <<<<<----- //


class ChannelNumEdit extends StatefulWidget {
  const ChannelNumEdit({Key? key, required this.selectedOverall, required this.selectedDVRTable}) : super(key: key);

  final CameraTable selectedOverall;
  final List<CameraTable> selectedDVRTable;

  @override
  _ChannelNumEditState createState() => _ChannelNumEditState();
}

class _ChannelNumEditState extends State<ChannelNumEdit> {

  var textstyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController camidController = new TextEditingController();
  final TextEditingController cameraNameController = new TextEditingController();
  final TextEditingController venueController = new TextEditingController();
  final TextEditingController channelNumController = new TextEditingController();

  // -->> UPDATE API <<-- //
  updateCamera() async {

    setState(() {
      camidController.text = widget.selectedOverall.camid.toString();
      cameraNameController.text = widget.selectedOverall.cameraname.toString();
      venueController.text = widget.selectedOverall.venue.toString();
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/UpdateCamera'),
      body:{
        'camid': camidController.text,
        'cameraname': cameraNameController.text,
        'venue': venueController.text,
        'channelnum': channelNumController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Channel Num Updated Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // CHANNEL NUM FIELD
    final ipaddressField = TextFormField(
      controller: channelNumController,

      onSaved: (value){
        channelNumController.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        labelText: widget.selectedOverall.channelnum.toString(),
        hintText: widget.selectedOverall.channelnum.toString(),
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
            updateCamera();
          }
        },
        child: Text("Update Camera Channel Num", textAlign: TextAlign.center,style: TxtStyle.boldtxtstyle,  ),
      ),
    );

    return Scaffold(
      appBar : AppBar(
        title: Text('Update Camera Channel Num'),
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

