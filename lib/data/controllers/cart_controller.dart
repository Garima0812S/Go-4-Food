import 'package:flutter/material.dart';
import 'package:food_delivery/data/repositry/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  final _storage = GetStorage();
  final Map<int, CartModel> _items = {}; // Modified to store CartModel objects
  Map<int, CartModel> get items => _items;

  @override
  void onInit() {
    // Load saved cart items from storage
    final savedItems = _storage.read('cartItems');
    if (savedItems != null) {
      _items.addAll({ for (var item in savedItems) item.id : CartModel.fromJson(item) });
    }
    super.onInit();
  }

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          product: value.product,
          quantity: totalQuantity,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id,
              () => CartModel(
            id: product.id,
            product: product,
            quantity: quantity,
          ),
        );
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add one item in the cart!",
          backgroundColor: ColorConstants.mainColor,
          colorText: Colors.white,
        );
      }
    }

    // Save cart items to storage
    _storage.write('cartItems', _items.values.toList());
  }

  bool existInCart(ProductModel product) {
    return _items.containsKey(product.id);
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      quantity = _items[product.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel>get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

}
