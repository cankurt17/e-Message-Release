import 'package:flutter/material.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/custom_pageview_button.dart';
import 'package:online_chat/widgets/custom_suffix_icon.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(),
        SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
        buildContent(),
        SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
        CustomPageViewButton(
          back: false,
          contiune: true,
          contiuneText: "Hadi başlayalım",
        ),
      ],
    );
  }

  InkWell buildContiuneButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Row(
          children: [
            Spacer(),
            Text(
              "Hadi başlayalım ",
              style: kContentBodyTextStyle.copyWith(color: kPrimaryColor),
            ),
            CustomSuffixIcon(
              iconData: Icons.arrow_forward_ios,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Text buildContent() {
    return Text("Seni daha iyi tanımamız için kaydınızı tamamlamalıyız.",
        style: kContentBodyTextStyle);
  }

  Text buildTitle() {
    return Text(
      "Hoşgeldin...",
      style: kContentTextStyle,
    );
  }
}
