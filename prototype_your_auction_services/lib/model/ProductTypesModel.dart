class ProductTypesModel {
  static dynamic product_types_data;

  void setProductTypes({required dynamic product_types}) {
    try {
      ProductTypesModel.product_types_data = product_types;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }


  dynamic getProductTypes() {
    try {
      return ProductTypesModel.product_types_data;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }
}