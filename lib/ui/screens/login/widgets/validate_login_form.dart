import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_chat/controller/login_controller.dart';
import 'package:online_chat/ui/constants.dart';
import 'package:online_chat/ui/size_config.dart';
import 'package:online_chat/widgets/custom_pinput.dart';
import 'package:online_chat/widgets/default_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ValidateLoginForm extends StatelessWidget {
  LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildSmsTimer(),
        CustomPinput(),
        Text("Lütfen telefonunuza gelen kodu giriniz."),
        vuildLoginButton(),
      ],
    );
  }

  Padding buildSmsTimer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Container(
        height: getProportionateScreenHeight(25),
        child: Countdown(
          seconds: 120,
          interval: Duration(milliseconds: 100),
          build: (BuildContext context, double time) => Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: LinearProgressIndicator(
                  value: time / 120,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
              ),
              Center(
                child: Text(
                  time.toInt().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(18),
                      color: kSecondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding vuildLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(kDefaultPadding),
      ),
      child: DefaultButton(
        text: "Giriş Yap",
        press: () {
          _loginController.verifyOTP();
        },
      ),
    );
  }
}
