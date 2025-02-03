import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wishlist_controller.dart';
import '../../domain/usecases/get_wishlist.dart';
import '../../domain/usecases/remove_from_wishlist.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/product_local_data_source.dart';

// ignore: use_key_in_widget_constructors
class WishlistView extends StatelessWidget {
  final WishlistController controller = Get.put(
    WishlistController(
      GetWishlistImpl(
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

  @override
  Widget build(BuildContext context) {
    controller.fetchWishlist();
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.wishlist.length,
            itemBuilder: (context, index) {
              final product = controller.wishlist[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: product.image != null
                        ? Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                          )
                        : Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                  title: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '\$${product.price}',
                    style: TextStyle(color: Colors.green[800]),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.removeProductFromWishlist(product.id);
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
