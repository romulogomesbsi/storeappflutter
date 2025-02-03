import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class AddToWishlistUsecase {
  Future<Either<Failure, void>> call({required Product product});
}

class AddToWishlistImpl implements AddToWishlistUsecase {
  final ProductRepository repository;

  AddToWishlistImpl({required this.repository});

  @override
  Future<Either<Failure, void>> call({required Product product}) async {
    return await repository.addToWishlist(product);
  }
}