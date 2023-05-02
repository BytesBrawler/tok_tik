import 'package:flutter/material.dart';
import 'package:tok_tik/controller/auth_controller.dart';
import 'package:tok_tik/utils/constants.dart';
import 'package:tok_tik/view/screens/auth/loginScreen.dart';
import 'package:tok_tik/view/screens/auth/signupScreen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'tik tok  clone app',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: SignUpScreen(),
    );
  }
}

