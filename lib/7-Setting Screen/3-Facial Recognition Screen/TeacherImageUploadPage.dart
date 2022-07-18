// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, annotate_overrides

import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class TeacherImageUploadPage extends StatefulWidget {
  const TeacherImageUploadPage({Key? key}) : super(key: key);
  @override
  State<TeacherImageUploadPage> createState() => _TeacherImageUploadPageState();
}

class _TeacherImageUploadPageState extends State<TeacherImageUploadPage> {

  var teachername = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late XFile? photo;
  io.File? imgfile;
  var _imageFile;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Image Upload'),
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
                  ]),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                imageProfile(context),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: ImageTextField(teachername, "T E A C H E R    N A M E")
                  ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: (){
                    uploadFile(_imageFile);
                  }, 
                  child: Text("Upload")
                  ),

                // ElevatedButton(
                //   onPressed: (){
                //     Navigator.push(context,MaterialPageRoute(builder: (context) => const PhotoApiMubashirGet()),);
                //   }, 
                // child: Text("Get Image")
                // )
                
              ],
            ),
          )
          )
          );
  }

  Widget imageProfile(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile == null
                ? NetworkImage('https://aucdelivery.com/public/Team/280222_03_31_44.jpg') as ImageProvider
                : FileImage(io.File(_imageFile!.path)),
          ),
          Positioned(
              right: 25.0,
              bottom: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 28.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet(context) {
    return SafeArea(
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: <Widget>[
          Text(
            "Choose photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text("camera"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              )
            ],
          )
        ]),
      ),
    );
  }

  TextFormField ImageTextField(TextEditingController ctrl, String htext){
  return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: htext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
}

  void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _imageFile = io.File(pickedFile!.path);
    });
  }

  Future<void> uploadFile(io.File f) async {
    print('Image path ' + f.path);
    Center(child: CircularProgressIndicator());
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.apiUrl + "meyepro/api/ImageUpload/upload?teachername=" +
            teachername.text));

    request.files.add(await http.MultipartFile.fromPath('photo', f.path));

    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');

    var res = await request.send();
    print('response received....');

    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image Upload Successfully!")));
      // EasyLoading.dismiss();
    } else {
      print('Not Uploaded');
      // EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops!Something went wrong")));
    }
  }
}