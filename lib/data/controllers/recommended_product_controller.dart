import 'package:food_delivery/data/repositry/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList=[];
  List<ProductModel> get recommendedProductList=>_recommendedProductList;

  bool _isLoaded=false;
  bool get isLoaded=> _isLoaded;
  Future<void> getRecommendedProductList()async {
    Response response =await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200)
    {
      print("Got Products");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //  print(_popularProductList);
      _isLoaded=true;
      update();
    }
    else{

    }
  }
}