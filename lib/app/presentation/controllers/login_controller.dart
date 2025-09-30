import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/domain/usecases/login_user.dart';
import '/app/presentation/pages/home_page.dart';

class LoginController extends GetxController {
  final LoginUser _loginUser;
  LoginController(this._loginUser);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      errorMessage(''); // Hapus pesan error sebelumnya

      final result = await _loginUser.execute(
        emailController.text,
        passwordController.text,
      );

      result.fold(
        (failure) {
          errorMessage(failure.message);
        },
        (user) {
          // Jika sukses, hapus semua halaman sebelumnya dan pergi ke HomePage
          Get.offAll(() => const HomePage());
        },
      );
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}