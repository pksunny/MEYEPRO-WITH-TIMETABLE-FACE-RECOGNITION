import 'package:m_eye_gui/4-Live%20Streaming%20Screen/LiveStreaming.dart';
import 'package:video_player/video_player.dart';

class LiveStreamingList
{
  String itemVideo;
  String videoName;

  LiveStreamingList.items({required this.itemVideo, required this.videoName});
}

List<LiveStreamingList> VideoItems = [
  LiveStreamingList.items(
      itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoName: "video 1",
  ),
  LiveStreamingList.items(
      itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoName: "video 2",
  ),
  LiveStreamingList.items(
      itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoName: "video 3",
  ),
  LiveStreamingList.items(
      itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoName: "video 4",
  ),
  LiveStreamingList.items(
      itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      videoName: "video 5",
  ),
];
