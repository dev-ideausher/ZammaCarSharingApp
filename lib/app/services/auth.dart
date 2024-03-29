import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:zammacarsharing/app/modules/models/otp_used_class.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/dialog_helper.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';

class Auth extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool otpSendSuccessFully = false;
   OtpNeededData instanceOfOtpNeededData = OtpNeededData() ;

  //google
  late GoogleSignIn googleSign;
  GoogleSignInAccount? _currentUser;

  @override
  void onInit() async {
    super.onInit();
    googleSign = GoogleSignIn();
    googleSign.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      if (_currentUser != null) {
        handleGetContact(
            id: _currentUser!.id.toString(),
            fullName: _currentUser!.displayName.toString(),
            email: _currentUser!.email.toString(),
            photoUrl: _currentUser!.photoUrl.toString(),
            phoneNumber: "");
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      sendEmailtoUser(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMySnackbar(title: "Error!", msg: "User not found");
      } else if (e.code == 'wrong-password') {
        showMySnackbar(title: "Error!", msg: "Wrong password");
      }
    }
  }

  Future<void> sendEmailtoUser(UserCredential userCredential) async {
    User? user = userCredential.user;
    if (user!.emailVerified) {
      handleGetContact(
          id: user.uid,
          fullName: user.displayName.toString(),
          email: user.email!,
          photoUrl: user.photoURL.toString(),
          phoneNumber: user.phoneNumber.toString());
    } else if (!user.emailVerified) {
      try {
        await user.sendEmailVerification();
        showMySnackbar(
            title: "Email Sent!",
            msg:
                "Verification Email has been sent please verify then try loggin in again.");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          showMySnackbar(
              title: "Error!",
              msg: "Too many attemts try again after sometime.");
        }
      }
    }
  }

  Future<void> handleGetContact(
      {required String id,
      required String fullName,
      required String email,
      required String photoUrl,
      required String phoneNumber}) async {
    var mytoken = await firebaseAuth.currentUser!.getIdToken(true);
    Get.find<GetStorageService>().jwToken = mytoken!;
  }

  //apple
  Future<void> appleLogin() async {
    final credential = await signInWithApple();
    handleGetContact(
        id: credential.user!.uid.toString(),
        fullName: credential.user!.displayName.toString(),
        email: credential.user!.email.toString(),
        photoUrl: credential.user!.photoURL.toString(),
        phoneNumber: credential.user!.phoneNumber.toString());
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  //Facebook
  /* Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      handleGetContact(
          id: userData["id"].toString(),
          fullName: userData["name"].toString(),
          email: userData["email"].toString(),
          photoUrl: userData["picture"]['data']['url'].toString(),
          phoneNumber: "");
    } else {
      Get.snackbar("Notification ", result.message.toString());
    }

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }*/

  Future<void> googleSignUp() async {
    //await googleSign.disconnect();
    // await firebaseAuth.signOut();
    try {
      DialogHelper.showLoading();
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
      if (googleSignInAccount == null) {
        DialogHelper.hideDialog();
      } else {
        DialogHelper.hideDialog();
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await firebaseAuth.signInWithCredential(oAuthCredential);

        handleGetContact(
            id: googleSignInAccount.id.toString(),
            fullName: googleSignInAccount.displayName.toString(),
            email: googleSignInAccount.email.toString(),
            photoUrl: googleSignInAccount.photoUrl.toString(),
            phoneNumber: "");
      }
    } catch (e) {
      DialogHelper.hideDialog();
      print(e);
    }
  }

  signInWithTwitter() async {
    final twitterLogin = await TwitterLogin(
        apiKey: 'ApiKey',
        apiSecretKey: 'apiSecretKey',
        redirectURI: 'twittersdk-yFEAPha8M3cyYUvMCdEksfuok://');

    await twitterLogin.loginV2().then((value) async {
      final authToken = value.authToken;
      final authTokenSecret = value.authTokenSecret;
      if (authToken != null && authTokenSecret != null) {
        final twitterAuthCredentials = TwitterAuthProvider.credential(
            accessToken: authToken, secret: authTokenSecret);
        var credential = await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredentials);
        handleGetContact(
            id: credential.user!.uid.toString(),
            fullName: credential.user!.displayName.toString(),
            email: credential.user!.email.toString(),
            photoUrl: credential.user!.photoURL.toString(),
            phoneNumber: credential.user!.phoneNumber.toString());
      }
    });
  }

  Future<void> verifyPhone(String phoneNumber,bool firstTime) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: await (String verId) {
            Get.find<GlobalData>().loader.value = false;
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
          },
          codeSent:await (verificationId, forceResendingToken) {
            //Verify Otp Ui

            print("codeSent");
            Get.find<GlobalData>().loader.value = false;

           if(firstTime)
            Get.offNamed(Routes.OTP,arguments: [OtpNeededData(mobileNumber: phoneNumber,veryFicationId: verificationId)]);
          },
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
        //  timeout: const Duration(seconds: 20),
          verificationCompleted : await (AuthCredential phoneAuthCredential){
            print("verificationCompleted");
            print(phoneAuthCredential);
            Get.find<GlobalData>().loader.value = false;
          },
          verificationFailed: await (error){
            Get.find<GlobalData>().loader.value = false;
            Get.snackbar("Error", error.message.toString());
          });

      print("before");

    } catch (e) {
      Get.find<GlobalData>().loader.value = false;
      Get.snackbar("Error", e.toString());

    }
  }

 /* Future<bool> verifyOTP(
      {required String smsCode,
      required String verificationId,
      required String phoneNumber}) async {
    var firebaseAuth1 = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
     final value= await firebaseAuth.signInWithCredential(firebaseAuth1);

        if (value.user != null) {

         await handleGetContact(
              id: value.user!.uid.toString(),
              fullName: value.user!.displayName.toString(),
              email: value.user!.email.toString(),
              photoUrl: value.user!.photoURL.toString(),
              phoneNumber: value.user!.phoneNumber.toString());
       //  await Get.put(GetStorageService()).initState();
          return true;

        } else {
          Get.snackbar("Info", "Wrong otp");
          return false;
        }


    } catch (e) {
      print(e);
      return false;
    }
  }*/
  Future<bool> verifyOTP(
      {required String smsCode,
        required String verificationId,
        required String phoneNumber}) async {
 //   UtilWidgets.showLoading();
    bool verified = false;
    try {
      var firebaseAuth1 = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      await firebaseAuth
          .signInWithCredential(firebaseAuth1)
          .then((value) async {
        if (value.user != null) {
          Get.find<GetStorageService>().jwToken =  "${await firebaseAuth.currentUser!.getIdToken(true)}";
          verified = true;
        } else {
          showMySnackbar(title: "Error",msg: "Entered Otp is wrong");
        //  UtilWidgets.showToast(message: "Entered Otp is wrong", isError: true);
        }
      });
    } catch (e) {
    //  UtilWidgets.hideLoading();
     // UtilWidgets.showToast(message: e.toString(), isError: true);
      showMySnackbar(title: "Error",msg:"Entered Otp is wrong");
    } finally {
     // UtilWidgets.hideLoading();
    }
    return verified;
  }

  Future<void> logout() async {
    try {
      firebaseAuth.signOut();
      await googleSign.disconnect();
      Get.find<GetStorageService>().deleteLocation();
    } catch (e) {
      Get.find<GetStorageService>().deleteLocation();
    }
  }
}
