import '../../../helpers/base_model.dart';
import '../../../helpers/base_model_sqlite.dart';

class ProductModel implements BaseModel<ProductModel>, BaseModelSqlite<ProductModel> {
  String id;
  String name;
  String avatar;
  bool? approved;

  ProductModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.approved = false
  });

  ProductModel.empty()
      : id = '',
        name = '',
        avatar = '',
        approved = false;

  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     id: json['id'],
  //     name: json['name'],
  //     avatar: json['avatar']
  //   );
  // }

  // factory ProductModel.fromObject(Map<String, Object?> object) {
  //   return ProductModel(
  //     id: object['id'] as String,
  //     name: object['name'] as String,
  //     avatar: object['avatar'] as String,
  //     approved: (object['approved'] as int) == 1,
  //   );
  // }

  // Map<String,dynamic> toJson(ProductModel product) {
  //   return {
  //     'id': product.id,
  //     'name': product.name,
  //     'avatar': product.avatar,
  //   };
  // }

  // Map<String, Object?> toObject() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'avatar': avatar,
  //     'approved': approved! ? 1 : 0,
  //   };
  // }

  // 🔹 API serialization
  @override
  ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      approved: json['approved'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'approved': approved,
    };
  }

  // 🔹 SQLite serialization
  @override
  ProductModel fromObject(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toString(),
      name: map['name'],
      avatar: map['avatar'],
      approved: map['approved'] == 1,
    );
  }

  @override
  Map<String, dynamic> toObject() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'approved': approved == true ? 1 : 0,
    };
  }
}