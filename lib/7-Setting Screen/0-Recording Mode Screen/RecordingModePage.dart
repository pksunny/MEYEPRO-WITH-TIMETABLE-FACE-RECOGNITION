import 'package:flutter/material.dart';
import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';

class RecordingModePage extends StatefulWidget {
  const RecordingModePage({Key? key}) : super(key: key);

  @override
  _RecordingModePageState createState() => _RecordingModePageState();
}

class _RecordingModePageState extends State<RecordingModePage> {

  var feedback = "Successfulyy Applied";

  final CheckBoxList = [
    CheckBoxState(title: 'FIRST 10 MINUTES'),
    CheckBoxState(title: 'MIDDLE 10 MINUTES'),
    CheckBoxState(title: 'LAST 10 MINUTES'),
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar : AppBar(
        title: Text('Recording Mode'),
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
          child: Padding(
            padding: EdgeInsets.only(left: width*0.09,right: width*0.09,top: height*0.07,bottom: height*0.09),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: width*0.8,
                  height: height*0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                    color: Colors.transparent,
                  ),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.blue,
                    margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: height*0.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(height: height*0.04,),

                        ...CheckBoxList.map(buildSingleCheckBox).toList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.03,),
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
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
                )

              ],
            ),
          )
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
