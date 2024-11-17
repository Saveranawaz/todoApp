import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/controller/componants/primary-text-componant.dart';

import '../../constant/app-assets/images.dart';
import '../../controller/componants/image-componant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 290.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageComponet(image: AppImages.splashImage),
                //Image.asset(AppImages.splashImage,height: 100,),
                PrimaryTextWidget(text: 'Todo App')
                //Text('Todo App',style: TextStyle(color: AppColors.appPrimaryColor),)
              ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              PrimaryTextWidget(
                text: 'Developed By', textweight: FontWeight.w100,),
              PrimaryTextWidget(
                text: 'khan khan', textweight: FontWeight.w900,),
            ],),
          )
        ],
      ),),
    );
  }

}