import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:get/get.dart';

import '../../data/controllers/cart_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app.constant.dart';
import '../../utils/dimensions.dart';
import '../../widgets/App_Icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
        Positioned(
        top: Dimensions.height20*3,
        left: Dimensions.width20,
        right: Dimensions.width20,
        // bottom: Dimensions.bottomHeightBar,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           AppIcon(icon: Icons.arrow_back_ios,
        iconColor: Colors.white,
        backgroundColor: ColorConstants.mainColor,
        iconSize: Dimensions.iconSize24,
        ),
         SizedBox(width: Dimensions.width20*5,),
          AppIcon(icon: Icons.home_outlined,
         iconColor: Colors.white,
           backgroundColor: ColorConstants.mainColor,
        iconSize: Dimensions.iconSize24,
            ),
           AppIcon(icon: Icons.shopping_cart_outlined,
           iconColor: Colors.white,
          backgroundColor: ColorConstants.mainColor,
          iconSize: Dimensions.iconSize24,
          ),
        ],
       ),
        ),
          Positioned(
              top: Dimensions.height20*6.5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child:Container(
              margin:EdgeInsets.only(top: Dimensions.height15) ,
             // color: Colors.red,
                child: MediaQuery.removePadding
                  (
                  context: context,
                  removeTop: true,
    child:GetBuilder<CartController>(builder: (cartController) {
       var _cartList=cartController.getItems;
      return ListView.builder(
        itemCount:  _cartList.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: Dimensions.height20 * 6.5,
            child: Row(
                children: [
                  Container(
                    width: Dimensions.height20 * 6.5,
                    height: Dimensions.height20 * 6.5,
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:NetworkImage(
                            AppCOnstants.BASE_URL+AppCOnstants.UPLOAD_URL+ cartController.getItems[index].img!,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Expanded(child: Container(
                      height: Dimensions.height20 * 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BigText(text: cartController.getItems[index].name!,
                            color: Colors.black54,
                          ),
                          SmallText(text: "Spicy"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //  popularProduct.setQuantity(false);
                                      },
                                      child: const Icon(Icons.remove,
                                        color: ColorConstants.signColor,),
                                    ),
                                    SizedBox(width: Dimensions.width10 / 2,),
                                    BigText(text: "0"),
                                    //popularProduct.inCartItems.toString()),
                                    SizedBox(width: Dimensions.width10 / 2,),
                                    GestureDetector(
                                      onTap: () {
                                        // popularProduct.setQuantity(true);
                                      },
                                      child: const Icon(Icons.add,
                                        color: ColorConstants.signColor,),
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ],
                      )
                  )

                  ),
                ]
            ),
          );
        },
      );

    },
    ),
              ),
              ),

          ), ],
        ),
      );
  }
}