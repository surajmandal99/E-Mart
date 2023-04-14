import 'package:emart_app/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(15).make(),
      5.heightBox,
      title!.text.align(TextAlign.center).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(68)
      .padding(const EdgeInsets.all(6))
      .make();
}
