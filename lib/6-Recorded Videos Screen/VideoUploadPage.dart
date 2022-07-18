// // ignore_for_file: prefer_const_constructors

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';

// class VideoUploadPage extends StatefulWidget {
//   const VideoUploadPage({ Key? key }) : super(key: key);

//   @override
//   State<VideoUploadPage> createState() => _VideoUploadPageState();
// }

// class _VideoUploadPageState extends State<VideoUploadPage> {

//   ListPlatformFile _files;
//   var file;




//   void _OpenFileExporer()  async
//   {
//     _files=(await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false,
//       allowedExtensions: null,
//     ))!.files;
//     print('Loaded File Path is ${_files!.first.path}');
//     file=_files;
//     print(file);
//   }

//  void _uploadvideo() async
//  {
//    //print(Parent.Parent_Var.toString());
//    var request = http.MultipartRequest('POST',
//      Uri.parse('http://192.168.42.37/meyepro/api/VideoUpload/VideoUpload'),
//    );
//    request.files.add(await http.MultipartFile.fromPath(
//        'video', _files!.first.path.toString()));



//    var response = await request.send();

//    var responsed = await http.Response.fromStream(response);
//     //ignore unused_local_variable
//    final respnse = json.decode(responsed.body);
//    print(_files!.first.path.toString());

//    if (response.statusCode == 200) {
//      Fluttertoast.showToast(
//          msg: 'Upload SuccessFully.....',
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.lightBlue,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );
//      print('Upload SuceessFully');
//    }
//    else {
//      Fluttertoast.showToast(
//          msg: 'SomeThing Went Wroung!.....',
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.lightBlue,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );
//      print('Something Went Wroung!....');
//    }
//  }

//   @override
//   Widget build(BuildContext context) {
//         return MaterialApp(
//         home: Scaffold(
//       backgroundColor: Colors.blueGrey,
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Add Lullaby',
//             style: TextStyle(fontSize: 25),
//           ),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage('imagesbg.png'),
//           ),
//         ),
//         child: Column(
//           children: [
//             RaisedButton(
//               padding: EdgeInsets.all(10),
//               onPressed: () {
//                 _OpenFileExporer();
//               },
//               child: Text('Open File Explorer'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             RaisedButton(
//               padding: EdgeInsets.all(10),
//               onPressed: () {
//                 _uploadvideo();
//               },
//               child: Text('Upload Video'),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }