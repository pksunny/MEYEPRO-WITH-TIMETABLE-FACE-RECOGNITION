import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';



class TeacherHideRecordedOnClick extends StatefulWidget {
  const TeacherHideRecordedOnClick({ Key? key, required this.videouplod,required this.videouploadList }) : super(key: key);

  final SavePython videouplod;
  final List<SavePython> videouploadList;

  @override
  State<TeacherHideRecordedOnClick> createState() => _TeacherHideRecordedOnClickState();
}

class _TeacherHideRecordedOnClickState extends State<TeacherHideRecordedOnClick> {

  bool _isPlaying = true;

  final TextEditingController idController = new TextEditingController();
  final TextEditingController videonameController = new TextEditingController();
  final TextEditingController videopathController = new TextEditingController();
  final TextEditingController statusController = new TextEditingController();

  updateStatus() async {

    setState(() {
      idController.text = widget.videouplod.id.toString();
      videonameController.text = widget.videouplod.videoname.toString();
      videopathController.text = widget.videouplod.videopath.toString();
      statusController.text = "0";
    });

    var response = await http.post(Uri.parse(ApiUrl.apiUrl + 'meyepro/api/SavePython/HideVideo'),
      body:{
        'id': idController.text,
        'videoname': videonameController.text,
        'videopath': videopathController.text,
        'status': statusController.text,
      });


      
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("UnHide Successfully!"),));
      // return TimeTable.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Record!');
    }
  }


  @override
  Widget build(BuildContext context) {

    // UNHIDE BUTTON //
    final unhideButton = AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            updateStatus();
            
          },
          child: const Text("Un-Hide This Video",textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videouplod.videoname.toString()),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index){
              String myUrl = ApiUrl.apiUrl + Uri.parse(widget.videouplod.videopath.toString()).toString();
              VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay:true, options: VlcPlayerOptions(),);

              return Container(
              child: Stack(
                // alignment: FractionalOffset.bottomCenter,
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


                  // Container(
                  //   margin: EdgeInsets.only(top: 150),
                  //   padding: EdgeInsets.only(left: 10, right: 10),
                  //   child: ClipRRect(
                  //     // borderRadius: BorderRadius.circular(2),
                  //       child: ProgressBar(
                  //         // barCapShape: BarCapShape.round,
                  //       progress: Duration.zero,
                  //       buffered: Duration.zero,
                  //       total: Duration.zero,
                  //       progressBarColor: Colors.red,
                  //       baseBarColor: Colors.white.withOpacity(0.50),
                  //       bufferedBarColor: Colors.yellow.withOpacity(0.50),
                  //       thumbColor: Colors.blue,
                  //       barHeight: 3.0,
                  //       thumbRadius: 5.0,
                  //       onSeek: (duration) {
                  //         _vlcPlayer.seekTo(duration);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 200,left: 145),
                    child: Row(
                      children: [
                        TextButton(onPressed: (){
                          if(_isPlaying){
                            setState(() {
                              _isPlaying = false;
                            });
                            _vlcPlayer.pause();
                          } else {
                            setState(() {
                              _isPlaying = true;
                            });
                            _vlcPlayer.play();
                          }
                        }, 
                        child: Icon(_isPlaying ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded,size: 30,)
                        )

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Column(
                      children: [
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     height: 30,
                        //     color: Colors.blue,
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       widget.videoUrl.id.toString(),
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 30,
                            color: Colors.blue,
                            alignment: Alignment.center,
                            child: Text(
                              widget.videouplod.videoname.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          
                        ),
                      ],
                    ),
                  ),

                
                  Container(
                    margin: EdgeInsets.only(top: 300),
                    child: unhideButton
                    ),

                ],
              ),
              );
          },
        ),
      ),
    );
  }
}