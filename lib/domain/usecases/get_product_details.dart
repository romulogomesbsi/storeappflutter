import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class GetProductDetailsUsecase {
  Future<Either<Failure, Product>> call({required int id});
}

class GetProductDetailsImpl implements GetProductDetailsUsecase {
  final ProductRepository repository;

  GetProductDetailsImpl({required this.repository});

  @override
  Future<Either<Failure, Product>> call({required int id}) async {
    return await repository.getProductDetails(id);
  }
}