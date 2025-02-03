import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class GetWishlistUsecase {
  Future<Either<Failure, List<Product>>> call();
}

class GetWishlistImpl implements GetWishlistUsecase {
  final ProductRepository repository;

  GetWishlistImpl({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getWishlist();
  }
}