import 'package:online_chat/errors/signup_errors.dart';
import 'package:online_chat/widgets/custom_snackbar.dart';

dynamic completeLoginError(dynamic e) {
  switch (e) {
    case 'empty-username':
      return "Lütfen kullanıcı adı girniz.";
      break;
    case 'lenght-username':
      return "En az 3 hane olmalıdır.";
      break;
    case 'username-validate':
      customSnackBar('Kullanıcı adı',
          "Bu kullanıcı adı zaten kullanımda.Lütfen farklı bir kullanıcı adı giriniz.");
      break;
    case 'null-image':
      customSnackBar(defaultErrorTitle, "Lütfen bir profil resmi ekleyin.");
      break;

    default:
      customSnackBar(defaultErrorTitle, defaultError + "\n" + e.toString());
  }
}
