 import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/select_category/view/s_select_category.dart';

class SKycVerificationController extends ChangeNotifier{
  void onFileUploadClicked()async{
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    print(result?.files.first.name);
    var fileName = result?.files.first.name ??
        "no file selected";
  }
  
  void onUploadClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SSelectCategoryView()));
  }
}