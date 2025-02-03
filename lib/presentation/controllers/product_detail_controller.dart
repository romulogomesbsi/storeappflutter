import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_details.dart';
import '../../domain/usecases/add_to_wishlist.dart';

class ProductDetailController extends GetxController {
  final GetProductDetailsUsecase getProductDetails;
  final AddToWishlistUsecase addToWishlist;

  ProductDetailController(this.getProductDetails, this.addToWishlist);

  var product = Rxn<Product>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void fetchProductDetails(int id) async {
    isLoading(true);
    final result = await getProductDetails(id: id);
    result.fold(
      (failure) => errorMessage('Erro ao carregar detalhes do produto'),
      (data) => product(data),
    );
    isLoading(false);
  }

  void addProductToWishlist(Product product) async {
    final result = await addToWishlist(product: product);
    result.fold(
      (failure) => errorMessage('Error ao adicionar produto à lista de desejos'),
      (data) => Get.snackbar('Sucesso', 'Produto adicionado à lista de desejos'),
    );
  }
}