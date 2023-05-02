import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TokTikVideoPlayer extends StatefulWidget {
  String videoUrl;
   TokTikVideoPlayer({Key? key,  required this.videoUrl}) : super(key: key);

  @override
  State<TokTikVideoPlayer> createState() => _TokTikVideoPlayerState();
}

class _TokTikVideoPlayerState extends State<TokTikVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
    });

  }


  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
