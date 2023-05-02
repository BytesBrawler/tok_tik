import 'package:flutter/material.dart';
import 'package:tok_tik/controller/auth_controller.dart';

import '../../widgets/glitch.dart';
import '../../widgets/textInputField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/signup.jpg"))),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlithEffect(child: const Text("Welcome To " , style: TextStyle(fontSize: 60,fontWeight: FontWeight.w600),)),
                  GlithEffect(child: const Text("Tok Tik " , style: TextStyle(fontSize: 80,fontWeight: FontWeight.w600),))
                  , GlithEffect(child: const Text("tik tok ki sasti copy" , style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),))

                  ,const SizedBox(height: 20,),
                  InkWell(
                    onTap: () => AuthController.instance.pickImage(),
                    child: Stack(
                      children: const [
                        CircleAvatar(backgroundColor: Colors.transparent,radius: 60,),
                        Positioned(
                            right: 0,
                            left: 0,
                            bottom: 0,
                            top: 0,


                            child: Icon(Icons.camera))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _usernameController,
                      myIcon: Icons.person,
                      myLabel: 'Username',
                    ),
                  ),
                  SizedBox(height: 20,),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _emailController,
                      myIcon: Icons.email,
                      myLabel: 'Email',
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _passwordController,
                      myIcon: Icons.lock,
                      myLabel: "Password",
                      toHide: true,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _confirmPasswordController,
                      myIcon: Icons.lock,
                      myLabel: "Confirm Password",
                      toHide: true,
                    ),
                  ),


                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: () {
                      AuthController.instance.signUp(_usernameController.text, _emailController.text, _passwordController.text,
                          AuthController.instance.proImg
                          );
                  },
                      child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 10),
                      child: Text("Sign Up ")))

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
