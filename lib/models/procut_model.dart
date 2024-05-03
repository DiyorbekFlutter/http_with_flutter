class ProductModel {
  int id;
  String title;
  String description;
  int price;
  num discountPercentage;
  num rating;
  num stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    discountPercentage: json['discountPercentage'] as num,
    rating: json['rating'] as num,
    stock: json['stock'] as num,
    brand: json['brand'] as String,
    category: json['category'] as String,
    thumbnail: json['thumbnail'] as String,
    images: List<String>.from(json['images'].map((e) => e.toString()))
  );

  Map<String, dynamic> toJson(Map<String, dynamic> json) => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": images
  };
}
