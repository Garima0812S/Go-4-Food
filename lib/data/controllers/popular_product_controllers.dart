import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/repositry/popular_product__repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    try {
      Response response = await popularProductRepo.getPopularProductList();
      if (response.statusCode == 200) {
        _popularProductList = [];
        _popularProductList.addAll(Product.fromJson(response.body).products);
        _isLoaded = true;
        update();
      } else {
      }
    } catch (e) {
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more!",
          backgroundColor: ColorConstants.mainColor, colorText: Colors.white);
      if(_inCartItems>0)
      {
        _quantity=-_inCartItems;
        return quantity;
      }
      return 0;
    } else if (quantity > 20) {
      Get.snackbar("Item count", "You can't add more!",
          backgroundColor: ColorConstants.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }

  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
    });
    updateCartItemCount(); // Update the cart item count
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }


  void updateCartItemCount() {
    _inCartItems = _cart.totalItems;
    update();
  }
  List<CartModel>get getItems{
    return _cart.getItems;
  }

}
