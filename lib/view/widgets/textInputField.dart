import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class TextInputField extends StatelessWidget {
   const TextInputField({Key? key, required this.controller, required this.myIcon, required this.myLabel,  this.toHide = false}) : super(key: key);
final TextEditingController controller;
final IconData myIcon;
final String myLabel;
final bool toHide;

  @override
  Widget build(BuildContext context) {
    return  TextField(
        controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
          labelText: myLabel,
           icon: Icon(myIcon),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )
        ),

      ),

    );
  }
}
