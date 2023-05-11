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
  static const String getCityList = '${baseUrl}lsm-state-list';
  // shop Edit Profile
  static const String getShopEditProfileDetail =
      '${baseUrl}lsm-shop-owner-get-account-details';
  ////Shop Update Profile
  static const String ShopUpdateAccountDetails =
      '${baseUrl}lsm-shop-owner-update-account-details';
}
