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
  //Shop Owner categories list
  static const String categorieslist =
      '${baseUrl}lsm-shop-owner-get-category-list';
}
