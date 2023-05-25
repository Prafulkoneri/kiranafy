import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/model/s_kyc_verification_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/repositrory/s_kyc_verification_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SKycVerificationController extends ChangeNotifier {
  SKycVerificationRepo sKycVerificationRepo = SKycVerificationRepo();

  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File fileToDisplay = File("");

  void pickFile() async {
    try {
      isLoading = true;
      result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
        allowMultiple: false,
      );
      if (result != null) {
        fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
        print("File name $fileName");
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // void onFileAadharCardClicked() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowedExtensions: ['img'],
  //   );
  //   print(result?.files.first.name);
  //   var fileName = result?.files.first.name ?? "no file selected";
  // }
  // Upload(File imageFile) async {
  //   var stream =  http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //     var length = await imageFile.length();

  //     var uri = Uri.parse("");

  //    var request =  http.MultipartRequest("POST", uri);
  //     var multipartFile =  http.MultipartFile('file', stream, length,
  //         filename: basename(imageFile.path));
  //         //contentType: new MediaType('image', 'png'));

  //     request.files.add(multipartFile);
  //     var response = await request.send();
  //     print(response.statusCode);
  //     response.stream.transform(utf8.decoder).listen((value) {
  //       print(value);
  //     });
  //   }

  ShopKycVerificationReqModel get shopKycVerificationReqModel =>
      ShopKycVerificationReqModel();

  Future<void> sendKycDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    sKycVerificationRepo.sendKycDetails(
        shopKycVerificationReqModel, pref.getString("successToken"));
  }

  void onUploadClicked(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SSubscriptionScreenView()));
  }

  /////////////////////////////////
}
