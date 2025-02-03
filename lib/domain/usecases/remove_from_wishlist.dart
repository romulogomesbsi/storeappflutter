import 'package:dartz/dartz.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class RemoveFromWishlistUsecase {
  Future<Either<Failure, void>> call({required int id});
}

class RemoveFromWishlistImpl implements RemoveFromWishlistUsecase {
  final ProductRepository repository;

  RemoveFromWishlistImpl({required this.repository});

  @override
  Future<Either<Failure, void>> call({required int id}) async {
    return await repository.removeFromWishlist(id);
  }
}