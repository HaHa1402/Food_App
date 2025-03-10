import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/widgets/small.text.dart';

  //ten tieu de+ thanh gioi thieu
class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ?Chinese Slide
        BigText(text: text, size: Dimensions.font26),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(children: List.generate((5), (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15))),
            //  (4.5, 10, commit)
            Row(
              children: [
                SizedBox(width: 10),
                SmallText(text: "4.5"),
                SizedBox(width: 10),
                SmallText(text: "1287"),
                SizedBox(width: 10),
                SmallText(text: "bình luận"),
              ],
            ),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        //? Normal || 1.7 km ||32min
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp, text: "Bình thường", iconColors: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on, text: "1.7 km", iconColors: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded, text: "32 phút", iconColors: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
