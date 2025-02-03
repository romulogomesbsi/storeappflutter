import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_wishlist.dart';
import '../../domain/usecases/remove_from_wishlist.dart';

class WishlistController extends GetxController {
  final GetWishlistUsecase getWishlist;
  final RemoveFromWishlistUsecase removeFromWishlist;

  WishlistController(this.getWishlist, this.removeFromWishlist);

  var wishlist = <Product>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  void fetchWishlist() async {
    isLoading(true);
    final result = await getWishlist();
    result.fold(
      (failure) => errorMessage('Failed to load wishlist'),
      (data) => wishlist(data),
    );
    isLoading(false);
  }

  void removeProductFromWishlist(int id) async {
    final result = await removeFromWishlist(id: id);
    result.fold(
      (failure) => errorMessage('Failed to remove from wishlist'),
      (data) => fetchWishlist(),
    );
  }
}