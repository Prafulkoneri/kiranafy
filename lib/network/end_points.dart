import 'package:provider/provider.dart';

class Endpoint {
  Endpoint._();
  // Get Base Url
  // static const String getBaseUrl = 'https://newcms.m-staging.in/local-super-mart-admin/api/app-base-url';
  // Base Url
  static const String baseUrl =
      // 'https://projects.m-staging.in/local-super-mart/api/';
      'https://localsupermart.com/testing/api/';
  // 'https://localsupermart.com/live/api/';
  // Check Mobile Number Exist
  static const String checkMobNoExist =
      '${baseUrl}lsm-shop-owner-mobile-number-exists';
  // Get Country
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

  // Upload Admin Product
  static const String uploadAdminProduct =
      '${baseUrl}lsm-shop-owner-update-product-of-category';

  // Upload Custom Product
  static const String uploadCustomProduct =
      '${baseUrl}lsm-shop-owner-update-custom-product';

  ///Shop Owner get Selected Categories List
  static const String shopownerselectedcategorieslist =
      '${baseUrl}lsm-shop-owner-get-selected-categories';
  // Send KYC Verification Data
  static const String uploadKycVerification =
      '${baseUrl}lsm-shop-owner-kyc-submit';

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
  //Edit Custome Products
  static const String deleteCustomeProduct =
      "${baseUrl}lsm-shop-owner-delete-custom-product";

  ///Dash Board
  static const String ShopDashBoard = "${baseUrl}lsm-shop-owner-dashboard";

  ///Edit Custom Product
  static const String editCustomProduct =
      "${baseUrl}lsm-shop-owner-edit-custom-product";

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

  ///Remove Fvrt Shops
  static const String customerCreateTicket =
      "${baseUrl}lsm-customer-create-ticket";

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
  //////////Customer view All Shop////////////////////////////////////////////////////////////////////////
  static const String customerViewAllCategoryShop =
      "${baseUrl}lsm-customer-shop-list-as-per-category";
  //////////Customer view Shop
  static const String customerProductListAsPerCategory =
      "${baseUrl}lsm-customer-product-list-as-per-category";
  //////////Customer Product List As Per Search
  static const String customerProductListAsPerSearch =
      "${baseUrl}lsm-customer-search-product-in-shop-as-per-category";
  //////////Customer Product List As Per Filter
  static const String customerProductListAsPerFilter =
      "${baseUrl}lsm-customer-product-list-as-per-category-and-filter";
  //////////Customer Add Admin Product To Fav
  static const String addAdminProductToFav =
      "${baseUrl}lsm-customer-add-admin-product-to-favourite";
  //////////Customer Add Custom Product To Fav
  static const String addCustomProductToFav =
      "${baseUrl}sm-customer-add-custom-product-to-favourite";
  //////////////Seasonal Products
  static const String AllSeasonalProducts =
      "${baseUrl}lsm-customer-view-all-seasonal-products-of-shop";
  //////////////recommandation
  static const String AllRecommandedProducts =
      "${baseUrl}lsm-customer-view-all-recommendation-products-of-shop";

  //////////////////Products View/////////////////////////
  static const String ProductView =
      "${baseUrl}lsm-customer-shop-category-product-view";
  //////////////Product Unit Image
  static const String ProductUnitImage =
      "${baseUrl}lsm-customer-get-unit-images-of-product";
  /////////////Remove Admin Product Fvrt///////
  static const String removeAdminProduct =
      "${baseUrl}lsm-customer-remove-admin-product-from-favourite";

////////////////////Remove Custome Product////
  static const String removeCustomProduct =
      "${baseUrl}lsm-customer-remove-custom-product-from-favourite";

  /////////All Fav Products///////
  static const String allFavProduct =
      "${baseUrl}lsm-customer-favourite-product-list";
  ///////////////Customer List///
  static const String customerList = "${baseUrl}lsm-shop-owner-customer-list";
  ///////////////Customer Fav List///
  static const String customerFavList =
      "${baseUrl}lsm-shop-owner-customer-list-who-liked-shops";
  ////////Shop Customer Detail View////
  static const String shopCustomerDetailView =
      "${baseUrl}lsm-shop-owner-customer-view";

  ////////Deliver Address List ////
  static const String deliveryAddress =
      "${baseUrl}lsm-customer-delivery-address-list";
  ////////Add Deliver Address  ////
  static const String addDeliveryAddressList =
      "${baseUrl}lsm-customer-add-delivery-address";
  ////////Mark Default Address  ////
  static const String markDefaultaddress =
      "${baseUrl}lsm-customer-make-delivery-address-default";

  ////////Delete Delivery Address  ////
  static const String deleteDeliveryAddress =
      "${baseUrl}lsm-customer-delete-delivery-address";
  ////////Delete Delivery Address  ////
  static const String editDeliveryAddress =
      "${baseUrl}lsm-customer-edit-delivery-address";

  ////////Update Delivery Address  ////
  static const String UpdateDeliveryAddress =
      "${baseUrl}lsm-customer-update-delivery-address";
  ////////Shop Owner Coupons for product and category////
  static const String shopOwnerCouponsForProductlist =
      "${baseUrl}lsm-shop-owner-products-list-for-coupon";
  ////////Shop Owner Coupons for product and category////
  static const String allCouponsList = "${baseUrl}lsm-shop-owner-coupon-list";

////////Coupon Code Exists////
  static const String couponCodeExists =
      "${baseUrl}lsm-shop-owner-check-if-coupon-code-exists";
  ///////ADD NEW COUPONS////
  static const String addNewCoupons = "${baseUrl}lsm-shop-owner-add-coupon";
  ///////Coupon Detail View////
  static const String couponViewDetail =
      "${baseUrl}lsm-shop-owner-coupon-details-view";
  ///////ADD NEW COUPONS////
  static const String productListAsCategory =
      "${baseUrl}sm-shop-owner-products-list-for-coupon";
  ///////ADD NEW COUPONS////
  static const String couponsDelete = "${baseUrl}lsm-shop-owner-delete-coupon";
  //////ADD NEW COUPONS////
  static const String CouponsUpdate = "${baseUrl}lsm-shop-owner-update-coupon";
/////Edit Coupons////
  static const String editCoupon = "${baseUrl}lsm-shop-owner-edit-coupon";
  /////Cart List////
  static const String cartList = "${baseUrl}lsm-customer-get-cart-list";
  ////Cart Details////
  static const String cartDetailView =
      "${baseUrl}lsm-customer-view-cart-details";
  ////Add Product To Cart////
  static const String addProductToCart =
      "${baseUrl}lsm-customer-add-product-to-cart";

  ///Cart List Detail Delete////
  static const String cartDetailDelete = "${baseUrl}lsm-customer-delete-cart";

  ///Cart Item Quantity////
  static const String cartItemQuantity =
      "${baseUrl}lsm-customer-update-cart-item-quantity";

  ///Shop Cart Delete ////
  static const String shopCartDelete =
      "${baseUrl}lsm-customer-delete-all-carts";

  ///Customer Order Summery////
  static const String customerOrderSummery =
      "${baseUrl}lsm-customer-order-summary-screen";

  ///Customer aplly coupons////
  static const String applyCoupons = "${baseUrl}lsm-customer-apply-coupon";

  ///Customer remove coupons////
  static const String removeCoupons = "${baseUrl}lsm-customer-remove-coupon";
  //Order PAyment////
  static const String orderPayment =
      "${baseUrl}lsm-customer-order-payment-screen";
  //Order Place////
  static const String placeOrder = "${baseUrl}lsm-customer-place-order";

  static const String myOrders =
      "${baseUrl}lsm-customer-order-list-with-filter";
  static const String setPincode =
      "${baseUrl}lsm-customer-current-location-pincode";

  static const String shopGetOrderList =
      "${baseUrl}lsm-shop-owner-get-orders-list";

  static const String shopOwneROrderView =
      "${baseUrl}lsm-shop-owner-order-view";

  static const String shopOwnerOrderStatusChange =
      "${baseUrl}lsm-shop-owner-change-order-delivery-status";

  static const String shopOwnerAddRemoveProduct =
      "${baseUrl}lsm-shop-owner-remove-product-from-order";

  static const String currentLocationPincode =
      "${baseUrl}lsm-customer-current-location-pincode";

  static const String cancelOrderReason =
      "${baseUrl}lsm-shop-owner-get-order-cancel-reasons";

  static const String customerOrderView = "${baseUrl}lsm-customer-order-view";

  static const String trackOrder = "${baseUrl}lsm-customer-track-order";

  static const String cmsFile = "${baseUrl}lsm-cms-data";

  static const String shopSetting = "${baseUrl}lsm-shop-owner-get-settings";

  static const String pramotionRequest =
      "${baseUrl}lsm-shop-owner-request-shop-promotion";

  static const String paymentHistory =
      "${baseUrl}lsm-shop-owner-orders-payment-history";

  static const String changeSetting =
      "${baseUrl}lsm-shop-owner-change-settings";

  static const String shopSignOut = "${baseUrl}lsm-shop-owner-logout";

  static const String shopDelete = "${baseUrl}lsm-shop-owner-delete-account";

  static const String ticketList = "${baseUrl}lsm-shop-owner-get-tickets";

  static const String viewTicket = "${baseUrl}lsm-shop-owner-view-ticket";

  static const String ticketReply = "${baseUrl}lsm-shop-owner-ticket-reply";

  static const String ticketType = "${baseUrl}lsm-shop-owner-get-ticket-types";

  static const String createTicket = "${baseUrl}lsm-shop-owner-create-ticket";

  static const String getBankAccount =
      "${baseUrl}lsm-shop-owner-get-bank-details";

  static const String updateBankDetail =
      "${baseUrl}lsm-shop-owner-add-update-bank-details";

  static const String sRFProductsList =
      "${baseUrl}lsm-shop-owner-get-recommended-seasonal-and-fullfill-your-cravings-products";

  static const String removeSRFProducts =
      "${baseUrl}lsm-shop-owner-remove-product-from-special-category";

  static const String searchProduct =
      "${baseUrl}lsm-shop-owner-selected-product-search";

  static const String subscriptionHistory =
      "${baseUrl}lsm-shop-owner-subscription-history";

  static const String faqData = "${baseUrl}lsm-shop-owner-get-faqs";

  static const String unitListToCreateProduct =
      "${baseUrl}lsm-shop-owner-units-list";

  static const String editUnitProductCategory =
      "${baseUrl}lsm-shop-owner-edit-product-units-of-category";

  static const String deleteUnitProductCategory =
      "${baseUrl}lsm-shop-owner-delete-product-units-of-category";

  static const String addUpadteUnitProductCategory =
      "${baseUrl}lsm-shop-owner-update-product-units-of-category";

  static const String getProductUnitList =
      "${baseUrl}lsm-shop-owner-get-product-unit-list";

  static const String getCustomerCancelOrder =
      "${baseUrl}lsm-customer-get-cancel-order-reasons";

  static const String customerCancelOrder =
      "${baseUrl}lsm-customer-cancel-order";

  static const String shopNotificationList =
      "${baseUrl}lsm-shop-owner-get-notifications-list";
  static const String checkAppversion = "${baseUrl}lsm-app-version";

  static const String reOrder = "${baseUrl}lsm-customer-reorder";
  static const String reviewshoplist =
      "${baseUrl}lsm-customer-review-list-of-shop";
  static const String submitRevieqw =
      "${baseUrl}lsm-customer-submit-review-for-shop";

  static const String customerTicketList = "${baseUrl}lsm-customer-get-tickets";

  static const String customerViewticket = "${baseUrl}lsm-customer-view-ticket";
  static const String customerViewticketReply =
      "${baseUrl}lsm-customer-ticket-reply";
  static const String clogOut = "${baseUrl}lsm-customer-logout";
  static const String cdeleteAccount = "${baseUrl}lsm-customer-delete-account";
}
