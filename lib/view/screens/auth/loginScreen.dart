import 'package:flutter/material.dart';
import 'package:tok_tik/controller/auth_controller.dart';
import 'package:tok_tik/view/widgets/glitch.dart';
import 'package:tok_tik/view/widgets/textInputField.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
   TextEditingController _emailController = new TextEditingController();
 TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/login.jpg"))),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlithEffect(child: const Text("Tok Tik " , style: TextStyle(fontSize: 70,fontWeight: FontWeight.w600),))
                  , GlithEffect(child: const Text("tik tok is my clone " , style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),))

                  ,const SizedBox(height: 20,),

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

                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: () {
                      AuthController.instance.login(_emailController.text, _passwordController.text);
                  }, child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 10),
                      child: Text("Login ")))

                ],
              ),
            ),
          ],
        ),
    );
  }
}
