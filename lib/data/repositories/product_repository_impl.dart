import 'package:dartz/dartz.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../datasources/product_local_data_source.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final remoteCategories = await remoteDataSource.fetchCategories();
      return Right(remoteCategories);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category) async {
    try {
      final remoteProducts = await remoteDataSource.fetchProductsByCategory(category);
      return Right(remoteProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(int id) async {
    try {
      final remoteProduct = await remoteDataSource.fetchProductDetails(id);
      return Right(remoteProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getWishlist() async {
    try {
      final localWishlist = await localDataSource.getWishlist();
      return Right(localWishlist);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addToWishlist(Product product) async {
    try {
      await localDataSource.cacheProduct(ProductModel.fromEntity(product));
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(int id) async {
    try {
      await localDataSource.removeProductFromWishlist(id);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}