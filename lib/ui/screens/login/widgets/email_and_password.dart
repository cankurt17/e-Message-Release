import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/widgets/custom_suffix_icon.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';

class EmailAndPassword extends StatelessWidget {
  LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kDefaultPadding)),
        child: Obx(
          () => Form(
            key: _loginController.loginFormKey,
            child: Column(
              children: [
                emailTextField(),
                SizedBox(
                    height: getProportionateScreenHeight(kDefaultPadding / 2)),
                passwordTextField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      controller: _loginController.emailTextController,
      validator: _loginController.emailValidator,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Emailinizi giriniz",
        suffixIcon: CustomSuffixIcon(
          iconData: Icons.mail,
        ),
      ),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      controller: _loginController.passwordTextController,
      validator: _loginController.passwordValidator,
      obscureText: _loginController.passwordVisible,
      decoration: InputDecoration(
        labelText: "Şifre",
        hintText: "Şifrenizi giriniz",
        suffixIcon: buildPasswordIcon(),
      ),
    );
  }

  InkWell buildPasswordIcon() {
    return InkWell(
      onTap: _loginController.changePasswordVisible,
      child: CustomSuffixIcon(
        iconData: _loginController.passwordVisible == true
            ? Icons.visibility_off
            : Icons.visibility,
      ),
    );
  }
}
