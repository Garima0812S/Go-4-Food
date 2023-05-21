import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widgets.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5 , (index) {return Icon(Icons.star, color:ColorConstants.mainColor ,size:15,);}),
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidgets(icon: Icons.circle_sharp,
                text:"Normal",
                iconColor: ColorConstants.iconColor1),

            IconAndTextWidgets(icon: Icons.location_on,
                text:"1.7km",
                iconColor:ColorConstants.mainColor
            ),
            IconAndTextWidgets(icon: Icons.access_time_rounded,
                text:"32min",
                iconColor:ColorConstants.iconColor2
            ),

          ],
        )
      ],
    );
  }
}
