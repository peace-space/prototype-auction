class ShareProductData {
  static Map<String, dynamic> productData = {};

  // static Map<String, dynamic> productPrivateAuction = {};

  static void setProductData(Map<String, dynamic> data) {
    productData = data;
  }

  static Map<String, dynamic> getProductData() {
    return productData;
  }
}
