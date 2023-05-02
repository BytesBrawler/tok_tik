
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../model/video_model.dart';

class VideoUploadController extends GetxController {
//   static VideoUploadController instance = Get.find();
//   var uuid =  const Uuid();
//
//   uploadVideo(String songName ,String caption,String videoPath)async{
//     try{
//
//       String uid = FirebaseAuth.instance.currentUser!.uid;
//
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
//    //video -uuid
//     String id = uuid.v1();
//     String videoUrl = await _uploadVideoToStorage(id,videoPath);
//     String thumbnail = await _uploadVideoThumbToStorage(id,videoPath);
//       print("beta ${(documentSnapshot.data()! as Map<String , dynamic>).toString()}");
//
//     VideoModel video = VideoModel(
//         username: (documentSnapshot.data()! as Map<String ,dynamic>)["name"],
//         uid: uid,
//         thumbnail: thumbnail,
//         caption: caption,
//         commentsCount: 0 ,
//         id: id,
//         likes: [],
//         profilePic:(documentSnapshot.data()! as Map<String ,dynamic>)['profilePic'] ,
//         shareCount: 0,
//         songName: songName,
//         videoUrl: videoUrl
//     );
//
//     await FirebaseFirestore.instance.collection("videos").doc("id").set(video.toJson());
//     Get.snackbar("Video uploaded succesffully", "Thank you for uploading video");
//     Get.back();
//   }catch(e){
//       print("alpha $e");
//       print("alpha");
//     Get.snackbar("Error occur", e.toString());
//   }
//   }
//   Future<String> _uploadVideoToStorage(String videoId,String videoPath)async{
//     Reference reference = FirebaseStorage.instance.ref().child("videos").child(videoId);
//     UploadTask uploadTask = reference.putFile(_compressVideo(videoPath));
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//
//   }
//
//    _compressVideo(String videoPath)async{
//     final compressedVideo = await  VideoCompress.compressVideo(videoPath,quality: VideoQuality.MediumQuality);
//     return compressedVideo!.file;
//   }
//
//   Future<String> _uploadVideoThumbToStorage(String id,String videoPath)async{
//     Reference reference = FirebaseStorage.instance.ref().child("thumb").child(id);
//     UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   Future<File> _getThumb(String videoPath)async{
//     final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
//     return thumbnail;
//
//   }
// }

  var uuid = const Uuid();

  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference = FirebaseStorage.instance.ref()
        .child("thumbnail")
        .child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Main Video Upload
  //Video To Storage
  //Video Compress
  //Video Thumb Gen
  //Video Thumb To Storage

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          "users").doc(uid).get();
      //videoID - uuid
      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);
      String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
      //IDHAR SE
      print("map");
      print((userDoc.data()! as Map<String, dynamic>).toString());
      VideoModel video = VideoModel(
          uid: uid,
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          songName: songName,
          shareCount: 0,
          commentsCount: 0,
          likes: [],
          profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
          caption: caption,
          id: id
      );
      print("error occurs in model");
      await FirebaseFirestore.instance.collection("videos").doc(uid).collection("all videos").doc(id).set(
          video.toJson());
      print("video uploaded successfully");
      Get.snackbar(
          "Video Uploaded Successfully", "Thank You Sharing Your Content");
      Get.back();
    } catch (e) {

      Get.snackbar("Error Uploading Video", e.toString());
    }
  }


  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference = FirebaseStorage.instance.ref().child("videos").child(
        videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressedVideo =
    await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }
}