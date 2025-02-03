import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/add_to_wishlist.dart';
import '../../domain/usecases/remove_from_wishlist.dart';
import '../controllers/products_controller.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/get_wishlist.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/product_local_data_source.dart';
import '../widgets/product_item.dart';
import 'product_detail_view.dart';

class ProductsView extends StatelessWidget {
  final String category;
  final ProductsController controller = Get.put(
    ProductsController(
      GetProductsByCategoryImpl(
        repository: ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(),
          localDataSource: ProductLocalDataSourceImpl(),
        ),
      ),
      GetWishlistImpl(
        repository: ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(),
          localDataSource: ProductLocalDataSourceImpl(),
        ),
      ),
      AddToWishlistImpl(
        repository: ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(),
          localDataSource: ProductLocalDataSourceImpl(),
        ),
      ),
      RemoveFromWishlistImpl(
        repository: ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(),
          localDataSource: ProductLocalDataSourceImpl(),
        ),
      ),
    ),
  );

  ProductsView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    controller.fetchProducts(category);
    return Scaffold(
      appBar: AppBar(title: Text('Produtos')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              final isInWishlist =
                  controller.wishlist.any((item) => item.id == product.id);
              return ProductItem(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailView(
                        productId: product.id,
                        isFavorite: isInWishlist,
                      ),
                    ),
                  );
                  controller.fetchProducts(category);
                },
                product: product,
                isInWishlist: isInWishlist,
                onWishlistToggle: () {
                  if (isInWishlist) {
                    controller.removeFromWishlist(id: product.id);
                  } else {
                    controller.addToWishlist(product: product);
                  }
                  controller.fetchProducts(category);
                },
              );
            },
          );
        }
      }),
    );
  }
}
