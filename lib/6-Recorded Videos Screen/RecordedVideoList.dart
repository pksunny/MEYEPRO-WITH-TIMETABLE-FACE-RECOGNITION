import 'package:video_player/video_player.dart';

class RecordedVideo {
  String itemVideo;
  String videoName;

  RecordedVideo.items({required this.itemVideo, required this.videoName});
}
  List<RecordedVideo> VideoItems = [
    RecordedVideo.items(
        itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        videoName: "video 1"
    ),
    RecordedVideo.items(
        itemVideo: "https://media.w3.org/2010/05/sintel/trailer.mp4",
        videoName: "video 2"
    ),
    RecordedVideo.items(
        itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        videoName: "video 3"
    ),
    RecordedVideo.items(
        itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        videoName: "video 4"
    ),
    RecordedVideo.items(
        itemVideo: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        videoName: "video 5"
    ),
  ];
