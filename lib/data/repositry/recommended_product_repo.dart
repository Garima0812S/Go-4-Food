import 'package:food_delivery/data/api/api.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxController{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppCOnstants.POPULAR_PRODUCT_URI);

  }
}