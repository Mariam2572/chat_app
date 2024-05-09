import 'package:chat_route/my_theme.dart';
import 'package:flutter/material.dart';


//typedef myValidator = String? Function(String?);
class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType;
  bool obscureText;
  Widget? suffixIcon;
  String? Function(String?) validator;
  CustomTextFormField({
    this.suffixIcon,
    required this.validator,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        obscureText: obscureText,
        obscuringCharacter: '*',
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            label: Text(label),
            labelStyle: TextStyle(
                      color:  MyTheme.blackDark,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: 
                       MyTheme.primary,
                )),
            focusedBorder:
                OutlineInputBorder(  borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: MyTheme.primary,
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: MyTheme.redColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: MyTheme.redColor),
            )),
      ),
    );
  }
}
