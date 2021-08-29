import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/complete_login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class CustomPageViewButton extends StatelessWidget {
  final bool back;
  final bool contiune;
  final String backText;
  final String contiuneText;

  const CustomPageViewButton(
      {Key key,
      this.back: true,
      this.contiune: true,
      this.backText: "Geri",
      this.contiuneText: "İleri"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          back == true ? buildBack() : Container(),
          Spacer(),
          contiune == true ? buildContiune() : Container()
        ],
      ),
    );
  }

  InkWell buildContiune() {
    return InkWell(
      onTap: () => Get.find<CompleteLoginController>().contiunePageView(),
      child: Container(
        child: Row(
          children: [
            Text(
              contiuneText,
              style: kContentBodyTextStyle.copyWith(color: kPrimaryColor),
            ),
            buildIcon(
              iconData: Icons.arrow_forward_ios,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildBack() {
    return InkWell(
      onTap: () => Get.find<CompleteLoginController>().backPageView(),
      child: Container(
        child: Row(
          children: [
            buildIcon(
              iconData: Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
            Text(
              backText,
              style: kContentBodyTextStyle.copyWith(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

Padding buildIcon({iconData, color}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(5),
        getProportionateScreenWidth(14),
        getProportionateScreenWidth(5),
        getProportionateScreenWidth(14)),
    child: Icon(
      iconData,
      color: color,
      size: getProportionateScreenWidth(20),
    ),
  );
}
