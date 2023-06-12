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
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SKycVerificationController extends ChangeNotifier {
  SKycVerificationRepo sKycVerificationRepo = SKycVerificationRepo();
  TextEditingController adharCardController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  bool adharCardValidation = false;
  bool panCardValidation = false;

  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  // File fileToDisplay = File("");
  File fileImage1 = File("");
  File fileImage2 = File("");
  File fileImage3 = File("");
  File fileImage4 = File("");

  String networkImage1 = "";

  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";

  String? pdfPath;
  void onVerifyChecked(value) {
    adharCardValidation = value;
    notifyListeners();
  }

  // Future<void> pickPDF() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf', 'jpg'],
  //     );
  //     if (result != null) {
  //       // setState(() {
  //       pdfPath = result.files.single.path;
  //       // });
  //     }
  //   } catch (e) {
  //     print('Error while picking the file: $e');
  //   }
  //   notifyListeners();
  // }

  void openGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage1 = "";
      fileImage1 = File(pickedFile.path);
      final bytes = await compressFile(fileImage1);

      image1 = base64Encode(bytes as List<int>);

      networkImage1 = "";
      fileImage1 = File(pickedFile.path);
    }

    notifyListeners();
  }

  void openGallery2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      // networkImage2 = "";
      fileImage2 = File(pickedFile.path);
    }

    notifyListeners();
  }

  void openGallery3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      // networkImage3 = "";
      fileImage3 = File(pickedFile.path);
    }

    notifyListeners();
  }

  void openGallery4() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      // networkImage4 = "";
      fileImage4 = File(pickedFile.path);
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
    if (fileImage1.path == "") {
      Utils.showPrimarySnackbar(context, "Please Select Adhar Card Image",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (fileImage2.path == "") {
      Utils.showPrimarySnackbar(context, "Please Select Pan Card Image",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (adharCardController.text.length < 11) {
      Utils.showPrimarySnackbar(context, "Please Enter Adhar Card Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }

    if (panCardController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Pan Card Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SSubscriptionScreenView(loggedIn: false,)));
  }
}
