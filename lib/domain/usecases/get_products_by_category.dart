import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class GetProductsByCategoryUsecase {
  Future<Either<Failure, List<Product>>> call({required String category});
}

class GetProductsByCategoryImpl implements GetProductsByCategoryUsecase {
  final ProductRepository repository;

  GetProductsByCategoryImpl({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call({required String category}) async {
    return await repository.getProductsByCategory(category);
  }
}