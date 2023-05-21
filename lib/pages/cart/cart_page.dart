import 'package:flutter/material.dart';

import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/App_Icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../data/controllers/popular_product_controllers.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: ColorConstants.mainColor,
                    iconSize: Dimensions.iconSize24),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: ColorConstants.mainColor,
                        iconSize: Dimensions.iconSize24)),
                AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: ColorConstants.mainColor,
                    iconSize: Dimensions.iconSize24),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                         var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                      if (popularIndex >= 0) {
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                      } else {
                                        var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar("History product", "Product review is not availble for history product!", backgroundColor: ColorConstants.mainColor, colorText: Colors.white);
                                        } else {
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                        }
                                      }
                                      },
                                      child: Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          image: DecorationImage(
                                            image: NetworkImage
                                              (AppCOnstants.BASE_URL +
                                                AppCOnstants.UPLOAD_URL +
                                                cartController.getItems[index]
                                                    .img!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            BigText(text: cartController
                                                .getItems[index].name!,
                                                color: Colors.black54),
                                            SmallText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                BigText(text: "\$ " +
                                                    cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.redAccent),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom: Dimensions
                                                          .height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions
                                                          .width10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        Dimensions.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: Icon(
                                                            Icons.remove,
                                                            color: ColorConstants
                                                                .paraColor),
                                                      ),
                                                      SizedBox(width: Dimensions
                                                          .width10 / 2),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      //popularProduct.ionCartItems.toString(), color: AppColors.mainBlackColor),
                                                      SizedBox(width: Dimensions
                                                          .width10 / 2),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                              _cartList[index]
                                                                  .product!, 1);
                                                          // print("being tapped!");
                                                        },
                                                        child: Icon(Icons.add,
                                                            color: ColorConstants
                                                                .paraColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        );
                      },
                    ),
                  ),
                )
            )
                : BigText(text: "Your cart is emty!");
          },
          ),
        ],
      ),

    bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,
              bottom: Dimensions.height30, right: Dimensions.width20, left: Dimensions.width20),
          decoration: BoxDecoration(
            color: ColorConstants.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: cartController.getItems.length > 0
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // - or +
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,
                    bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: "\$" + cartController.totalAmount.toString(), color: Colors.black54),
                    SizedBox(width: Dimensions.width10 / 2),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // popularProduct.addItem(product);

                    if (!Get.find<AuthController>().userLoggedIn()) {
                    print("tapped");
                    // cartController.addToHistory();
                    if (Get.find<LocationController>().addressList.isEmpty) {
                      Get.toNamed(RouteHelper.getAddresssPage());
                    } else {
                      Get.offAndToNamed(RouteHelper.getInitial());
                    }
                  } else {
                    Get.toNamed(RouteHelper.getsigInPage());
                  }
                },
                child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.height20,
                        left: Dimensions.height20),
                    child: BigText(text: "| Check out", color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: ColorConstants.mainColor,
                    ),
                  );

              },
              ),
            ],
          )
              : Container()
            );
          }
        ),
      );
    }
}



//import 'package:flutter/material.dart';
//
// import 'package:food_delivery/data/controllers/cart_controller.dart';
// import 'package:food_delivery/pages/home/main_food_page.dart';
// import 'package:food_delivery/routes/routes_helper.dart';
// import 'package:food_delivery/utils/app.constant.dart';
// import 'package:food_delivery/utils/color.dart';
// import 'package:food_delivery/utils/dimensions.dart';
// import 'package:food_delivery/widgets/App_Icon.dart';
// import 'package:food_delivery/widgets/big_text.dart';
// import 'package:food_delivery/widgets/small_text.dart';
// import 'package:get/get.dart';
//
// class CartPage extends StatelessWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//               top: Dimensions.height20*3,
//               left: Dimensions.width20,
//               right: Dimensions.width20,
//              // bottom: Dimensions.bottomHeightBar,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppIcon(icon: Icons.arrow_back_ios,
//                     iconColor: Colors.white,
//                     backgroundColor: ColorConstants.mainColor,
//                     iconSize: Dimensions.iconSize24,
//                   ),
//                   SizedBox(width: Dimensions.width20*5,),
//                    GestureDetector(
//               onTap: (){
//                 Get.toNamed(RouteHelper.getInitial());
//               },
//                 child:  AppIcon(icon: Icons.home_outlined,
//                     iconColor: Colors.white,
//                     backgroundColor: ColorConstants.mainColor,
//                     iconSize: Dimensions.iconSize24,
//                   ),),
//                   AppIcon(icon: Icons.shopping_cart_outlined,
//                     iconColor: Colors.white,
//                     backgroundColor: ColorConstants.mainColor,
//                     iconSize: Dimensions.iconSize24,
//                   ),
//                 ],
//               ),
//           ),
//          Positioned(
//               top: Dimensions.height20*6.5,
//               left: Dimensions.width20,
//               right: Dimensions.width20,
//               bottom: 0,
//                  child:Container(
//                   margin:EdgeInsets.only(top: Dimensions.height15) ,
//                  // color: Colors.red,
//                 child: MediaQuery.removePadding
//                   (
//                   context: context,
//                     removeTop: true,
//                     child:
//                    GetBuilder<CartController>(builder: (cartController){
//                      var _cartList=cartController.getItems;
//                      return ListView.builder(
//                           itemCount: _cartList.length,
//                           itemBuilder: (_,index) {
//                             return Container(
//                               width: double.maxFinite,
//                               height:Dimensions.height20*6.5,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: Dimensions.height20*6.5,
//                                     height: Dimensions.height20*6.5,
//                                    margin: EdgeInsets.only(top: Dimensions.height15),
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           fit: BoxFit.cover,
//
//                                         image: NetworkImage(
//                                           cartController.getItems[index].img != null
//                                               ? AppCOnstants.BASE_URL + AppCOnstants.UPLOAD_URL + cartController.getItems[index].img!
//                                               : '', // Provide a default value when the img is null
//                                         ),
//
//                                        /*  image: NetworkImage(
//                                               AppCOnstants.BASE_URL+AppCOnstants.UPLOAD_URL+ cartController.getItems[index].img!,
//                                           ),*/
//                                         ),
//                                       borderRadius: BorderRadius.circular(Dimensions.radius20),
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                  SizedBox(width: Dimensions.width10,),
//                                   Expanded(child: Container(
//                                     height: Dimensions.height20*6,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         BigText(text: cartController.getItems[index].name!,
//                                           color: Colors.black54,
//                                         ),
//                                         SmallText(text: "Spicy"),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             BigText(text: cartController.getItems[index].price.toString(),color: Colors.redAccent,),
//                                             Container (
//                                               padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(Dimensions.radius20),
//                                                 color: Colors.white,
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       //popularProduct.setQuantity(false);
//                                                     },
//                                                     child: const Icon(Icons.remove,color: ColorConstants.signColor,),
//                                                   ),
//                                                   SizedBox(width: Dimensions.width10/2,),
//                                                   BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
//                                                   SizedBox(width: Dimensions.width10/2,),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       //popularProduct.setQuantity(true);
//                                                     },
//                                                     child: const Icon(Icons.add,color: ColorConstants.signColor,),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   ),
//
//                                 ],
//                               ),
//                             );
//                           }
//                       );
//                     }
//                     ),
//                 )
//               ),
//
//           )
//          ]
//          ),
//       );
//   }
// }*/
