import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/6-Recorded%20Videos%20Screen/RecordedVideo.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';

class RecordedVideoOnClick extends StatefulWidget {
  const RecordedVideoOnClick({ Key? key, required this.videouplod,required this.videouploadList }) : super(key: key);

  final SavePython videouplod;
  final List<SavePython> videouploadList;

  @override
  State<RecordedVideoOnClick> createState() => _RecordedVideoOnClickState();
}

class _RecordedVideoOnClickState extends State<RecordedVideoOnClick> {

  bool _isPlaying = true;


  @override
  Widget build(BuildContext context) {
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


                  Container(
                    margin: EdgeInsets.only(top: 150),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(2),
                        child: ProgressBar(
                          // barCapShape: BarCapShape.round,
                        progress: Duration.zero,
                        buffered: Duration.zero,
                        total: Duration.zero,
                        progressBarColor: Colors.red,
                        baseBarColor: Colors.white.withOpacity(0.50),
                        bufferedBarColor: Colors.yellow.withOpacity(0.50),
                        thumbColor: Colors.blue,
                        barHeight: 3.0,
                        thumbRadius: 5.0,
                        onSeek: (duration) {
                          _vlcPlayer.seekTo(duration);
                        },
                      ),
                    ),
                  ),
                  
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
                  )
                ],
              ),
              );
          },
        ),
      ),
    );
  }
}