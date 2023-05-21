
class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel>_products;
  List<ProductModel> get products=>_products;

  Product({required totalSize, required typeId, required offset, required products})
  {
   this._totalSize = totalSize;
   this._typeId = typeId ;
   this._offset = offset;
   this._products = products;
}

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(new ProductModel.fromJson(v));
      });
    }
  }

}
class ProductModel {
  late int id;
  late String name;
  late String description;
  late int price;
  late int stars;
  late String img;
  late String location;
  late String createdAt;
  late String updatedAt;
  late int typeId;
  int quantity = 0; // Initialize quantity with 0

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.img,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.typeId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    quantity = 0; // Initialize quantity with 0
  }
}
