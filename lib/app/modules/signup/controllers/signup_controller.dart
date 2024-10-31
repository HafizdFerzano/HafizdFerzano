import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final cEmail = TextEditingController();
  final cPass = TextEditingController();
  
  // Observables
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
  var passwordStrength = 0.0.obs;

  @override
  void onClose() {
    cEmail.dispose();
    cPass.dispose();
    super.onClose();
  }

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Example method to check password strength
  Color getPasswordStrengthColor() {
    if (passwordStrength.value < 0.3) return Colors.red;
    if (passwordStrength.value < 0.7) return Colors.orange;
    return Colors.green;
  }

  // Example method to return password strength text
  String passwordStrengthText() {
    if (passwordStrength.value < 0.3) return 'Weak';
    if (passwordStrength.value < 0.7) return 'Medium';
    return 'Strong';
  }

  // Example method to validate form
  bool isFormValid() {
    return cEmail.text.isNotEmpty && cPass.text.isNotEmpty;
  }
}
