import 'package:food_delivery/data/api/api.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxController{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppCOnstants.POPULAR_PRODUCT_URI);

  }
}