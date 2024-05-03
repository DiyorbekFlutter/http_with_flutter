import 'package:http_with_flutter/models/procut_model.dart';

class AllProductsModel {
  List<ProductModel> products;
  int total;
  int skip;
  int limit;

  AllProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
    products: List<ProductModel>.from(json['products'].map((e) => ProductModel.fromJson(e))),
    total: json['total'] as int,
    skip: json['skip'] as int,
    limit: json['limit'] as int,
  );
}