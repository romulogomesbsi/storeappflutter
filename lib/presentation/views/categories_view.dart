import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeappflutter/presentation/views/wishlist_view.dart';
import '../controllers/categories_controller.dart';
import '../../domain/usecases/get_categories.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/product_local_data_source.dart';
import 'products_view.dart';

class CategoriesView extends StatelessWidget {
  final CategoriesController controller = Get.put(
    CategoriesController(
      GetCategoriesImpl(
        repository: ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSourceImpl(),
          localDataSource: ProductLocalDataSourceImpl(),
        ),
      ),
    ),
  );

  CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Get.to(() => WishlistView()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  onTap: () {
                    Get.to(() => ProductsView(category: category.name));
                  },
                  title: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.purple,
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
