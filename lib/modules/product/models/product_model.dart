class ProductModel {
  String id;
  String name;
  String avatar;
  bool? approved;

  ProductModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar']
    );
  }

  Map<String,dynamic> toJson(ProductModel product) {
    return {
      'id': product.id,
      'name': product.name,
      'avatar': product.avatar,
    };
  }
}