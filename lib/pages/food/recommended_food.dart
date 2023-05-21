import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/popular_product_controllers.dart';
import 'package:food_delivery/data/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app.constant.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFood extends StatelessWidget {

  final int pageId;
  const RecommendedFood({Key? key, required this.pageId}) : super(key: key);

  @override
// final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
       // controller: _scrollController,
        slivers: [
          SliverAppBar(

            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Get.toNamed(RouteHelper.getInitial());
                 },
                child:const AppIcon(icon: Icons.clear),
                ),

                //const AppIcon(icon: Icons.shopping_cart_outlined)

                GetBuilder<PopularProductController>(builder: (controller){
                 return GestureDetector(
                      onTap: (){
                    if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                  },
                  child:Stack(
                    children: [
                       AppIcon(icon :Icons.shopping_cart_outlined),

                      Get.find<PopularProductController>().totalItems>=1?
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
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: BigText(
                    size: Dimensions.font26,
                    text: product.name,
                  ),
                ),
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.orange,
            flexibleSpace: SizedBox(
              height: 400,
              child: FlexibleSpaceBar(
                background:Image.network(
              AppCOnstants.BASE_URL+AppCOnstants.UPLOAD_URL+product.img,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                      text:product.description),
                ),
                Container(
                  height: 200,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.width10,
                bottom: Dimensions.width10,
              ),

              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child:AppIcon(
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: ColorConstants.mainColor,
                      icon: Icons.remove,
                    ),
                  ),
                  BigText(text: "\$ ${product.price} X  ${controller.inCartItems}", color: ColorConstants.mainColor,size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child:AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: ColorConstants.mainColor,
                    icon: Icons.add,
                  ),
                  ),
                ],
              ),

            ),
            Container(
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
                    child: const Icon(
                      Icons.favorite,
                      color: ColorConstants.mainColor,
                    ),
                  ),

                  GestureDetector(
                    onTap:() {
                      controller.addItem(product);
                    },
                      child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: ColorConstants.mainColor,
                    ),
                    child: BigText(text: "\$ ${product.price} | Add to Cart", color: Colors.white),
                  )
                  )
                ],
              ),
            )
          ],
        );
      },)

    );
  }
}
