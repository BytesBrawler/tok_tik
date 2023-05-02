import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyUser{
  String name;
  String profilePhoto;
  String email;
  String uid;

  MyUser({
    required this.name,
    required this.profilePhoto,
    required this.email, required this.uid});


Map<String,dynamic> tojson()=>
    {
      "name" : name,
      "profilePhoto" : profilePhoto,
      "email" : email,
      "uid" : uid
    };

  static MyUser fromSnap(DocumentSnapshot snap){
        var snapshot =  snap.data() as Map<String , dynamic>;
        return MyUser(
          name:snapshot["name"],
          profilePhoto :snapshot["profilePhoto"],
            email :snapshot["email"],
          uid :snapshot["uid"]
        );
  }
}