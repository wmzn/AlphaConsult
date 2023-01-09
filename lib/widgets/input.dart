import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final int min;
  int max;
  bool issecured;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.controller,
      this.min,
      this.max,
      this.issecured});

  @override
  Widget build(BuildContext context) {
    if (this.max == null) {
      this.max = 1;
    }
    if (this.issecured == null) {
      issecured = false;
    }
    return TextFormField(
        cursorColor: ArgonColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        obscureText: issecured,
        controller: controller,
        autofocus: autofocus,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter full name';
          }
          return null;
        },
        minLines: this.min,
        maxLines: this.max,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            errorStyle: TextStyle(
                height: 0.85, fontSize: 14.0, color: ArgonColors.error),
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(
              color: ArgonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: ArgonColors.error,
                    width: 1.0,
                    style: BorderStyle.solid)),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(4.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
