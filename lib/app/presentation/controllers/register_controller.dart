import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/presentation/pages/login_page.dart';
import '/app/domain/usecases/register_user.dart';


class RegisterController extends GetxController {
  final RegisterUser _registerUser;
  RegisterController(this._registerUser);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  void register() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      errorMessage('');

      final result = await _registerUser.execute(
        emailController.text,
        passwordController.text,
      );

      result.fold(
        (failure) {
          errorMessage(failure.message);
        },
        (user) {
          Get.offAll(() =>  LoginPage());
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