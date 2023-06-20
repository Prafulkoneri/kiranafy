import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/model/s_kyc_verification_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/repositrory/s_kyc_verification_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_completed.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class SKycVerificationController extends ChangeNotifier {
  SKycVerificationRepo sKycVerificationRepo = SKycVerificationRepo();
  TextEditingController adharCardController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController gstController = TextEditingController();
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
    if (adharCardController.text.length < 12) {
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
    print("hellooo");
    uploadImage(context);
  }

  Future uploadImage(context) async {
    print("888888");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.uploadKycVerification}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['shop_owner_aadhar_card_no'] = adharCardController.text;
    request.fields['shop_owner_pan_card_no'] = panCardController.text;
    request.fields['shop_owner_gst_no'] = gstController.text;

    List<http.MultipartFile> newList = <http.MultipartFile>[];
    File imageFile1 = fileImage1;
    File imageFile2 = fileImage2;
    File imageFile3 = fileImage3;
    File imageFile4 = fileImage4;
    var stream1 =
        new http.ByteStream(DelegatingStream.typed(imageFile1.openRead()));
    var stream2 =
        new http.ByteStream(DelegatingStream.typed(imageFile2.openRead()));
    var stream3 =
        new http.ByteStream(DelegatingStream.typed(imageFile3.openRead()));
    var stream4 =
        new http.ByteStream(DelegatingStream.typed(imageFile4.openRead()));
    var length1 = await imageFile1.length();
    var length2 = await imageFile2.length();
    var multipartFile1 = new http.MultipartFile(
        "shop_owner_aadhar_card_image_path", stream1, length1,
        filename: basename(imageFile1.path));
    newList.add(multipartFile1);
    var multipartFile2 = new http.MultipartFile(
        "shop_owner_pan_card_image_path", stream2, length2,
        filename: basename(imageFile2.path));
    newList.add(multipartFile2);
    //
    //
    if (imageFile3.path != "") {
      var length3 = await imageFile3.length();
      var multipartFile3 = new http.MultipartFile(
          "shop_owner_shop_act_image_path", stream3, length3,
          filename: basename(imageFile3.path));
      newList.add(multipartFile3);
    }
    //
    if (imageFile4.path != "") {
      var length4 = await imageFile4.length();
      var multipartFile4 = new http.MultipartFile(
          "shop_owner_gst_image_path", stream4, length4,
          filename: basename(imageFile4.path));
      newList.add(multipartFile4);
    }
    // print(newList);
    request.files.addAll(newList);
    print(request.fields);
    await request.send().then((response) async{
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => KycCompletedView()));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('status', 'kycUploaded');
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
      } else {
        Utils.showPrimarySnackbar(context, "Error on uploading",
            type: SnackType.error);
        return;
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
  }
}
