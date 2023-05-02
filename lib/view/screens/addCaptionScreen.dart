

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tok_tik/controller/upload_video_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../widgets/textInputField.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;
   AddCaptionScreen({Key? key,required this.videoFile,required this.videoPath}) : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController ;
  VideoUploadController videoUploadController =   Get.put(VideoUploadController());
  TextEditingController songNameController = new TextEditingController();
  TextEditingController captionController = new TextEditingController();


  @override
  void dispose() {
    super.dispose();
    videoUploadController.dispose();
  }

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(widget.videoFile);
    super.initState();
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(false);
    videoPlayerController.setVolume(0.7);


  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      // WillPopScope(
      //   onWillPop: () async {
      //     bool shouldOpenDialogBox = await showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text('Are you sure you want to exit?'),
      //           actions: <Widget>[
      //             TextButton(
      //               onPressed: () => Navigator.pop(context, false),
      //               child: Text('No'),
      //             ),
      //             TextButton(
      //               onPressed: (){
      //                 Navigator.pop(context, true);
      //                 videoPlayerController.pause();
      //               },
      //
      //               child: Text('Yes',),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //     return shouldOpenDialogBox ?? false;
      //   },
       // child:
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                child: VideoPlayer(videoPlayerController),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextInputField(controller: songNameController,
                        myIcon: Icons.music_note,
                        myLabel: "Song Name"),
                    SizedBox(height: 20,),
                    TextInputField(controller: captionController,
                        myIcon: Icons.closed_caption,
                        myLabel: "Caption"),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      videoUploadController.uploadVideo(songNameController.text, captionController.text, widget.videoPath);
                      Navigator.pop(context);
                    },
                      child: Text("Upload") , style: ElevatedButton.styleFrom(backgroundColor:  buttonColor),)
                  ],
                ),
              )
            ],
          ),
        ),
     // ),

    );
  }
}
