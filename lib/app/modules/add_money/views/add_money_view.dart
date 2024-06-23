import 'package:bike_rental/app/views/bricks/form_input.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_money_controller.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  const AddMoneyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add money'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter amount'),
            Form(
              key: controller.formKey,
              child: FormInput(
                inputController: controller.amountController,
                label: 'Amount',
                hint: 'Enter amount',
              ),
            ),
            UIHelperViews.vSpaceMedium,
            ElevatedButton(
                onPressed: controller.addMoney, child: const Text('Add money'))
          ],
        ),
      ),
    );
  }
}
