import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_suffix_icon.dart';
import 'package:online_chat/widgets/custom_text_button.dart';

class PasswordAndSingupButton extends StatelessWidget {
  LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextButton(
          text: "Şifremi unuttum.",
          press: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return buildForgotPassword(context);
              },
            );
          },
        ),
        CustomTextButton(
          text: "Hesabın yok mu? Üye ol.",
          press: () {
            Get.toNamed('/signup');
          },
        ),
      ],
    );
  }

  Container buildForgotPassword(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(
            top: getProportionateScreenWidth(kDefaultPadding),
            left: getProportionateScreenWidth(kDefaultPadding / 2),
            right: getProportionateScreenWidth(kDefaultPadding / 2)),
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            emailTextField(),
            SizedBox(height: kDefaultPadding),
            ElevatedButton(
              onPressed: () {
                _loginController.resetPassword();
              },
              child: Text("Şifre yenileme maili gönder"),
              style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Form emailTextField() {
    return Form(
      key: _loginController.forgotFormKey,
      child: TextFormField(
        controller: _loginController.forgotPasswordTextController,
        validator: (value) => _loginController.forgotEmailValidator(value),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Emailinizi giriniz",
          suffixIcon: CustomSuffixIcon(
            iconData: Icons.mail,
          ),
        ),
      ),
    );
  }
}
