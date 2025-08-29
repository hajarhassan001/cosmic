import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  
  MediaQueryData get media => MediaQuery.of(this);

  Size get size => media.size;
  double get width => size.width;
  double get height => size.height;
}



//     final size = context.media.size;
//     final width = size.width;
//     final height = size.height;


// SizedBox(height: height * 120 / 812),
// SizedBox(width: width * 120 / 375),