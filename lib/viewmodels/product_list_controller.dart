import 'package:dry_fish/repositories/products_repository.dart';
import 'package:get/get.dart';
import '../models/responses/category_response.dart';
import '../models/responses/products_response.dart' hide Category;
import '../repositories/category_repository.dart';
import 'category_controller.dart';

class ProductListController extends GetxController {
  final ProductsRepository _productRepo = ProductsRepository();

  var selectedCategoryIndex = 0.obs;
  var products = <Product>[].obs;
  var isLoadingProducts = false.obs;

  CategoryController categoryController = Get.find<CategoryController>();

  @override
  void onInit() {
    super.onInit();
    // wait until categories are loaded to set initial selection
    ever(categoryController.categoryList, (_) {
      if (categoryController.categoryList.isNotEmpty) {
        fetchProductsForSelectedCategory();
      }
    });
  }

  void setInitialCategory(String categoryName) {
    final index = categoryController.categoryList
        .indexWhere((c) => c.name == categoryName);
    if (index != -1) selectedCategoryIndex.value = index;
    fetchProductsForSelectedCategory();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    fetchProductsForSelectedCategory();
  }

  Future<void> fetchProductsForSelectedCategory() async {
    if (categoryController.categoryList.isEmpty) return;

    try {
      isLoadingProducts.value = true;
      final selectedCategory =
      categoryController.categoryList[selectedCategoryIndex.value];
      final response =
      await _productRepo.product(selectedCategory.id!); // API call
      if (response.success == true && response.products != null) {
        products.value = response.products!;
      } else {
        products.clear();
      }
    } catch (e) {
      print("Error fetching products: $e");
      products.clear();
    } finally {
      isLoadingProducts.value = false;
    }
  }
}

