class ProductTypesModel {
  static dynamic product_types_data;

  void setProductTypes({required dynamic product_types}) {
    try {
      // if (product_types != null) {
        ProductTypesModel.product_types_data = product_types;
      // }
        // ProductTypesModel.product_types_data = 0;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }


  dynamic getProductTypes() {
    try {
      return ProductTypesModel.product_types_data;
    } on Exception catch (e) {
      // return 0;
      Exception("ERROR = ${e}");
    }
  }
}