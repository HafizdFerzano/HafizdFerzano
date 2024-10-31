import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final AuthController cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 150, 34),
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Membuat Akun',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                controller: controller.cEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Obx(() => TextFormField(
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    controller: controller.cPass,
                  )),
              SizedBox(height: 20),
              Obx(() => LinearProgressIndicator(
                    value: controller.passwordStrength.value,
                    color: controller.getPasswordStrengthColor(),
                    backgroundColor: Colors.grey[300],
                  )),
              SizedBox(height: 10),
              Obx(() => Text(
                    controller.passwordStrengthText(),
                    style: TextStyle(
                      color: controller.getPasswordStrengthColor(),
                    ),
                  )),
              SizedBox(height: 30),
              Obx(() => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        if (controller.isFormValid()) {
                          controller.isLoading.value = true;
                          cAuth.signup(
                            controller.cEmail.text,
                            controller.cPass.text,
                          );
                          controller.isLoading.value = false;
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please fill in all fields',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text('Sign Up'),
                      ),
                    )),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    'Sudah Punya Akun? Login',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
