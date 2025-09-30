import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/presentation/controllers/login_controller.dart';
import '/app/presentation/pages/register_page.dart';
import '/core/widgets/main_widget.dart';
import '/injection.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftarkan LoginController
    final controller = Get.put(LoginController(sl()));

    return Scaffold(
      appBar: AppBar(title: W.text(data: 'Login To MovieX')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                W.text(
                  data: 'Welcome to MovieX',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                W.gap(height: 32),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Email cannot be empty' : null,
                ),
                W.gap(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Password cannot be empty'
                      : null,
                ),
                W.gap(height: 24),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  return W.button(
                    onPressed: controller.login,
                    width: double.infinity,
                    child: W.text(data: 'Login', color: Colors.white),
                    backgroundColor: Colors.blue,
                  );
                }),
                Obx(() {
                  if (controller.errorMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: W.text(
                        data: controller.errorMessage.value,
                        color: Colors.red,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                W.gap(height: 16),
                TextButton(
                  onPressed: () => Get.to(
                    () => const RegisterPage(),
                  ), // Pindah ke halaman register
                  child: W.text(data: "Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
