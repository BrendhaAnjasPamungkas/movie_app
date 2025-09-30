import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/presentation/controllers/register_controller.dart';
import '/core/widgets/main_widget.dart';
import '/injection.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController(sl()));

    return Scaffold(
      appBar: AppBar(title: W.text(data: 'Register To MovieX')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                W.text(data: 'Create Account', fontSize: 24, fontWeight: FontWeight.bold),
                W.gap(height: 32),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Email cannot be empty' : null,
                ),
                W.gap(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) => (value != null && value.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                W.gap(height: 24),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  return W.button(
                    onPressed: controller.register,
                    width: double.infinity,
                    child: W.text(data: 'Register', color: Colors.white),
                    backgroundColor: Colors.blue,
                  );
                }),
                Obx(() {
                  if (controller.errorMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: W.text(data: controller.errorMessage.value, color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}