import 'package:flutter/material.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controllers.dart';
import 'package:food_delivery/data/repositry/cart_repo.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/App_Icon.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

class PopularFood extends StatelessWidget {
  int pageId;

  PopularFood({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController(cartRepo: CartRepo()));
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, cartController);

    //print("product name is"+product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
         body: Stack(
           children: [
             //Background region
             Positioned(
               left: 0,
               right: 0,
               child: Container(
                 width: double.maxFinite,
                 height: Dimensions.PopularFoodImgSize,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     fit: BoxFit.cover,
                     image: NetworkImage(
                       AppCOnstants.BASE_URL+AppCOnstants.UPLOAD_URL+product.img),
                   ),
                 ),
               ),
             ),
             //image widget
             Positioned(
                 top: Dimensions.height45,
                 left: Dimensions.width20,
                 right: Dimensions.width20,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.initial);
                        },
                       child: const AppIcon(icon :Icons.arrow_back_ios),
                      ),

                      GetBuilder<PopularProductController>(builder: (controller){
                        return GestureDetector(
                          onTap: (){
                            if(controller.totalItems>=1)
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child:Stack(
                          children: [
                            const AppIcon(icon :Icons.shopping_cart_outlined),
                           controller.totalItems>=1?
                            Positioned(
                                right:0, top:0,
                               child: AppIcon(icon: Icons.circle, size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: ColorConstants.mainColor,),

                            ):


                        Container(),
                            Get.find<PopularProductController>().totalItems>=1?
                            Positioned(
                              right:3, top:3,
                              child:BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                              size: 12, color: Colors.white,
                              )
                            ):
                            Container()
                          ],
                        ),
                        );
                      }),


                    ],
                 )
             ),
             //introduction region
             Positioned(
                left: 0,
                 right: 0,
                 top: Dimensions.PopularFoodImgSize-20,
                 bottom: 0,
                 child: Container(
                    padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                   decoration: BoxDecoration(
                     //color:AppColumn.buttonBackgroundColor,
                     borderRadius: BorderRadius.only(
                         topLeft:Radius.circular(Dimensions.radius20),
                        topRight:Radius.circular(Dimensions.radius20),
                     ),

                     color: Colors.white
                   ),
                   child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       AppColumn(text: product.name),
                       SizedBox(height: Dimensions.height20,),
                       BigText(text: "Introduce"),
                       SizedBox(height: Dimensions.height20,),
                       //expandable text
                       Expanded(child:SingleChildScrollView( child: ExpandableTextWidget(text: product.description)))
                     ],
                 )

                 )
             ),



           ],
         ),
            bottomNavigationBar:GetBuilder<PopularProductController>(builder: (popularProduct)
              {
               return Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color:ColorConstants.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(Dimensions.radius20*2),
                      topRight:Radius.circular(Dimensions.radius20*2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container (
                        padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                popularProduct.setQuantity(false);
                              },
                              child: const Icon(Icons.remove,color: ColorConstants.signColor,),
                            ),
                            SizedBox(width: Dimensions.width10/2,),
                            BigText(text: popularProduct.inCartItems.toString()),
                            SizedBox(width: Dimensions.width10/2,),
                            GestureDetector(
                              onTap: (){
                                popularProduct.setQuantity(true);
                              },
                              child: const Icon(Icons.add,color: ColorConstants.signColor,),
                            ),
                          ],
                        ),
                      ),


                GestureDetector(
                onTap: (){
                popularProduct.addItem(product);
                },
                child:
                Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: ColorConstants.mainColor,
                    ),
                    child: BigText(
                        text: "\$ ${product.price} | Add to Cart",
                        color: Colors.white),
                  ),
                ),
                ],
                  ),
                );
              },)

    );
  }
}
//