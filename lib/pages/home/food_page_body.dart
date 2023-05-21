import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/popular_product_controllers.dart';
import 'package:food_delivery/data/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app.constant.dart';

import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widgets.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => FoodPageBodyState();
}

class FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor =0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
       // print("Current Value is$_currPageValue");
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded? SizedBox(
            //  color: Colors.redAccent,
            height: Dimensions.pageView,
          child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position,popularProducts.popularProductList[position]);
                }),

          ):const CircularProgressIndicator(
            color: ColorConstants.mainColor,);
        }),
        //Dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: ColorConstants.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );

        }),

        //RecommendedText

        SizedBox(height: Dimensions.height30,),
        Container(
          margin:EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom:3),
                child: BigText(text: ".",color:Colors.black26),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom:2),
                child: SmallText(text: "Food pairing",),
              ),
            ],
          ),

        ),
         //recommended food
        //List of food and images

        GetBuilder<RecommendedProductController>(builder:(recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index));
                    },

                  child:Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.width10),
                      child: Row(
                        children: [
                          //Image Sections
                          Container(
                            width: Dimensions.ListViewImgSize,
                            height: Dimensions.ListViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    image: NetworkImage(AppCOnstants.BASE_URL +
                                        AppCOnstants.UPLOAD_URL +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img))),
                          ),

                          //Text Container
                          Expanded(
                              child: Container(
                            height: Dimensions.ListViewTextConSize,
                            //width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: recommendedProduct
                                          .recommendedProductList[index].name),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                      text: "With Italian characteristics"),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndTextWidgets(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: ColorConstants.iconColor1),
                                      IconAndTextWidgets(
                                          icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: ColorConstants.mainColor),
                                      IconAndTextWidgets(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: ColorConstants.iconColor2),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                ),
                    );
                  }):const CircularProgressIndicator(
            color: ColorConstants.mainColor,
          );
        })

      ],
    );

  }

  Widget _buildPageItem(int index, ProductModel popularProducts){

    Matrix4 matrix = Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans ,0);
    }
    else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans ,0);
    }
    else if(index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans= _height*(1-_scaleFactor)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans ,0);
    }
    else
    {
      var currScale =0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2 ,0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
         GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child:
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.left10,right: Dimensions.right10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven?const Color(0xff69c5df):const Color(0xff9224cc),
                image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                       AppCOnstants.BASE_URL+AppCOnstants.UPLOAD_URL+popularProducts.img,
                    )
                )
            ),
          ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.radius30,right: Dimensions.radius30, bottom: Dimensions.radius30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,

                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0,5)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    )

                  ]


              ),

              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.height15 ,right: Dimensions.height15),
                child: AppColumn(text: popularProducts.name,),


              ),

            ),
          )
        ],
      ),
    );
  }

}