import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_chat/data/models/user.dart';
import 'package:online_chat/data/services/base/auth_base.dart';
import 'package:online_chat/data/services/firebase_helper.dart';

class FirebaseAuthService extends AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseHelper _firebaseHelper = FirebaseHelper();

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return UserModel(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future deleteUser() {
    _firebaseAuth.currentUser.delete();
  }

  @override
  Future<User> currentUser() async {
    return await _firebaseAuth.currentUser;
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount _googleUser = await GoogleSignIn().signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential _result = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: _googleAuth.accessToken,
            idToken: _googleAuth.idToken,
          ),
        );

        return _userFromFirebase(_result.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    final LoginResult _result = await FacebookAuth.instance.login();
    switch (_result.status) {
      case LoginStatus.success:
        final AuthCredential _facebookCredential =
            FacebookAuthProvider.credential(_result.accessToken.token);
        final _userCredentail =
            await _firebaseAuth.signInWithCredential(_facebookCredential);
        var user = _userCredentail.user;

        return UserModel.withFacebook(
          user.uid,
          user.email,
          user.photoURL +
              "?height=500&access_token=" +
              _result.accessToken.token,
        );
        break;
      case LoginStatus.cancelled:
        return null;
        break;
      case LoginStatus.failed:
        throw _result.message;
        break;
      default:
    }
  }

  @override
  Future<void> signInWithPhone(
      String phoneNumber,
      Function verificationCompleted,
      Function sendMessage,
      Function timeOut,
      Function error) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+90' + phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: error,
      codeSent: sendMessage,
      codeAutoRetrievalTimeout: timeOut,
      timeout: Duration(seconds: 120),
    );
  }

  @override
  Future<UserModel> verifyOTP(String verificationId, String smsCode) async {
    UserCredential _userCredential = await _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode));

    var _user = _userCredential.user;
    return UserModel.withPhone(
        userID: _user.uid, phoneNumber: _user.phoneNumber);
  }

  Future<UserModel> signInWithEmailandPassword(
      String email, String sifre) async {
    UserCredential _userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: sifre);
    if (_userCredential.user.emailVerified) {
      return _userFromFirebase(_userCredential.user);
    } else {
      await _firebaseHelper.sendEmailVerification(_userCredential.user);
      await signOut();
      throw 'verified-email';
    }
  }

  @override
  Future<UserModel> createPhoneUser(PhoneAuthCredential credential) async {
    UserCredential _userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    var _user = _userCredential.user;
    return UserModel.withPhone(
        userID: _user.uid, phoneNumber: _user.phoneNumber);
  }

  @override
  Future<bool> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }
}
