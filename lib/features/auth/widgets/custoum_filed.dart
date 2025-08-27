import 'package:cosmic/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustoumFiled extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;

  CustoumFiled({
    super.key,
    required this.label,
    required this.obscureText,
    required this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle( color: AppColor.textPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(25),   
            right: Radius.circular(25),  
          ),
          borderSide: BorderSide(
            color: AppColor.textPrimary,  
            width: 1, 
          ),
        ),
      ),
    );

  
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textField,
      );
    } else {
      return textField;
    }
  }
}
