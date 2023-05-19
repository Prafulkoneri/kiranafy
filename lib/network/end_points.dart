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
  static const String ShopUpdateAccountDetails =
      '${baseUrl}lsm-shop-owner-update-account-details';
//Shop city List
  static const String getCityList = '${baseUrl}lsm-city-list';
  //Get Area List
  static const String getAreaList = '${baseUrl}lsm-area-list';
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
  static const String shopconfiguration =
      '${baseUrl}lsm-shop-owner-get-configuration-details';
  ////shop Configuration Edit
  static const String shopconfigurationedit =
      '${baseUrl}lsm-shop-owner-update-configuration-details';
  ////add category
  static const String addCategory = '${baseUrl}lsm-shop-owner-add-category';
  ////selected Products
  static const String selectedProducts =
      '${baseUrl}lsm-shop-owner-products-list';
  ////selected Products
  static const String createCustomProduct =
      '${baseUrl}lsm-shop-owner-create-custom-product';
}
