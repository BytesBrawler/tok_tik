
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tok_tik/model/MyUser.dart';
import 'package:tok_tik/view/screens/Home.dart';
import 'package:tok_tik/view/screens/auth/loginScreen.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
File? proImg;
  pickImage()async{
    final image = await ImagePicker().pickImage(source:ImageSource.gallery);
    if(image  == null) {
      print("no image selected");
      return;}
    else{
      final img = File(image.path);
      this.proImg = img;
      Get.snackbar('image selected', "image is done");
      print("image selected");
    }

  }
  late Rx<User?> _user;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(_user, _setInitialView);

  }
  //register

  void signUp(
      String username,
      String email,
      String password,
      File? image
      ) async{

    try{
       if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty &&
           image !=null
           ){
         UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
       String downloadUrl = await _uploadProPic(image);

       MyUser user = MyUser(name: username,
           profilePhoto: downloadUrl,
           email: email, uid: credential.user!.uid);
       await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.tojson());
       }
       else{
         Get.snackbar("Error creating acount", "please complete the field");
       }
    }catch(e){
      print(e);
      Get.snackbar("Error Occurred", e.toString());
    }

  }

  //signin
  void login(String email ,String password)async{
    try{
        if(email.isNotEmpty && password.isNotEmpty){
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        }else{
          Get.snackbar("Error while log in", "complete fields");
        }
    }catch(e){
      Get.snackbar("error while login", e.toString());
    }
  }





  Future<String> _uploadProPic(File image)async{
    Reference ref = FirebaseStorage.instance.ref().child('profilePic').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask=ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDownUrl = await snapshot.ref.getDownloadURL();
    return imageDownUrl;
  }

  _setInitialView(User? user) {
    if(user==null) {
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() => HomeScreen());
    }
  }
}

