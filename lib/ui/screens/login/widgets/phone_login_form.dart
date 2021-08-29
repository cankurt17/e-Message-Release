import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_suffix_icon.dart';
import 'package:online_chat/widgets/default_button.dart';

class PhoneLoginForm extends StatelessWidget {
  LoginController _loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        phoneTextField(),
        buildContinueButton(),
      ],
    );
  }

  Padding buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(kDefaultPadding),
      ),
      child: DefaultButton(
        text: "Devam Et",
        press: () {
          _loginController.signInWithPhone();
        },
      ),
    );
  }
}

Padding phoneTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
    child: Form(
      key: Get.find<LoginController>().formKey,
      child: TextFormField(
        controller: Get.find<LoginController>().phoneTextController,
        validator: (value) =>
            Get.find<LoginController>().phoneNumberValidator(value),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Telefon",
          hintText: "536 224 2417",
          helperText: "* Numaranızı 10 hane olarak giriniz",
          suffixIcon: CustomSuffixIcon(
            iconData: Icons.phone,
          ),
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
      ),
    ),
  );
}
