import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/dimensions.dart';

import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {

  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => MainFoodPageState();
}

class MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {

   if (kDebugMode) {
      print("current height is${MediaQuery.of(context).size.height}");
    }
    return Scaffold(
      body: Column(
        children: [

          //Showing the header
           Container(
             margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(top:Dimensions.height20 ,bottom: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text:"India", color: Colors.deepOrangeAccent),
                    Row(
                      children: [
                        SmallText(text: "Ghaziabad", color: Colors.grey),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height:  Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color:Colors.deepOrangeAccent ,
                    ),
                    child:  Icon(Icons.search , color: Colors.white , size: Dimensions.iconSize24,),
                  ),
                ),
              ],
            ),
           ),
           //Showing the body

          const Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),


        ],
      ),
    );
  }
}

