import 'package:flutter/material.dart';
import 'package:online_chat/errors/signup_errors.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

dynamic loginError(dynamic e) {
  switch (e) {
    case 'empty-phone-number':
      return "Lütfen numaranızı giriniz.";
      break;
    case 'empty-email':
      return "Lütfen mailinizi giriniz.";
      break;
    case 'empty-password':
      return "Lütfen şifrenizi giriniz.";
      break;
    case 'lenght-phone-number':
      return "Lütfen 10 hane olarak giriniz.";
      break;
    case 'phone-number-validate':
      return "Lütfen geçerli bir numara giriniz.";
      break;
    case 'user-not-found':
      customSnackBar("Mail Uyarısı!",
          "Bu mail adresi kayıtlı değil.Lütfen kayıt yaparak devam ediniz.",
          icon: Icons.warning, color: Colors.yellow);
      break;
    case 'verified-email':
      customSnackBar("Mail Uyarısı!",
          "Size bir doğrulama maili gönderdik.Hesabınızı doğrulayarak tekrar deneyiniz.",
          icon: Icons.warning, color: Colors.yellow);
      break;
    case 'account-exısts-wıth-dıfferent-credentıal':
      customSnackBar("Mail Uyarısı!",
          "Bu mail adresi farklı bir giriş yöntemi ile kullanılmakta.");
      break;
    case 'user-not-found':
      customSnackBar("Mail Uyarısı!",
          "Bu mail adresi kayıtlı değil lütfen kayıt olarak devam ediniz.",
          icon: Icons.mail);
      break;
    case 'invalid-email':
      customSnackBar("Mail Uyarısı!", "Lütfen geçerli bir mail adresi giriniz.",
          icon: Icons.mail);
      break;
    case 'wrong-password':
      customSnackBar(
          "Şifre Uyarısı!", "Hatalı şifre girdiniz lütfen tekrar deneyiniz.",
          icon: Icons.vpn_key);
      break;
    case 'lenght-sms-code':
      customSnackBar(
          defaultErrorTitle, "Doğrulama kodunu 6 hane olarak girmelisiniz.");
      break;
    case 'sms-time-out':
      customSnackBar(defaultErrorTitle,
          "Doğrulama kodu zaman aşımına uğradı tekrar deneyiniz.");
      break;
    case 'invalid-verification-code':
      customSnackBar(defaultErrorTitle,
          "Doğrulama kodunu hatalı girdiniz lütfen kontrol ediniz.");
      break;
    case 'too-many-requests':
      customSnackBar(defaultErrorTitle,
          "Yakın zamanda çok fazla giriş denemesi yapıldı.Daha sonra tekrar deneyiniz");
      break;
    case 'default-error':
      customSnackBar(defaultErrorTitle, defaultError + "\n" + e);
      break;

    case 'account-exists-with-different-credential':
      customSnackBar(defaultErrorTitle, "Bu mail adresi zaten kullanımda.");
      break;
    default:
      customSnackBar(defaultErrorTitle, defaultError + "\n" + e.toString());
  }
}
