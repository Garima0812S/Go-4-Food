import 'package:food_delivery/data/api/api.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controllers.dart';
import 'package:food_delivery/data/repositry/cart_repo.dart';
import 'package:food_delivery/data/repositry/recommended_product_repo.dart';
import 'package:food_delivery/data/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/repositry/popular_product__repo.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:get/get.dart';

Future <void> init()async{

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppCOnstants.BASE_URL));

  //repos
  Get.lazyPut(()=>PopularProductRepo(apiClient:Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient:Get.find()));
  Get.lazyPut(()=>CartRepo());

  //controller
  Get.lazyPut(()=>PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}