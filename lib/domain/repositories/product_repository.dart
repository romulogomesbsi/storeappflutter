import 'package:dartz/dartz.dart';
import '../entities/category.dart';
import '../entities/product.dart';
import '../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
  Future<Either<Failure, Product>> getProductDetails(int id);
  Future<Either<Failure, List<Product>>> getWishlist();
  Future<Either<Failure, void>> addToWishlist(Product product);
  Future<Either<Failure, void>> removeFromWishlist(int id);
}