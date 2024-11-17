
import 'package:flutter/material.dart';

import '../../constant/colors/app-colors.dart';
class PrimaryTextWidget extends StatelessWidget {
  String text;
  double textsize;
  FontWeight textweight;
  PrimaryTextWidget({super.key, required this.text,
  this.textsize=18,
  this.textweight=FontWeight.bold
  });
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
        fontSize: textsize,
        color: AppColors.appPrimaryColor),)
    ;
  }
}