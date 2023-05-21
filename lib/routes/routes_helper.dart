import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/Popular_Food_Details.dart';
import 'package:food_delivery/pages/food/recommended_food.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => initial;
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainFoodPage()),

    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFood(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommendedFood(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: cartPage,
      page: () => CartPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
