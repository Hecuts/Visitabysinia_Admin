

import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {

  String label;
  bool obscureText;
  TextEditingController controller;
  String errorMsg;
  bool isPhone;
  bool isNumber;
  String hint;
  CustomInputField({this.label = '',this.hint = "", this.obscureText = false,@required this.controller,@required this.errorMsg, this.isPhone = false, this.isNumber = false});
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: isPhone == true ? TextInputType.phone :( isNumber == true ? TextInputType.number: null),
          decoration: InputDecoration(
            hintText: this.hint,
            errorText: errorMsg =="" ? null : errorMsg,
            errorStyle: TextStyle(color: Colors.red),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
      ],
    );
  }
}
