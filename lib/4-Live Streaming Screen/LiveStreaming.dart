// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreamingOnClick.dart';
// import 'package:m_eye_gui/main.dart';

// class LiveStreaming extends StatefulWidget {
//   const LiveStreaming({ Key? key }) : super(key: key);

//   @override
//   State<LiveStreaming> createState() => _LiveStreamingState();
// }

// class _LiveStreamingState extends State<LiveStreaming> {

//   void initState(){
//    super.initState();
//     getVideo();
//     // data();
//   }

//   String myUrl = '';

//   // void data() async {
//   //   String url = '';
//   //   print(url);

//   //   var data;
//   //   String output = 'Initial Output';
//   //   print(output);

//   //   url = 'http://192.168.122.37:5000/inout?query=' + myUrl;
//   //   print(url);
//   //   print(myUrl);

//   //   data = await fetchData(url);
//   //   print(data);

//   //   var decoded = jsonDecode(data);
//   //   print(decoded);

//   //   setState(() {
//   //     output = decoded['output'];
//   //   });
//   // }


//   List<VideoUrl> videourlList = [];

//   var baseUrl = 'http://192.168.42.37/';

//   Future<void> getVideo() async{
//     var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/VideoUrl/getUrl'));
//     if(response.statusCode==200)
//     {
//         //return json.decode(response.body)['response'];
//       print("Successfull Show Record");


//       Iterable listt = jsonDecode(response.body);
//       videourlList=listt.map((e) => VideoUrl.fromJson(e)).toList();
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
//         centerTitle: true,
//         title: Text('Live Stream'),
//       ),

//       body: Container(
//         padding: EdgeInsets.all(15),
//         child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//             ),
//             itemCount: videourlList.length,
//             itemBuilder: (context,index){
//               myUrl = videourlList[index].videourl.toString();
//               VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay: true,options: VlcPlayerOptions());

//               return InkWell(
//                 onTap: (){
//                   String videourl=videourlList[index].videourl.toString();
                      
//                       List<VideoUrl> data=[];
//                       for(int i=0;i<videourlList.length;i++)
//                       {
//                         if(videourlList[i].videourl==videourl)
//                         data.add(videourlList[i]);
//                       }
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => LiveStreamingOnClick(videoUrl: videourlList[index], videoUrlList:data,)));
                      
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
//                             videourlList[index].videoname.toString(),
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


// class VideoUrl
// {
//   late String? videoname,videourl;
//   late int id;
//   VideoUrl(
//       {
//         required this.id,
//         required this.videoname,
//         required this.videourl,
//       });
//   factory VideoUrl.fromJson(Map<String,dynamic>json)
//   {
//     return VideoUrl(
//       id:json['id'],
//       videoname:json['videoname'],
//       videourl:json['videourl1'],
//     );
//   }
// }

// // PYTHON API FUNCTION //
// Future<String> fetchData(String url) async {
//   http.Response response = await http.get(Uri.parse(url));
//   return response.body;
// }







// _-_-_-_-_ LIVE STREAM WITH CAMERA TABLE CODE _-_-_-_-_-

import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreamingOnClick.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideoOnClick.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/3-Edit%20Channel/UpdateChannelPage.dart';
import 'package:m_eye_gui/main.dart';

class LiveStreaming extends StatefulWidget {
  const LiveStreaming({ Key? key }) : super(key: key);

  @override
  State<LiveStreaming> createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> {

  void initState(){
   super.initState();
    getCameraStream();
  }

  List<CameraTable> cameraList = [];

  // var baseUrl = 'http://192.168.152.123';

  Future<void> getCameraStream() async{
    var response=await http.get(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/Camera/getCamera'));
    if(response.statusCode==200)
    {
      print("Successfull Show Record");


      Iterable listt = jsonDecode(response.body);
      print(listt);
      cameraList=listt.map((e) => CameraTable.fromJson(e)).toList();
      setState(() {

      });
    }
    else
      throw Exception('Failed to load data');

  }

  String _location(dynamic media)
  {
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Streaming'),
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
            itemCount: cameraList.length,
            itemBuilder: (context,index){
              String myUrl = cameraList[index].channelnum.toString();
              VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay: true,options: VlcPlayerOptions());
              return InkWell(
                onTap: (){
                      String channelnum=cameraList[index].channelnum.toString();
                      
                      List<CameraTable> data=[];
                      for(int i=0;i<cameraList.length;i++)
                      {
                        if(cameraList[i].channelnum==channelnum)
                          data.add(cameraList[i]);
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LiveStreamingOnClick(cameraUrl: cameraList[index], cameraUrlList: data)));
                      
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
                              cameraList[index].venue.toString(),
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