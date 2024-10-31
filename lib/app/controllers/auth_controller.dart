import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  Future<void> signup(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();
      Get.defaultDialog(
        title: "Verifikasi Email",
        middleText: "Silakan verifikasi email Anda.",
        textConfirm: "Ok",
        onConfirm: () {
          Get.back(); // Close Dialog
        },
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.emailVerified ?? false) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "Harap verifikasi email terlebih dahulu!",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back(); // Close Dialog
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    try {
      void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke $email",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
        );
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "Tidak dapat melakukan reset password.");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi kesalahan", middleText: "Email tidak valid");
    }
  }
      await auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
        
        title: "Reset Password",
        middleText: "Email reset password telah dikirim!",
        textConfirm: "Ok",
        onConfirm: () {
          Get.back(); // Close Dialog
        },
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'user-not-found':
        message = "No user found for that email.";
        break;
      case 'wrong-password':
        message = "Wrong password provided for that user.";
        break;
      case 'email-already-in-use':
        message = "The email address is already in use by another account.";
        break;
      default:
        message = "An unexpected error occurred.";
    }

    Get.defaultDialog(
      title: "Proses Gagal",
      middleText: message,
    );
  }
}
