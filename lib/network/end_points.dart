class Endpoint {
  Endpoint._();
  //testing url
  static const String baseUrl =
      'https://newcms.m-staging.in/local-super-mart-admin/api/';
  // Check Mobile Number Exist
  static const String checkMobNoExist =
      '${baseUrl}lsm-shop-owner-mobile-number-exists';
  // Get Country List
  static const String getCountryList = '${baseUrl}lsm-country-list';
  //Get State List
  static const String getStateList = '${baseUrl}lsm-state-list';
  //Get City List

  // shop Edit Profile
  static const String getShopEditProfileDetail =
      '${baseUrl}lsm-shop-owner-get-account-details';
  ////Shop Update Profile
  static const String shopUpdateAccountDetails =
      '${baseUrl}lsm-shop-owner-update-account-details';
//Shop city List
  static const String getCityList = '${baseUrl}lsm-city-list';
  //Get Area List
  static const String getAreaList = '${baseUrl}lsm-area-list';
  //Get Area List
  static const String getPincodeList = '${baseUrl}lsm-pincode-list';
  // Shop Owner Register
  static const String shopOwnerRegister = '${baseUrl}lsm-shop-owner-register';
  // Shop Owner Register Mobile No
  static const String shopOwnerRegisterMobileNo =
      '${baseUrl}lsm-shop-owner-register-mobile-number';
  // Shop Owner Register Mobile No
  static const String shopOwnerLogin = '${baseUrl}lsm-shop-owner-login';
  // Shop Owner Register Mobile No
  static const String subscriptionPlan =
      '${baseUrl}lsm-shop-owner-get-subscriptions-list';

  /// all Categories list
  // Get Category List
  static const String categorieslist =
      '${baseUrl}lsm-shop-owner-get-category-list';

  ///Shop Owner get Selected Categories List
  static const String shopownerselectedcategorieslist =
      '${baseUrl}lsm-shop-owner-get-selected-categories';
  // Send KYC Verification Data
  static const String kycVerification = '${baseUrl}lsm-shop-owner-kyc-submit';

  ///// shop buy subcription
  static const String shopbuyscription =
      '${baseUrl}lsm-shop-owner-buy-subscription';

  ////Shop Configuration
  static const String getShopConfiguration =
      '${baseUrl}lsm-shop-owner-get-configuration-details';
  ////shop Configuration Edit
  static const String shopconfigurationedit =
      '${baseUrl}lsm-shop-owner-update-configuration-details';
  ////add category
  static const String addCategory = '${baseUrl}lsm-shop-owner-add-category';
  //// shop owner get selected Products
  static const String selectedProducts =
      "${baseUrl}lsm-shop-owner-get-selected-products";

//shop get products list
  static const String getallselectedproductlist =
      '${baseUrl}lsm-shop-owner-products-list';
  ////selected Products
  static const String createCustomProduct =
      '${baseUrl}lsm-shop-owner-create-custom-product';

  ///upload Add Products
  static const String uploadAddProducts =
      '${baseUrl}lsm-shop-owner-add-product-of-category';


  ///Edit Custom Products
  static const String editAdminProducts =
      "${baseUrl}lsm-shop-owner-edit-product-of-category";

  ///Edit Custome Products
  static const String deleteAdminProduct =
      "${baseUrl}lsm-shop-owner-delete-product-of-category";

  ///Dash Board
  static const String ShopDashBoard = "${baseUrl}lsm-shop-owner-dashboard";

///////////////////////////////Customer Screen Apis///////////////////
//OnBoarding Screen
  static const String onBoardingScreen =
      "${baseUrl}lsm-customer-get-splash-screen";

  ////Mobile Number check
  static const String mobileNumberChecks =
      "${baseUrl}lsm-customer-mobile-number-exists";

  ////Customer Sign Up
  static const String customerSignup = "${baseUrl}lsm-customer-signup";
  ////Customer Sign Up
  static const String customerSignIn = "${baseUrl}lsm-customer-login";
//Customer Profile
  static const String customerProfile = "${baseUrl}lsm-customer-profile";
  ////Edit Customer Profile
  static const String editCustomerProfile =
      "${baseUrl}lsm-customer-edit-profile-details";
////Custome Update Profile
  static const String customerUpdateProfile =
      "${baseUrl}lsm-customer-update-profile-details";
  ////Custome Shop As Per Pin Code (All Near Shops) Profile//////////////////////
  static const String allNearShopAsPerPincode =
      "${baseUrl}lsm-customer-shop-list-as-per-pincode";
  ////Custome all Categories(Dash Board)/////////////////////////////////
  static const String categoriesListForDashBoard =
      "${baseUrl}lsm-customer-category-list-for-dashboard";
//////////////////Shop List As Per Category//////////////////
  static const String shopListAsPerCategory =
      "${baseUrl}lsm-customer-shop-list-as-per-category";
  ///////////////////View All Offer Products//////////////////////////////
  static const String AllOfferProducts =
      "${baseUrl}lsm-customer-view-all-offer-products-of-shop";
  ////Customer Add Fvrt Shops
  static const String customerAddFvrtshops =
      "${baseUrl}lsm-customer-add-shop-to-favourite";
  ////Customer Remove Fvrt Shops
  static const String customerRemoveFvrtshops =
      "${baseUrl}lsm-customer-remove-shop-from-favourite";
  ////Customer All Favrt Shops
  static const String customersAllfvrtShopd =
      "${baseUrl}lsm-customer-get-all-favourite-shops";

  ///Remove Fvrt Shops
  static const String removeFrvtShops =
      "${baseUrl}lsm-customer-remove-shop-from-favourite";

  /////
  static const String submitCustomProduct =
      "${baseUrl}lsm-shop-owner-add-custom-product";

//////////Banner
  static const String bannerAds = "${baseUrl}lsm-customer-get-banner-ads";
  //////////Customer view Shop
  static const String customerViewShop = "${baseUrl}lsm-customer-view-shop";
  //////////Customer view All Shop
  static const String customerViewAllShop =
      "${baseUrl}lsm-customer-view-all-shop-list";
  //////////Customer view All Shop
  static const String customerViewAllCategoryShop =
      "${baseUrl}lsm-customer-view-all-shop-list-as-per-category";
  //////////Customer view Shop
  static const String customerProductListAsPerCategory =
      "${baseUrl}lsm-customer-product-list-as-per-category";
  //////////////Seasonal Products
  static const String AllSeasonalProducts =
      "${baseUrl}lsm-customer-view-all-seasonal-products-of-shop";
}
