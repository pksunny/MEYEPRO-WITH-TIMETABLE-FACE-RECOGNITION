// ignore_for_file: prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:video_player/video_player.dart';
// import 'RecordedVideoList.dart';

// class RecordedVideo extends StatefulWidget {
//   const RecordedVideo({Key? key}) : super(key: key);

//   @override
//   _RecordedVideoState createState() => _RecordedVideoState();
// }

// class _RecordedVideoState extends State<RecordedVideo> {



//   late VideoPlayerController _controller1;
//   late VideoPlayerController _controller2;
//   late Future<void> _initializeVideoPlayerFuture1;
//   late Future<void> _initializeVideoPlayerFuture2;


//   @override
//   void initState() {
//     _controller1 = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//     _initializeVideoPlayerFuture1 = _controller1.initialize();
//     _controller1.setLooping(true);
//     // _controller1.play();
//     _controller1.setVolume(1.0);

//     _controller2 = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//     _initializeVideoPlayerFuture2 = _controller2.initialize();
//     _controller2.setLooping(true);
//     // _controller2.play();
//     _controller2.setVolume(1.0);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller1.dispose();
//     _controller2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar : AppBar(
//         title: Text('Recorded Video'),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [
//                   Color(0xFF03E5B7),
//                   Color(0xFF08C8F6),
//                   Color(0xFF48A9FE),
//                 ]
//             ),
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: GridView.builder(
//             itemCount: VideoItems.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2
//             ),
//             itemBuilder: (context,index){
//               return InkWell(
//                 onTap: (){},
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Stack(
//                     alignment: FractionalOffset.bottomCenter,
//                     children: [
//                       Container(
//                         alignment: Alignment.topCenter,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: FutureBuilder(
//                               future: _initializeVideoPlayerFuture1,
//                               builder: (context, snapshot){
//                                 if(snapshot.connectionState == ConnectionState.done){
//                                   return AspectRatio(
//                                     aspectRatio: _controller1.value.aspectRatio,
//                                     child: VideoPlayer(
//                                       _controller1,
//                                     ),
//                                   );
//                                 } else{
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                     ),
//                                   );
//                                 }
//                               }
//                           ),
//                         ),
//                       ),

//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           height: 30,
//                           color: Colors.blue,
//                           alignment: Alignment.center,
//                           child: Text(VideoItems[index].videoName,style: TextStyle(color: Colors.white),),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//         ),
//         ),
//     );
//   }
// }









// --->>> _________________ <<<---
// VIDEO GET FROM DATABASE CODE //
// --->>> _________________ <<<---


// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideoOnClick.dart';
// import 'package:m_eye_gui/main.dart';

// class RecordedVideo extends StatefulWidget {
//   const RecordedVideo({ Key? key }) : super(key: key);

//   @override
//   State<RecordedVideo> createState() => _RecordedVideoState();
// }

// class _RecordedVideoState extends State<RecordedVideo> {

//   void initState(){
//    super.initState();
//     getVideo();
//   }

//   List<VideoUpload> videouploadList = [];

//   var baseUrl = 'http://192.168.42.37';

//   Future<void> getVideo() async{
//     var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/VideoUpload/getVideo'));
//     if(response.statusCode==200)
//     {
//         //return json.decode(response.body)['response'];
//       print("Successfull Show Record");


//       Iterable listt = jsonDecode(response.body);
//       videouploadList=listt.map((e) => VideoUpload.fromJson(e)).toList();
//       setState(() {

//       });
//      //var res=json.decode(response.body);
//     //return res.map<student>((json)=>student.fromJson(json)).toList();
//     }
//     else
//       throw Exception('Failed to load data');

//   }

//   // VlcPlayerController _vlcViewController;


//   // _onTap(int index)
//   // {
//   //   _vlcViewController = new VlcPlayerController.network(
//   //   videourlList[index].videourl.toString(),
//   //   autoPlay: true,
//   //   options: VlcPlayerOptions(),
//   // );
//   // }

//   String _location(dynamic media)
//   {
//     return media;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video List'),
//       ),

//       body: Container(
//         padding: EdgeInsets.all(15),
//         child: GridView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//             ),
//             itemCount: videouploadList.length,
//             itemBuilder: (context,index){
//               String myUrl = ApiUrl.apiUrl + Uri.parse(videouploadList[index].vpath.toString()).toString();
//               VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay: true,options: VlcPlayerOptions());
//               return InkWell(
//                 onTap: (){
//                   String videopath=videouploadList[index].vpath.toString();
                      
//                       List<VideoUpload> data=[];
//                       for(int i=0;i<videouploadList.length;i++)
//                       {
//                         if(videouploadList[i].vpath==videopath)
//                         data.add(videouploadList[i]);
//                       }
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => RecordedVideoOnClick(videouplod: videouploadList[index], videouploadList:data,)));
                      
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.blue.withOpacity(0.5)),
//                   child: Stack(
//                     alignment: FractionalOffset.bottomCenter,
//                     children: [
//                       Container(
//                         alignment: Alignment.topCenter,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: VlcPlayer(
//                             controller: _vlcPlayer,
//                             aspectRatio: 16 / 9,
//                             placeholder: const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           height: 30,
//                           color: Colors.blue,
//                           alignment: Alignment.center,
//                           child: Text(
//                             videouploadList[index].vname.toString(),
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }
//             ),
//       ),
//     );
//   }
// }


// class VideoUpload
// {
//   late String? vname,vpath,vsize;
//   late int vid;
//   VideoUpload(
//       {
//         required this.vid,
//         required this.vname,
//         required this.vpath,
//         required this.vsize,
//       });
//   factory VideoUpload.fromJson(Map<String,dynamic>json)
//   {
//     return VideoUpload(
//       vid: json['vid'],
//       vname: json['vname'],
//       vpath: json['vpath'],
//       vsize: json['vsize'],
//     );
//   }
// }


// _-_-_-_-_ PYTHON VIDEO PATH CODE _-_-_-_-_-

import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideoOnClick.dart';
import 'package:m_eye_gui/main.dart';

class RecordedVideo extends StatefulWidget {
  const RecordedVideo({ Key? key }) : super(key: key);

  @override
  State<RecordedVideo> createState() => _RecordedVideoState();
}

class _RecordedVideoState extends State<RecordedVideo> {

  void initState(){
   super.initState();
    getVideo();
  }

  List<SavePython> videouploadList = [];

  // var baseUrl = 'http://192.168.152.123';

  Future<void> getVideo() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/SavePython2/getPythonVideoAdmin'));
    if(response.statusCode==200)
    {
      print("Successfull Show Record");


      Iterable listt = jsonDecode(response.body);
      print(listt);
      videouploadList=listt.map((e) => SavePython.fromJson(e)).toList();
      setState(() {

      });
    }
    else
      throw Exception('Failed to load data');

  }

  // VlcPlayerController _vlcViewController;


  // _onTap(int index)
  // {
  //   _vlcViewController = new VlcPlayerController.network(
  //   videourlList[index].videourl.toString(),
  //   autoPlay: true,
  //   options: VlcPlayerOptions(),
  // );
  // }

  String _location(dynamic media)
  {
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recorded Videos'),
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            // itemCount: videouploadList.length,
            itemCount: videouploadList.length,
            itemBuilder: (context,index){
              String myUrl = ApiUrl.apiUrl + Uri.parse(videouploadList[index].videopath.toString()).toString();
              VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay: true,options: VlcPlayerOptions());
              return InkWell(
                onTap: (){
                      String videopath=videouploadList[index].id.toString();
                      
                      List<SavePython> data=[];
                      for(int i=0;i<videouploadList.length;i++)
                      {
                        if(videouploadList[i].videopath==videopath)
                        data.add(videouploadList[i]);
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecordedVideoOnClick(videouplod: videouploadList[index], videouploadList:data,)));
                      
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.withOpacity(0.5)),
                  child: Stack(
                    alignment: FractionalOffset.bottomCenter,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: VlcPlayer(
                            controller: _vlcPlayer,
                            aspectRatio: 16 / 9,
                            placeholder: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              videouploadList[index].videoname.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            ),
      ),
    );
  }
}

class SavePython
{
  late String? videoname, videopath;
  late int id,status;
  SavePython(
      {
        required this.id,
        required this.videoname,
        required this.videopath,
        required this.status,
      });
  factory SavePython.fromJson(Map<String,dynamic>json)
  {
    return SavePython(
      id: json['id'],
      videoname: json['videoname'],
      videopath: json['videopath'],
      status: json['status']
    );
  }
}