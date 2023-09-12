import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_supper_market/screen/customer/cart/model/add_product_to_cart_model.dart';
import 'package:local_supper_market/screen/customer/cart/model/cart_item_quantity_model.dart';
import 'package:local_supper_market/screen/customer/cart/repository/add_product_to_cart_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_detail_repo.dart';
import 'package:local_supper_market/screen/customer/cart/repository/cart_item_quantity_repo.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_detail_view.dart';
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
import 'package:local_supper_market/screen/customer/shop_profile/model/remove_item_cart_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/repository/remove_item_from_cart_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_admin_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/model/remove_custom_product_from_fav_model.dart';
import 'package:local_supper_market/screen/customer/products/repository/add_admin_product_to_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/add_custom_product_to_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_unit_image_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/product_view_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_admin_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/repository/remove_custom_product_fav_repo.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as Path;

class ProductViewController extends ChangeNotifier {
  String? shopId = "";
  String? categoryId = "";
  String? productId = "";
  String? selectedUnitId = "";
  String? productImage = "";
  String? productType = "";
  String? cartId;
  String? addProductUnitId;
  String? addProductType;
  String? addProductShopId;
  bool isQuanityBtnPressed = false;
  bool isLoading = true;
  bool favAllShop = true; //fvrt
  bool isFavProduct = true; //fvrt Product
  AddFavShopRepo addFavShopRepo = AddFavShopRepo();
  ProductViewData? productViewData;
  ProductDetails? productDetails;
  ProductViewShopDetails? shopDetails;
  List<ProductUnitDetail>? productUnitDetail;
  List<CustomerProductData>? similarProduct;
  List quantityList = [];
  bool isUnitImagesVisible = false;
  String routeName = "";
  List unitImages = [];
  List cartItemIdList = [];
  String cartItemId = "";
  String quantityAction = "";

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
  AddProductToCartRepo addProductToCartRepo = AddProductToCartRepo();
  UnitBasedProductImagePath? data;
  CartItemQuantityRepo cartItemQuantityRepo = CartItemQuantityRepo();

  Future<void> initState(context, sId, cId, pId, suId, pType, rName) async {
    isUnitImagesVisible = false;
    print("productId");
    print(pId);
    print(productId);
    quantityList.clear();
    unitImages.clear();
    cartItemIdList.clear();
    await productsView(context, sId, cId, pId, pType);
    // await productsUnitImage(context, suId);
    print("55555555555555555555555555555555555");
    print(pId);
    unitImages.clear();
    print(pType);

    routeName = rName;

    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  showUnitImages(value) {
    isUnitImagesVisible = value;
    notifyListeners();
  }

  quantityBtnPressed(value) {
    isQuanityBtnPressed = value;
    notifyListeners();
  }

  getCartId(id) {
    print("iiiiiiiiiiiiiiiiiiii");
    cartId = id;
    print("kirannnnnn");
    print(cartId);
    print("kirannnnnn");
  }

  onBackPressed(context) {
    if (routeName == "cart_details") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CartDetailView(
                  isRefresh: true,
                  shopId: shopDetails?.id.toString(),
                  cartId: cartId)));
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenView(
                index: 1,
                screenName: ShopProfileView(
                  refreshPage: true,
                  routeName: '',
                  shopId: shopDetails?.id.toString(),
                ))),
        (Route<dynamic> route) => false,
      );
    }
  }

  CartItemQuantityReqModel get cartItemQuantityRequestModel =>
      CartItemQuantityReqModel(
          cartItemId: cartItemId,
          quantityAction: quantityAction,
          productType: productType,
          shopId: shopDetails?.id);

  Future<void> subtractItemQuantity(
      context, CIId, index, pType, pUnitId) async {
    quantityBtnPressed(true);
    print("*********");
    print(quantityList);
    print(quantityList[index]);
    print("*********");
    quantityAction = "subtract";
    cartItemId = cartItemIdList[index].toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      dev.log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        int value = quantityList[index];
        quantityList.removeAt(index);
        print("${value}valueeeeeeeee");
        quantityList.insert(index, value - 1);

        if (quantityList[index] == 0) {
          removeFromCart(pType, pUnitId, shopDetails?.id, index, context);
          isUnitImagesAdded[index] = false;
        }
        quantityBtnPressed(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> addItemQuantity(context, CIId, index) async {
    quantityBtnPressed(true);
    quantityAction = "add";
    cartItemId = cartItemIdList[index].toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    cartItemQuantityRepo
        .cartItemQuantity(
            cartItemQuantityRequestModel, pref.getString("successToken"))
        .then((response) {
      dev.log("response.body${response.body}");
      final result =
          CartItemQuantityResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        int value = quantityList[index];
        quantityList.removeAt(index);
        quantityList.insert(index, value + 1);
        quantityBtnPressed(false);

        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        quantityBtnPressed(false);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
      quantityBtnPressed(false);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        quantityBtnPressed(false);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> addToCart(pType, pId, sId, index, context) async {
    print("quantityList1${quantityList}");
    SharedPreferences pref = await SharedPreferences.getInstance();
    addProductToCartRepo
        .addProductToCart(
            AddProductToCartReqModel(
                productType: pType,
                productUnitId: pId.toString(),
                shopId: sId.toString(),
                quantity: "1"),
            pref.getString("successToken"))
        .then((response) {
      dev.log("response.body${response.body}");
      final result =
          AddProductToCartResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cartItemId = result.cartItemId.toString();
        print("quantityList2${quantityList}");
        // quantityList.removeAt(index);
        // quantityList.insert(index,1);
        print("quantityList3${quantityList}");
        cartItemIdList.insert(index, result.cartItemId);
        isSimilarProductAdded[index] = true;
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

  ProductViewRequestModel get productViewRequestModel =>
      ProductViewRequestModel(
          shopId: shopId,
          categoryId: categoryId,
          productId: productId,
          productType: productType);

  Future<void> productsView(context, sId, cId, pId, pType) async {
    // print("id$id");

    print("helohhhhhhhhooooooooooooo");
    shopId = sId.toString();
    categoryId = cId.toString();
    productId = pId.toString();
    productType = pType.toString();
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productViewRepo
        .showProductsViewRepo(
            productViewRequestModel, pref.getString("successToken"))
        .then((response) {
      dev.log('movieTitle: ${response.body}');

      // deb("response.body${response.body}");
      final result =
          ProductViewResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        quantityList.clear();
        productViewData = result.data;
        productDetails = productViewData?.productDetails;
        productImage = productDetails?.productImagePath;
        shopDetails = productViewData?.shopDetails;
        int unitDetailLength = productViewData?.productUnitDetails?.length ?? 0;
        for (int i = 0; i < unitDetailLength; i++) {
          quantityList.add(productViewData?.productUnitDetails?[i].quantity);
          cartItemIdList
              .add(productViewData?.productUnitDetails?[i].cartItemId);
        }
        print("quantityListInitState${quantityList}");
        print("cartIteMlIST${cartItemIdList}");
        favAllShop = shopDetails?.isFvrt == "yes" ? true : false;
        isFavProduct = productDetails?.isProductFvrt == "yes" ? true : false;

        /////////////Similar Products////////////////
        similarProduct = productViewData?.similarProducts;
        int similarProductLength = similarProduct?.length ?? 0;
        isSimilarProductAdded =
            List<bool>.filled(similarProductLength, false, growable: true);
        for (int i = 0; i < similarProductLength; i++) {
          if (similarProduct?[i].addToCartCheck == "yes") {
            isSimilarProductAdded.insert(i, true);
          } else {
            isSimilarProductAdded.insert(i, false);
          }
        }
        //////////////////Unit Images////////////////
        productUnitDetail = productViewData?.productUnitDetails;
        int productUnitImageLength = productUnitDetail?.length ?? 0;
        isUnitImagesAdded =
            List<bool>.filled(productUnitImageLength, false, growable: true);
        for (int i = 0; i < productUnitImageLength; i++) {
          if (productUnitDetail?[i].addToCartCheck == "yes") {
            isUnitImagesAdded.insert(i, true);
          } else {
            isUnitImagesAdded.insert(i, false);
          }
        }
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

///////////
  void onSimilarProductSelected(index) {
    isSimilarProductAdded[index] = true;
    notifyListeners();
  }
/////////////

  void onUnitImagesSelected(index) {
    isUnitImagesAdded[index] = true;
    quantityList.removeAt(index);
    quantityList.insert(index, 1);
    notifyListeners();
  }

  List<bool> isUnitImagesAdded = [];
  List<bool> isSimilarProductAdded = [];
  /////////////////////Product Unit Image/////////////////////

  void onUnitImageProductSelected(index) {
    isUnitImageProductAdded[index] = true;
    notifyListeners();
  }

  List<bool> isUnitImageProductAdded = [];
  UnitImagesRequestModel get unitImagesReqModel => UnitImagesRequestModel(
      slectedUnitId: selectedUnitId, productType: productType);

  Future<void> productsUnitImage(context, suId) async {
    // print("id$id");
    print("bybeeeeeeeeeeeeeeeeeeeeeeeee");
    print(suId);
    selectedUnitId = suId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    productUnitImageRepo
        .productUnitImageRepo(
            unitImagesReqModel, pref.getString("successToken"))
        .then((response) {
      print("2222222222222222222");
      dev.log('UnitImagess: ${response.body}');
      print("11111111111111111");
      final result =
          UnitImagesResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // unitImages = result.data;
        addProductShopId =
            result.data?.unitBasedProductImagePath?.shopId.toString();
        addProductUnitId =
            result.data?.unitBasedProductImagePath?.productUnitId.toString();
        addProductType =
            result.data?.unitBasedProductImagePath?.productType.toString();
        unitImages = result.data?.unitBasedProductImagePath?.imageList ?? [];
        data = result.data?.unitBasedProductImagePath;
        ///////////////////////
        // similarProduct = productViewData?.similarProducts;
        // int unitProductLength = similarProduct?.length ?? 0;
        // isSimilarProductAdded =
        //     List<bool>.filled(similarProductLength, false, growable: true);
        // for (int i = 0; i < similarProductLength; i++) {
        //   if (similarProduct?[i].addToCartCheck == "yes") {
        //     isSimilarProductAdded.insert(i, true);
        //   } else {
        //     isSimilarProductAdded.insert(i, false);
        //   }
        // }

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
        // log("response.body${response.body}");
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
        // log("response.body${response.body}");
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
        // log("response.body${response.body}");
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
        // log("response.body${response.body}");
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
      // log("response.body${response.body}");
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
      // log("response.body${response.body}");
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

  // void onShareXFileFromAssets(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   final data = await rootBundle.load('assets/images/redlabel.png');
  //   // final data = '${productDetails?.productImagePath}/image1.jpg';

  //   final buffer = data.buffer;
  //   // final buffer = path
  //   final shareResult = await Share.shareXFiles(
  //     [
  //       XFile.fromData(
  //         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  //         name: 'flutter_logo',
  //         mimeType: 'image/png',
  //       ),
  //     ],
  //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  //   );

  //   scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  // }

  fileFromImageUrl(String url, String userName) async {
    final response = await http.get(
      Uri.parse(url),
    );

    final documentDirectory = await getApplicationDocumentsDirectory();

    var randomNumber = Random();

    final file = File(Path.join(
      documentDirectory.path,
      "${randomNumber.nextInt(100)}_$userName.png",
    ));

    file.writeAsBytesSync(response.bodyBytes);

    return XFile(file.path);
  }

  void shareProduct(url) async {
    XFile fileForShare = await fileFromImageUrl(url, "Local Supermart");

    Share.shareXFiles([fileForShare],
        text:
            " Download Local Supermart now!\n Buy ${productDetails?.productName} at a discounted prices! \nDownload app here :  https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US",
        // "hey! check out this new app https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US",
        subject:
            "hey! check out this new app https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US");
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

  void updateProductId(
    value,
  ) {
    productId = value;

    notifyListeners();
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
  RemoveCartItemRepo removeCartItemRepo = RemoveCartItemRepo();

  Future<void> removeFromCart(pType, puId, sId, index, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    removeCartItemRepo
        .removeCartItem(
            RemoveItemFromCartReq(
                productType: pType.toString(),
                productUnitId: puId.toString(),
                shopId: sId.toString(),
                quantity: "0"),
            pref.getString("successToken"))
        .then((response) async {
      // log("response.body${response.body}");
      final result =
          CartRemoveResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cartItemIdList.insert(index, 0);
        isSimilarProductAdded[index] = false;
        // await getAllOfferes(context, sId);
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
