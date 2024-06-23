import 'package:bike_rental/app/models/transaction_model.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: Get.theme.secondaryHeaderColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Available balance'),
                    ObxValue(
                        (me) => Text(
                              me.value?.wallet.balance.toString() ?? '0.00',
                              style: Get.theme.textTheme.headlineSmall,
                            ),
                        controller.app.me),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.ADD_MONEY);
                    },
                    child: const Text('Add money'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              'Recent transactions',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ObxValue(
                (me) => ListView.builder(
                    itemCount: me.value?.wallet.transactions.length ?? 1,
                    itemBuilder: (_, int index) {
                      if ((me.value?.wallet.transactions.length ?? 0) < 1) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Get.theme.cardColor,
                            child: Icon(
                              Icons.not_interested_rounded,
                              color: Get.theme.colorScheme.error,
                              size: 30,
                            ),
                          ),
                          title: const Text('No transaction records.'),
                        );
                      }

                      TransactionModel trx =
                          me.value!.wallet.transactions[index];

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Get.theme.cardColor,
                          child: Icon(
                            Icons.directions_bike_rounded,
                            color: Get.theme.colorScheme.primary,
                            size: 30,
                          ),
                        ),
                        title: Text(trx.transactionNarration),
                        subtitle: Text(trx.transactionCreatedAt),
                        trailing: Text(
                            '${trx.transactionType == 'debit' ? '-' : '+'}${trx.transactionAmount}',
                            style:
                                Get.theme.primaryTextTheme.labelLarge!.copyWith(
                              color: trx.transactionType == 'debit'
                                  ? Get.theme.colorScheme.error
                                  : Get.theme.colorScheme.primary,
                            )),
                      );
                    }),
                controller.app.me),
          )

          // ListTile(
          //   leading: CircleAvatar(
          //     radius: 25,
          //     backgroundColor: Get.theme.cardColor,
          //     child: Icon(
          //       Icons.directions_bike_rounded,
          //       color: Get.theme.colorScheme.primary,
          //       size: 30,
          //     ),
          //   ),
          //   title: Text('Paid for ride'),
          //   subtitle: Text('8 April 2024, 4:50 pm'),
          //   trailing: Text('-120.00',
          //       style: Get.theme.primaryTextTheme.labelLarge!.copyWith(
          //         color: Get.theme.colorScheme.error,
          //       )),
          // ),
          // ListTile(
          //   leading: CircleAvatar(
          //     radius: 25,
          //     backgroundColor: Get.theme.cardColor,
          //     child: Icon(
          //       Icons.lock,
          //       color: Get.theme.colorScheme.primary,
          //       size: 30,
          //     ),
          //   ),
          //   title: Text('Security deposit'),
          //   subtitle: Text('8 April 2024, 6:50 pm'),
          //   trailing: Text('500.00',
          //       style: Get.theme.primaryTextTheme.labelLarge!.copyWith(
          //         color: Get.theme.colorScheme.scrim,
          //       )),
          // ),
          // ListTile(
          //   leading: CircleAvatar(
          //     radius: 25,
          //     backgroundColor: Get.theme.cardColor,
          //     child: Icon(
          //       Icons.directions_bike_rounded,
          //       color: Get.theme.colorScheme.primary,
          //       size: 30,
          //     ),
          //   ),
          //   title: Text('Paid for ride'),
          //   subtitle: Text('9 April 2024, 4:50 pm'),
          //   trailing: Text('-130.00',
          //       style: Get.theme.primaryTextTheme.labelLarge!.copyWith(
          //         color: Get.theme.colorScheme.error,
          //       )),
          // ),
        ],
      ),
    );
  }
}
