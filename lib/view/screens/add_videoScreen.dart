import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tok_tik/utils/constants.dart';
import 'package:tok_tik/view/screens/addCaptionScreen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  videoPicker(ImageSource src,BuildContext context)async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video!=null){
      Get.snackbar("video picked", video.path);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCaptionScreen(videoFile: File(video.path), videoPath: video.path)) );
    }else{
      Get.snackbar("error", "please select other image");
    }
  }
  showDailogOpt(BuildContext context){
    return showDialog(context: context, builder: (context) =>
        SimpleDialog(
          title: Text('Select one'),
          insetPadding: EdgeInsets.all(40.0),
          children: [
            SimpleDialogOption(
              onPressed:()=>videoPicker(ImageSource.gallery,context),
              child: Text('Gallery',style: TextStyle(fontSize: 20),),),
            SimpleDialogOption(
              onPressed:()=>videoPicker(ImageSource.camera,context),
              child: Text('Camera',style: TextStyle(fontSize: 20)),),
            SimpleDialogOption(
                onPressed:()=>Navigator.pop(context),
              child: Text('Back',style: TextStyle(fontSize: 20)),)
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDailogOpt(context),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,

            ),
            child: const Center(
              child: Text(
                "Add video" , style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
