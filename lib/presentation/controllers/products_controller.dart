import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_to_wishlist.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/get_wishlist.dart';
import '../../domain/usecases/remove_from_wishlist.dart';

class ProductsController extends GetxController {
  final GetProductsByCategoryUsecase getProductsByCategory;
  final GetWishlistUsecase getWishlist;
  final AddToWishlistUsecase addToWishlist;
  final RemoveFromWishlistUsecase removeFromWishlist;

  ProductsController(this.getProductsByCategory, this.getWishlist,
      this.addToWishlist, this.removeFromWishlist);

  var products = <Product>[].obs;
  var wishlist = <Product>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void fetchProducts(String category) async {
    isLoading(true);
    final result = await getProductsByCategory(category: category);
    result.fold(
      (failure) => errorMessage('Falha ao carregar produtos'),
      (data) => products(data),
    );
    fetchWishlist();
    isLoading(false);
  }

  void fetchWishlist() async {
    try {
      final result = await getWishlist();
      result.fold(
        (failure) => errorMessage('Falha ao carregar lista de desejos'),
        (data) => wishlist(data),
      );
    } catch (e) {}
  }
}
