import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:m_eye_gui/7-Setting%20Screen/2-DVR%20Setting%20Screen/3-Edit%20Channel/UpdateChannelPage.dart';

import '../main.dart';

class LiveStreamingOnClick extends StatefulWidget {
  const LiveStreamingOnClick({ Key? key, required this.cameraUrl,required this.cameraUrlList }) : super(key: key);

  final CameraTable cameraUrl;
  final List<CameraTable> cameraUrlList;

  @override
  State<LiveStreamingOnClick> createState() => _LiveStreamingOnClickState();
}

class _LiveStreamingOnClickState extends State<LiveStreamingOnClick> {

  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cameraUrl.venue.toString()),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index){
              String myUrl = widget.cameraUrlList[index].channelnum.toString();
              VlcPlayerController _vlcPlayer = VlcPlayerController.network(myUrl,autoPlay:true);

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
                  //   margin: EdgeInsets.only(top: 200,left: 145),
                  //   child: Row(
                  //     children: [
                  //       TextButton(onPressed: (){
                  //         if(_isPlaying){
                  //           setState(() {
                  //             _isPlaying = false;
                  //           });
                  //           _vlcPlayer.pause();
                  //         } else {
                  //           setState(() {
                  //             _isPlaying = true;
                  //           });
                  //           _vlcPlayer.play();
                  //         }
                  //       }, 
                  //       child: Icon(_isPlaying ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded,size: 30,)
                  //       )

                  //     ],
                  //   ),
                  // ),

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
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     height: 30,
                        //     color: Colors.blue,
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       widget.cameraUrl.cameraname.toString(),
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),

                        // SizedBox(height: 15),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     height: 30,
                        //     color: Colors.blue,
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       widget.cameraUrl.venue.toString(),
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
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
