import 'package:dartz/dartz.dart';
import '../entities/category.dart';
import '../repositories/product_repository.dart';
import '../../core/error/failures.dart';

abstract class GetCategoriesUsecase {
  Future<Either<Failure, List<Category>>> call();
}

class GetCategoriesImpl implements GetCategoriesUsecase {
  final ProductRepository repository;

  GetCategoriesImpl({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}