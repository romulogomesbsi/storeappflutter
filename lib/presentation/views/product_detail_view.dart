import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_detail_controller.dart';
import '../../domain/usecases/get_product_details.dart';
import '../../domain/usecases/add_to_wishlist.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/product_local_data_source.dart';

class ProductDetailView extends StatelessWidget {
  final int productId;
  final bool isFavorite;
  final ProductDetailController controller = Get.put(
    ProductDetailController(
      GetProductDetailsImpl(
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
    ),
  );

  ProductDetailView(
      {super.key, required this.productId, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    controller.fetchProductDetails(productId);
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Produto')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          final product = controller.product.value!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Preço R\$${product.price}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  !isFavorite
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addProductToWishlist(product);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Favoritar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
