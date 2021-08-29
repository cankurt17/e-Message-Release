import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_chat/data/models/user.dart';

abstract class AuthBase {
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password);
  Future<UserModel> signInWithEmailandPassword(String email, String sifre);
  Future deleteUser();
  Future<User> currentUser();
  Future<bool> signOut();
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<void> signInWithPhone(
      String phoneNumber,
      Function verificationCompleted,
      Function sendMessage,
      Function timeOut,
      Function error);

  Future<UserModel> createPhoneUser(PhoneAuthCredential credential);

  Future<UserModel> verifyOTP(String verificationIde, String smsCode);
  Future<bool> resetPassword(String email);
}
