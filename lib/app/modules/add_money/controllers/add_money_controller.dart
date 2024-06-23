import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';

class AddMoneyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  double amount = 0;
  void addMoney() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    amount = double.parse(amountController.text);

    FlutterPaystackPlus.openPaystackPopup(
      publicKey: '-Your-public-key-',
      customerEmail: 'nuhu94@gmail.com',
      context: Get.context,
      secretKey: '-Your-secret-key-',
      plan: '-Your-plan-configured-from-your-dashboard-',
      amount: (amount * 100).toString(),
      reference: DateTime.now().millisecondsSinceEpoch.toString(),
      callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",
      onClosed: () {
        debugPrint('Could\'nt finish payment');
        Get.snackbar('Error', 'Could\'nt finish payment');
      },
      onSuccess: () async {
        debugPrint('successful payment');
        Get.snackbar('Success', 'successful payment');
        Get.offAllNamed(Routes.HOME);
      },
    );
  }
}
