
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/foundation.dart"  ;
import 'package:flutter/material.dart';

import '../../../constant/colors/app-colors.dart';
import '../../../controller/componants/applooder/apploder.dart';
import '../../../controller/componants/button-widget.dart';
import '../../../controller/componants/primary-text-componant.dart';
import '../../../controller/componants/text-form-field.widget.dart';

class InsertData extends StatefulWidget {
  String userEmail;
  InsertData({super.key, required this.userEmail});

  @override
  State<InsertData> createState() => _InsertDataState();
}
class _InsertDataState extends State<InsertData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  // function for insert data into real time data base
  inserData()async{
    try
    {
      isLoading=true;
      setState(() {

      });
      String id=DateTime.now().second.toString();//millisecondsSinceEpoch.toString();

      await FirebaseFirestore.instance.collection(widget.userEmail)
          .doc(id)
          .set({
        //key :  value
        //field : value
        'title':titleController.text,
        'description':descriptionController.text,
        'id':id
      });
    }
    catch (error){
      isLoading=false;
      setState(() {

      });
      print('Error:$error');
    }finally
    {
      Navigator.pop(context);
    }


  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Insert Data',),
      ),
      body: Center(child: Column(children: [
        SizedBox(height: 40,),
        PrimaryTextWidget(text: 'Insert Data',textsize: 30,),
        TextFormWidgetUpdate(hintText: 'Enter Title', controller: titleController),
        TextFormWidgetUpdate(hintText: 'Enter Descrptions', controller: descriptionController),
        SizedBox(height: 10,),

        isLoading?AppLoader():
        ButtonWidget(text: 'Add', ontap: (){
          inserData();

        })
      ],),),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('descriptionController', descriptionController));
    properties.add(DiagnosticsProperty<TextEditingController>('descriptionController', descriptionController));
  }
}