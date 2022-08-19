import 'package:chat_now/shared/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.labelText,
    required this.iconData,
    this.textColor,
    this.fontWeight,
    required this.controller,
    required this.validator,
  }) : super(key: key);
  final String? labelText;
  final IconData iconData;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextEditingController controller;
  final String validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: textColor == null ? Colors.black : textColor!,
            fontWeight: fontWeight == null ? FontWeight.w400 : fontWeight,
          ),
          prefixIcon: Icon(iconData, color: Theme.of(context).primaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.primaryColor,
              width: 2,
            ),
          ),
        ),
        validator: (val) {
          if (validator == "email") {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!)
                ? null
                : "Please enter a valid email";
          } else if (validator == "password") {
            return RegExp(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                    .hasMatch(val!)
                ? null
                : "Minimum eight characters, at least one uppercase letter, \none lowercase letter, one number and one special character";
          } else {
            if(val!.isNotEmpty){
            return null;
            }
            else{
              return "{$validator} can't be empty";
            }
          }
        });
  }
}
