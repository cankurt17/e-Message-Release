import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/complete_login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/screens/complete_login/widgets/custom_pageview_button.dart';
import 'package:online_chat/ui/size_config.dart';

class Username extends StatelessWidget {
  CompleteLoginController _controller = CompleteLoginController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: Get.find<CompleteLoginController>().usernameFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildUsernameText(),
                SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
                buildGenderRadio(),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
          CustomPageViewButton(
            contiuneText: "Kaydı tamamla",
          ),
        ],
      ),
    );
  }

  Row buildGenderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Radio(
              value: "Erkek",
              groupValue: _controller.selectedGender,
              onChanged: (value) => _controller.changeGender(value),
            ),
            Text("Erkek"),
          ],
        ),
        Row(
          children: [
            Radio(
              value: "Kadın",
              groupValue: _controller.selectedGender,
              onChanged: (value) => _controller.changeGender(value),
            ),
            Text("Kadın"),
          ],
        ),
        Spacer()
      ],
    );
  }

  TextFormField buildUsernameText() {
    return TextFormField(
      controller: Get.find<CompleteLoginController>().usernameTextController,
      validator: (value) => _controller.usernameValidator(value),
      decoration: InputDecoration(
        labelText: 'Kullanıcı adı',
        hintText: 'Kullanıcı adı giriniz.',
      ),
    );
  }
}
