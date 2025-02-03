import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final int categoryId;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });

  @override
  List<Object> get props => [id, title, description, price, image, categoryId];
}