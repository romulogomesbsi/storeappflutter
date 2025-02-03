import 'package:get/get.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/get_categories.dart';

class CategoriesController extends GetxController {
  final GetCategoriesUsecase getCategories;

  CategoriesController(this.getCategories);

  var categories = <Category>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    isLoading(true);
    final result = await getCategories();
    result.fold(
      (failure) => errorMessage('Failed to load categories'),
      (data) => categories(data),
    );
    isLoading(false);
  }
}