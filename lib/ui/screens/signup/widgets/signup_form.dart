import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/singup_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_suffix_icon.dart';

class SignupForm extends StatelessWidget {
  SingupController _singupController = Get.find<SingupController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _singupController.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Obx(
          () => Column(
            children: [
              emailTextField(),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              passwordTextField(),
              SizedBox(height: getProportionateScreenHeight(kDefaultPadding)),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      obscureText: _singupController.passwordVisible,
      controller: _singupController.passwordTextController,
      validator: (value) => _singupController.passwordValidator(value),
      decoration: InputDecoration(
        labelText: 'Şifre',
        helperText:
            "* Şifreniz en az 8 karakter olmalı.\n* En az bir rakam, büyük ve küçük harf içermelidir",
        hintText: 'Şifrenizi giriniz.',
        suffixIcon: buildPasswordIcon(),
      ),
    );
  }

  InkWell buildPasswordIcon() {
    return InkWell(
      onTap: _singupController.changePasswordVisible,
      child: CustomSuffixIcon(
        iconData: _singupController.passwordVisible == true
            ? Icons.visibility_off
            : Icons.visibility,
      ),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      controller: _singupController.emailTextController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => _singupController.emailValidator(value),
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Emailinizi giriniz.',
        suffixIcon: CustomSuffixIcon(
          iconData: Icons.mail,
        ),
      ),
    );
  }
}
