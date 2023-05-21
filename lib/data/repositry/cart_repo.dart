import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';

class CartRepo {
  final _storage = GetStorage();

  void init() {
    // Register the CartController
    Get.put<CartController>(CartController(cartRepo: this));
  }

  List<CartModel> getCartItems() {
    final savedItems = _storage.read('cartItems');
    if (savedItems != null) {
      return List.from(savedItems.map((item) => CartModel.fromJson(item)));
    }
    return [];
  }

  void saveCartItems(List<CartModel> items) {
    final jsonData = items.map((item) => item.toJson()).toList();
    _storage.write('cartItems', jsonData);
  }

  void clearCartItems() {
    _storage.remove('cartItems');
  }
}
