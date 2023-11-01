class Endpoint {
  Endpoint._();
  // Get Base Url
  // static const String getBaseUrl = 'https://newcms.m-staging.in/local-super-mart-admin/api/app-base-url';
  // Base Url
  static const String baseUrl =
      // 'https://projects.m-staging.in/local-super-mart/api/';
      // 'https://localsupermart.com/testing/api/';
      'https://localsupermart.com/testing/api/';
  // 'http://lsm.mplussoft.org/api/';
  // 'https://localsupermart.com/live/api/';
  static const String checkMobNoExist =
      '${baseUrl}lsm-shop-owner-mobile-number-exists';
  static const String getCountryList = '${baseUrl}lsm-country-list';
  static const String getStateList = '${baseUrl}lsm-state-list';
  static const String getShopEditProfileDetail =
      '${baseUrl}lsm-shop-owner-get-account-details';
  static const String shopUpdateAccountDetails =
      '${baseUrl}lsm-shop-owner-update-account-details';
  static const String getCityList = '${baseUrl}lsm-city-list';
  static const String getAreaList = '${baseUrl}lsm-area-list';
  static const String getPincodeList = '${baseUrl}lsm-pincode-list';
  static const String shopOwnerRegister = '${baseUrl}lsm-shop-owner-register';
  static const String shopOwnerRegisterMobileNo =
      '${baseUrl}lsm-shop-owner-register-mobile-number';
  static const String shopOwnerLogin = '${baseUrl}lsm-shop-owner-login';
  static const String subscriptionPlan =
      '${baseUrl}lsm-shop-owner-get-subscriptions-list';
  static const String categorieslist =
      '${baseUrl}lsm-shop-owner-get-category-list';
  static const String uploadAdminProduct =
      '${baseUrl}lsm-shop-owner-update-product-of-category';
  static const String updateEditCustomProduct =
      '${baseUrl}lsm-shop-owner-update-custom-product';
  static const String shopownerselectedcategorieslist =
      '${baseUrl}lsm-shop-owner-get-selected-categories';
  static const String uploadKycVerification =
      '${baseUrl}lsm-shop-owner-kyc-submit';
  static const String shopbuyscription =
      '${baseUrl}lsm-shop-owner-buy-subscription';
  static const String getShopConfiguration =
      '${baseUrl}lsm-shop-owner-get-configuration-details';
  static const String shopconfigurationedit =
      '${baseUrl}lsm-shop-owner-update-configuration-details';
  static const String addCategory = '${baseUrl}lsm-shop-owner-add-category';
  static const String selectedProducts =
      "${baseUrl}lsm-shop-owner-get-selected-products";
  static const String getallselectedproductlist =
      '${baseUrl}lsm-shop-owner-products-list';
  static const String createCustomProduct =
      '${baseUrl}lsm-shop-owner-create-custom-product';
  static const String uploadAddProducts =
      '${baseUrl}lsm-shop-owner-add-product-of-category';
  static const String editAdminProducts =
      "${baseUrl}lsm-shop-owner-edit-product-of-category";
  static const String deleteAdminProduct =
      "${baseUrl}lsm-shop-owner-delete-product-of-category";
  static const String deleteCustomeProduct =
      "${baseUrl}lsm-shop-owner-delete-custom-product";
  static const String ShopDashBoard = "${baseUrl}lsm-shop-owner-dashboard";
  static const String editCustomProduct =
      "${baseUrl}lsm-shop-owner-edit-custom-product";
  static const String onBoardingScreen =
      "${baseUrl}lsm-customer-get-splash-screen";
  static const String mobileNumberChecks =
      "${baseUrl}lsm-customer-mobile-number-exists";
  static const String customerSignup = "${baseUrl}lsm-customer-signup";
  static const String customerSignIn = "${baseUrl}lsm-customer-login";
  static const String customerGuestLogin = "${baseUrl}lsm-guest-login";
  static const String customerProfile = "${baseUrl}lsm-customer-profile";
  static const String editCustomerProfile =
      "${baseUrl}lsm-customer-edit-profile-details";
  static const String customerUpdateProfile =
      "${baseUrl}lsm-customer-update-profile-details";
  static const String allNearShopAsPerPincode =
      "${baseUrl}lsm-customer-shop-list-as-per-pincode";
  static const String categoriesListForDashBoard =
      "${baseUrl}lsm-customer-category-list-for-dashboard";
  static const String shopListAsPerCategory =
      "${baseUrl}lsm-customer-shop-list-as-per-category";
  static const String AllOfferProducts =
      "${baseUrl}lsm-customer-view-all-offer-products-of-shop";
  static const String customerAddFvrtshops =
      "${baseUrl}lsm-customer-add-shop-to-favourite";
  static const String customerRemoveFvrtshops =
      "${baseUrl}lsm-customer-remove-shop-from-favourite";
  static const String customersAllfvrtShopd =
      "${baseUrl}lsm-customer-get-all-favourite-shops";
  static const String removeFrvtShops =
      "${baseUrl}lsm-customer-remove-shop-from-favourite";
  static const String customerCreateTicket =
      "${baseUrl}lsm-customer-create-ticket";
  static const String submitCustomProduct =
      "${baseUrl}lsm-shop-owner-add-custom-product";
  static const String bannerAds = "${baseUrl}lsm-customer-get-banner-ads";
  static const String customerViewShop = "${baseUrl}lsm-customer-view-shop";
  static const String customerViewAllShop =
      "${baseUrl}lsm-customer-view-all-shop-list";
  static const String customerViewAllCategoryShop =
      "${baseUrl}lsm-customer-shop-list-as-per-category";
  static const String customerProductListAsPerCategory =
      "${baseUrl}lsm-customer-product-list-as-per-category";
  static const String customerProductListAsPerSearch =
      "${baseUrl}lsm-customer-search-product-in-shop-as-per-category";
  static const String customerProductListAsPerFilter =
      "${baseUrl}lsm-customer-product-list-as-per-category-and-filter";
  static const String addAdminProductToFav =
      "${baseUrl}lsm-customer-add-admin-product-to-favourite";
  static const String addCustomProductToFav =
      "${baseUrl}lsm-customer-add-custom-product-to-favourite";
  static const String AllSeasonalProducts =
      "${baseUrl}lsm-customer-view-all-seasonal-products-of-shop";
  static const String AllRecommandedProducts =
      "${baseUrl}lsm-customer-view-all-recommendation-products-of-shop";
  static const String ProductView =
      "${baseUrl}lsm-customer-shop-category-product-view";
  static const String ProductUnitImage =
      "${baseUrl}lsm-customer-get-unit-images-of-product";
  static const String removeAdminProduct =
      "${baseUrl}lsm-customer-remove-admin-product-from-favourite";
  static const String removeCustomProduct =
      "${baseUrl}lsm-customer-remove-custom-product-from-favourite";
  static const String allFavProduct =
      "${baseUrl}lsm-customer-favourite-product-list";
  static const String customerList = "${baseUrl}lsm-shop-owner-customer-list";
  static const String customerFavList =
      "${baseUrl}lsm-shop-owner-customer-list-who-liked-shops";
  static const String shopCustomerDetailView =
      "${baseUrl}lsm-shop-owner-customer-view";
  static const String deliveryAddress =
      "${baseUrl}lsm-customer-delivery-address-list";
  static const String addDeliveryAddressList =
      "${baseUrl}lsm-customer-add-delivery-address";
  static const String markDefaultaddress =
      "${baseUrl}lsm-customer-make-delivery-address-default";
  static const String deleteDeliveryAddress =
      "${baseUrl}lsm-customer-delete-delivery-address";
  static const String editDeliveryAddress =
      "${baseUrl}lsm-customer-edit-delivery-address";
  static const String UpdateDeliveryAddress =
      "${baseUrl}lsm-customer-update-delivery-address";
  static const String shopOwnerCouponsForProductlist =
      "${baseUrl}lsm-shop-owner-products-list-for-coupon";
  static const String allCouponsList = "${baseUrl}lsm-shop-owner-coupon-list";
  static const String couponCodeExists =
      "${baseUrl}lsm-shop-owner-check-if-coupon-code-exists";
  static const String addNewCoupons = "${baseUrl}lsm-shop-owner-add-coupon";
  static const String couponViewDetail =
      "${baseUrl}lsm-shop-owner-coupon-details-view";
  static const String productListAsCategory =
      "${baseUrl}sm-shop-owner-products-list-for-coupon";
  static const String couponsDelete = "${baseUrl}lsm-shop-owner-delete-coupon";
  static const String CouponsUpdate = "${baseUrl}lsm-shop-owner-update-coupon";
  static const String editCoupon = "${baseUrl}lsm-shop-owner-edit-coupon";
  static const String cartList = "${baseUrl}lsm-customer-get-cart-list";
  static const String cartDetailView =
      "${baseUrl}lsm-customer-view-cart-details";
  static const String addProductToCart =
      "${baseUrl}lsm-customer-add-product-to-cart";
  static const String cartDetailDelete = "${baseUrl}lsm-customer-delete-cart";
  static const String cartItemQuantity =
      "${baseUrl}lsm-customer-update-cart-item-quantity";
  static const String shopCartDelete =
      "${baseUrl}lsm-customer-delete-all-carts";
  static const String customerOrderSummery =
      "${baseUrl}lsm-customer-order-summary-screen";
  static const String applyCoupons = "${baseUrl}lsm-customer-apply-coupon";
  static const String removeCoupons = "${baseUrl}lsm-customer-remove-coupon";
  static const String orderPayment =
      "${baseUrl}lsm-customer-order-payment-screen";
  static const String placeOrder = "${baseUrl}lsm-customer-place-order";
  static const String myOrders =
      "${baseUrl}lsm-customer-order-list-with-filter";
  static const String setPincode =
      "${baseUrl}lsm-customer-current-location-pincode";
  static const String shopGetOrderList =
      "${baseUrl}lsm-shop-owner-get-orders-list";
  static const String shopOwneROrderView =
      "${baseUrl}lsm-shop-owner-order-view";
  static const String shopOwnerRefundUpdate =
      "${baseUrl}lsm-shop-owner-update-refund-status";
  static const String shopOwnerDeliveredRefundUpdate =
      "${baseUrl}lsm-shop-owner-deliverd-order-refund-submit";
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
  static const String customerShopSetting =
      "${baseUrl}lsm-customer-get-settings";
  static const String customerChangeSetting =
      "${baseUrl}lsm-customer-change-settings";
  static const String getCustomerNotificationList =
      "${baseUrl}lsm-customer-get-notifications-list";
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
  static const String updateRefundStatus =
      "${baseUrl}customer-update-refund-payment-status";
  static const String updateDeliveredRefundStatus =
      "${baseUrl}customer-update-deliverd-refund-payment-status";
  static const String customerTicketList = "${baseUrl}lsm-customer-get-tickets";
  static const String customerViewticket = "${baseUrl}lsm-customer-view-ticket";
  static const String customerViewticketReply =
      "${baseUrl}lsm-customer-ticket-reply";
  static const String clogOut = "${baseUrl}lsm-customer-logout";
  static const String cdeleteAccount = "${baseUrl}lsm-customer-delete-account";
  static const String cdReviewlist = "${baseUrl}lsm-review-list";
  static const String customerAds =
      "${baseUrl}lsm-customer-request-shop-promotion";
  static const String returnList = "${baseUrl}lsm-customer-order-return-list";
  static const String checkReturnProduct =
      "${baseUrl}customer_order_refund_submit";
  static const String customerAllCouponList =
      "${baseUrl}lsm-customer-coupons-list";
  static const String customerPlaceAd = "${baseUrl}lsm-shop-owner-banner";
  static const String submitReturn = "${baseUrl}customer_order_refund_submit";
  static const String searchShop = "${baseUrl}lsm-shop-owner-filter-list";
  static const String shopNotificationDelete =
      "${baseUrl}lsm-shop-owner-notifications-delete";
  static const String customerNotificationDelete =
      "${baseUrl}lsm-customer-notifications-delete";
  static const String sProfileCoupons = "${baseUrl}lsm-shop-owner-coupons";
  static const String customerFaqData = "${baseUrl}lsm-customer-feq-get";
  static const String subScreiptionInvoice = "${baseUrl}lsm-shop-owner-invoice";
  static const String orderInvoice = "${baseUrl}lsm-customer-invoice";
  static const String removeCartItem = "${baseUrl}lsm-customer-remove-cart";
  static const String shopReviewList =
      "${baseUrl}lsm-shop-owner-review-list-for-shop";
  static const String shopDeliveryArealist =
      "${baseUrl}lsm-shop-owner-get-area-list";
  static const String couponFiltter =
      "${baseUrl}lsm-shop-owner-category-and-shop-list";
  static const String paymentRefundList =
      "${baseUrl}lsm-shop-owner-refund-list";
  static const String getShopAreaList =
      "${baseUrl}get-area-list-for-shop-filter";
  static const String getFullFillCravingList =
      "${baseUrl}lsm-customer-get-fullfill-cravings-product-list";
  static const String notificationSeenRepo =
      "${baseUrl}lsm-notification-status";
  static const String referAndEarn = "${baseUrl}lsm-display-referral-code";
  static const String applyReferCode = "${baseUrl}lsm-apply-referral-code";
  static const String myVouchers = "${baseUrl}lsm-get-customer-vouchers";
  static const String bannerNavigation =
      "${baseUrl}lsm-customer-banner-product-view";
}
