import 'package:bike_rental/app/modules/auth/controllers/auth_controller.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/views/bricks/form_input.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninForm extends GetView<AuthController> {
  SigninForm({super.key});

  final GlobalKey signinForm = GlobalKey<FormState>();
  final TextEditingController identifier = TextEditingController();
  final TextEditingController password = TextEditingController();

  final isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signinForm,
      child: AutofillGroup(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormInput(
            inputController: identifier,
            label: 'Username',
            hint: 'Sign In with email or phone number',
            autofillHints: const [AutofillHints.username, AutofillHints.email],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: password,
            label: 'Password',
            hint: 'Enter Password',
            obscure: true,
            autofillHints: const [AutofillHints.password],
          ),
          UIHelperViews.vSpaceMedium,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {}, child: const Text('Forgot password.'))
            ],
          ),
          ObxValue((data) {
            return ElevatedButton(
              onPressed: data.value ? null : login,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: data.value
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Sign In'),
              ),
            );
          }, isLoading),
        ],
      )),
    );
  }

  login() async {
    isLoading(true);
    try {
      if (identifier.text.isEmpty || password.text.length < 6) {
        throw SigninException(
            message:
                'Invalid username or password. Please check input and try again.');
      }

      await controller.login(
          identifier: identifier.text, password: password.text);

      Get.toNamed(Routes.HOME);
    } on SigninException catch (e) {
      Get.snackbar('Sign In Error', e.message,
          duration: 5.seconds, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      e.printError();
    } finally {
      isLoading(false);
    }
  }
}

class SigninException implements Exception {
  final String message;

  SigninException({required this.message});

  @override
  String toString() {
    return 'Sign In error: $message';
  }
}
