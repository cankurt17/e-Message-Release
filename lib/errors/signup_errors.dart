import 'package:flutter/material.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

String defaultErrorTitle = "Bir Sorunla Karşılaşıldı!";
String defaultError = "Lütfen tekrar deneyiniz";

dynamic signupError(dynamic e) {
  switch (e) {
    case 'empty-password':
      return "Bir şifre giriniz.";
      break;
    case 'upper-case-password':
      return "En az bir büyük harf içermelidir.";
      break;
    case 'lower-case-password':
      return "En az bir küçük harf içermelidir.";
      break;
    case 'number-password':
      return "En az bir rakam içermelidir.";
      break;
    case 'digit-password':
      return "En az 8 karakter olmalıdır.";
      break;
    case 'empty-email':
      return "Bir mail adresi giriniz.";
      break;
    case 'email-validate':
      return "Lütfen geçerli bir email adresi giriniz.";
      break;
    case 'emaıl-already-ın-use':
      customSnackBar(defaultErrorTitle,
          "Bu mail adresi zaten kullanımda. Lütfen farklı bir email adresi giriniz.");
      break;
    case 'succes-auth':
      customSnackBar("Kaydınız başarıyla tamamlanmıştır.",
          "Size bir doğrulama maili gönderdik.Lütfen hesabınızı doğrulayarak giriş yapınız.",
          icon: Icons.verified_user, color: Colors.green);
      break;
    case 'default-error':
      customSnackBar(defaultErrorTitle, defaultError + "\n" + e);
      break;
    default:
    
      customSnackBar(defaultErrorTitle, defaultError + "\n" + e.toString());
  }
}
