class APIString {
  APIString._();

  // Base URL
  static const String baseURL = "http://utcit.in/wena/";

  // Login SignUp
  static const String vendorLoginUrl = "api/vendor/vendorLogin";
  static const String vendorSignupUrl = "api/vendor/vendorSignup";
  static const String vendorListUrl = "api/vendor/getAllVendors";
  static const String cityListUrl = "api/vendor/getCityDataByUganda";
  static const String sendOtpUrl = "api/vendor/sendOTP";
  static const String verifyOtpUrl = "api/vendor/verifyOTP";
  static const String addBranchUrl = "api/vendor/add_branch";
  static const String getProductUrl = "api/vendor/getAllBranchByVendorId";
  static const String deleteBranchUrl = "api/vendor/deleteBrnachById";
  static const String branchDetailUrl = "api/vendor/getBranchById";
  static const String updateBranchUrl = "api/vendor/update_branch";
  static const String branchStatusUrl = "api/vendor/activeInactiveByBranchId";
  static const String getAllSubscriptionUrl = "api/vendor/getAllSubscription";
  static const String dashboardProudctUrl = "api/dashboard/productList";
  static const String hotProudctUrl = "api/dashboard/getHotProducts";
  static const String logoutUlr = "api/vendor/vendorLogout";
  static const String cancelSubscriptionUrl =
      "api/vendor/cancelSubscriptionByVendorId";
  static const String updateProfileUrl = "api/vendor/updateVendorProfile";
  static const String vendorProfileUrl =
      "api/vendor/getVendorDetailsByVendorId";
  static const String dashboardAnalyticsUrl =
      "api/dashboard/dashboardAnalyticsByVendorId";
  static const String getAllSubscriptionDetailsUrl =
      "api/vendor/getSubscriptionById";
  static const String planSubscribeUrl = "api/vendor/subscribePlanById";
  static const String userSubPlanUrl = "api/vendor/getCurrentPlanByVendorId";
  static const orderListUrl = "api/order/getOrders";
  // Product
  static const String vendorPostProductUrl =
      "api/vendor/searchProductsByKeyword";
  static const String vendorPostChooseImageProductUrl =
      "api/product/getProductImagesByFilter";
  static const String vendorPostAddProductUrl = "api/product/add_product";
  static const String vendorPostDeleteProductUrl =
      "api/product/deleteProductById";
  static const String vendorPostSearchProductByDateRangeUrl =
      "api/vendor/searchProductsByDateRange";
  static const String vendorPostEditProductUrl = "api/product/update_product";

  // Get Categories / Units / Colors
  static const String vendorGetProductCategoriesUrl =
      "api/product/getProductCategories";
  static const String vendorGetProductUnitsUrl = "api/product/getProductUnits";
  static const String vendorGetProductColorsUrl = "api/product/getColors";
  static const String productDetailsUrl = "api/product/getProductById";
  static const String completedTransctionUrl =
      "api/vendor/getCompletedByVendorId";

  static const String earningUrl = "api/vendor/getEarningByVendorId";
  static const String pendingTransactionUrl = "api/vendor/getPendingByVendorId";
  static const String productKeywordUrl = "api/vendor/getProductByKeyword";
  static const String orderDetailsUrl = "api/order/getOrderDetail";
  static const String walletAmountUrl =
      "api/vendor/getUnprocessAmountByVendorId";
  static const String withdorwAmountUrl =
      "api/vendor/getUnprocessAmountByVendorId";
}
