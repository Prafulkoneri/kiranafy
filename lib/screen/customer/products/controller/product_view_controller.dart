import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/add_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/repository/remove_fav_shop_repo.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/screen/customer/products/model/add_admin_product_to_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/add_custom_product_to_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/product_unit_images_res_model.dart';
import 'package:local_supper_market/screen/customer/products/model/product_view_model.dart';

import 'package:local_supper_market/screen/customer/products/model/remove_admin_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_custom_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/repository/add_admin_product_to_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/add_custom_product_to_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_unit_image_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_view_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_admin_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_custom_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductViewController extends ChangeNotifier {
  String? shopId = "";
  String? categoryId = "";
  String? productId = "";
  String? selectedUnitId = "";
  String? productImage = "";
  String? productType = "";
  bool isLoading = true;
  bool favAllShop = true; //fvrt
  bool isFavProduct = true; //fvrt Product
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  ProductViewData? productViewData;
  ProductDetails? productDetails;
  ProductViewShopDetails? shopDetails;
  List<ProductUnitDetail>? productUnitDetail;
  List<CustomerProductData>? similarProduct;
  List unitImages = [];
  ProductViewRepo productViewRepo = ProductViewRepo();
  ProductUnitImageRepo productUnitImageRepo = ProductUnitImageRepo();
  AddAdminProductToFavRepo addAdminProductToFavRepo =
      AddAdminProductToFavRepo();
  AddCustomProductToFavRepo addCustomProductFavRepo =
      AddCustomProductToFavRepo();
  RemoveAdminFvrtProductRepo removeFavProductRepo =
      RemoveAdminFvrtProductRepo();
  RemoveCustomFvrtProductRepo removeCustomFavProductRepo =
      RemoveCustomFvrtProductRepo();
  AddProductToCartRepo addProductToCartRepo=AddProductToCartRepo();

  Future<void> initState(context, sId, cId, pId, suId, pType) async {
    await productsView(context, sId, cId, pId, pType);
    print("55555555555555555555555555555555555");
    print(pId);
    unitImages.clear();
    print(pType);
    // await productsUnitImage(context, suId);
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  ProductViewRequestModel get productViewRequestModel =>
      ProductViewRequestModel(
          shopId: shopId, categoryId: categoryId, productId: productId);

  Future<void> productsView(context, sId, cId, pId, pType) async {
    // print("id$id");
    print("helohhhhhhhhooooooooooooo");
    shopId = sId;
    categoryId = cId;
    productId = pId;
    productType = pType;
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productViewRepo
        .showProductsViewRepo(
            productViewRequestModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          ProductViewResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        productViewData = result.data;
        productDetails = productViewData?.productDetails;
        productImage = productDetails?.productImagePath;
        shopDetails = productViewData?.shopDetails;
        productUnitDetail = productViewData?.productUnitDetails;
        similarProduct = productViewData?.similarProducts;
        favAllShop = shopDetails?.isFvrt == "yes" ? true : false;
        isFavProduct = productDetails?.isProductFvrt == "yes" ? true : false;
        showLoader(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  /////////////////////Product Unit Image/////////////////////

  UnitImagesRequestModel get unitImagesReqModel =>
      UnitImagesRequestModel(slectedUnitId: selectedUnitId);

  Future<void> productsUnitImage(context, suId) async {
    // print("id$id");
    print("bybeeeeeeeeeeeeeeeeeeeeeeeee");
    selectedUnitId = suId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productUnitImageRepo
        .productUnitImageRepo(
            unitImagesReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result =
          UnitImagesResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // unitImages = result.data;
        // productImage = unitImages?.unitBasedProductImagePath;
        unitImages = result.data?.unitBasedProductImagePath ?? [];
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  AddCustomProductToFavReqModel get addCustomProductToFavReqModel =>
      AddCustomProductToFavReqModel(
        shopId: shopId,
        productId: productId,
      );
//////Add Admin Product To favrt////
  AddAdminProductToFavReqModel get addAdminProductToFavReqModel =>
      AddAdminProductToFavReqModel(
        shopId: shopId,
        productId: productId,
      );

  Future addToFavProduct(context) async {
    if (productType == "admin_product") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      addAdminProductToFavRepo
          .addAdminProductToFav(
              addAdminProductToFavReqModel, pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result =
            AddAdminProductToFavResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          isFavProduct = true;
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      }).onError((error, stackTrace) {
        Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      }).catchError(
        (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        },
        test: (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
          return false;
        },
      );
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      addCustomProductFavRepo
          .addCustomeProductToFav(
              addCustomProductToFavReqModel, pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result =
            AddCustomProductToFavResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          isFavProduct = true;
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      }).onError((error, stackTrace) {
        Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      }).catchError(
        (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        },
        test: (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
          return false;
        },
      );
    }
  }

  /////End/////
  RemoveAdminProductReqModel get removeFavProductReqModel =>
      RemoveAdminProductReqModel(
          shopId: shopId.toString(), productId: productId.toString());

  RemoveCustomProductReqModel get removeCustomeProductReqModel =>
      RemoveCustomProductReqModel(
          shopId: shopId.toString(), productId: productId.toString());

  Future<void> removeFavProduct(
    context,
  ) async {
    if (productType == "admin_product") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      removeFavProductRepo
          .removeAdminProductRepo(
              removeFavProductReqModel, pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          isFavProduct = false;
          print("hello");
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      }).onError((error, stackTrace) {
        Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      }).catchError(
        (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        },
        test: (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
          return false;
        },
      );
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      removeCustomFavProductRepo
          .removeCustomProductRepo(
              removeCustomeProductReqModel, pref.getString("successToken"))
          .then((response) {
        log("response.body${response.body}");
        final result =
            RemoveCustomProductResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          isFavProduct = false;
          print("hello");
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
          notifyListeners();
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      }).onError((error, stackTrace) {
        Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      }).catchError(
        (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        },
        test: (Object e) {
          Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
          return false;
        },
      );
    }
  }

  void launchPhone(String mobNumber, context) async {
    var number = Uri.parse("tel:${mobNumber}");
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      Utils.showPrimarySnackbar(context, "Unable to dial at the moment",
          type: SnackType.error);
    }
  }

  ////////////Add Fvrt/////////////
  AddFavReqModel get addFavReqModel => AddFavReqModel(
        shopId: shopId.toString(),
      );
  Future<void> updateAllShopFavList(context, id) async {
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    addFavShopRepo
        .updateAddFavShop(addFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = true;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  ////////////////Remove//////////////
  RemoveFavReqModel get removeFavReqModel => RemoveFavReqModel(
        shopId: shopId.toString(),
      );
  RemoveFavShopRepo removeFavShopRepo = RemoveFavShopRepo();

  Future<void> removeAllShopFavList(context, id) async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print("id${id}");
    shopId = id.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeFavShopRepo
        .updateRemoveFavShop(removeFavReqModel, pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = RemoveFavResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        favAllShop = false;
        print("hello");
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
  ///////////////End/////////////

  void onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/images/redlabel.png');
    // final data = '${productDetails?.productImagePath}/image1.jpg';

    final buffer = data.buffer;
    // final buffer = path
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'flutter_logo',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  Future<void> addToCart(pType,pId,sId,context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(AddProductToCartReqModel(productType:pType,productUnitId: pId.toString(),shopId: sId.toString(),quantity:"1"),pref.getString("successToken"))
        .then((response) {
      log("response.body${response.body}");
      final result = AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }


/////////////////////////
  //   void onBackPressed(screenName,context,cId){
  //   print(screenName);
  //   if(screenName=="allNearShopView"){
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MainScreenView(
  //               index: 1,
  //               screenName: AllNearShopsView(refreshPage: false,)
  //           )),
  //           (Route<dynamic> route) => false,
  //     );
  //   }
  //   if(screenName=="nearShopsCategory"){
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MainScreenView(
  //               index: 1,
  //               screenName: AllNearCategoryShopsView(categoryId: cId,refresh: false,)
  //           )),
  //           (Route<dynamic> route) => false,
  //     );
  //   }
  //   if(screenName=="homeNearbyShop"){
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MainScreenView(
  //               index: 1,
  //               screenName: HomeScreenView(refreshPage: false,)
  //           )),
  //           (Route<dynamic> route) => false,
  //     );
  //   }
  //   else{
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MainScreenView(
  //               index: 1,
  //               screenName: HomeScreenView(refreshPage: false)
  //           )),
  //           (Route<dynamic> route) => false,
  //     );
  //   }
  // }
}
