import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/views/views/notification_list_item_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NotificationPageView extends GetView {
  const NotificationPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final AppController app = Get.find<AppController>();
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Center(
            child: Text(
              'Notifications',
              style: Get.theme.textTheme.displaySmall,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              'New notifications',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ObxValue(
                (me) => ListView.builder(
                    itemCount: me.value?.notifications.length ?? 1,
                    itemBuilder: (_, int index) {
                      if ((app.me.value?.notifications.length ?? 0) < 1) {
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
                          title: const Text('No new notification records.'),
                        );
                      }
                      return NotificationListItemView(
                          notification: me.value!.notifications[index]);
                      // int i = Random().nextInt(2);
                      // return [
                      //   NotificationListItemView(
                      //     notification: NotificationModel(
                      //         notificationId: 1,
                      //         notificationTitle: 'Ride ended',
                      //         notificationBody:
                      //             'You successfully parked Bk2564 at city rider zone.',
                      //         notificationType: 'ride',
                      //         notificationIsOpened: false,
                      //         notificationCreatedAt: '6 minutes ago',
                      //         notificationUpdatedAt: '6 minutes ago'),
                      //   ),
                      //   NotificationListItemView(
                      //     notification: NotificationModel(
                      //         notificationId: 1,
                      //         notificationTitle: 'Security deposit',
                      //         notificationBody:
                      //             'Your security deposits amount 50.00 successfully paid.',
                      //         notificationType: 'security',
                      //         notificationIsOpened: false,
                      //         notificationCreatedAt: '2 min ago',
                      //         notificationUpdatedAt: '2 min ago'),
                      //   ),
                      //   NotificationListItemView(
                      //     notification: NotificationModel(
                      //         notificationId: 1,
                      //         notificationTitle: 'Deposit',
                      //         notificationBody:
                      //             'Your deposits amount 50.00 successfully added in your wallet.',
                      //         notificationType: 'wallet',
                      //         notificationIsOpened: false,
                      //         notificationCreatedAt: '2 min ago',
                      //         notificationUpdatedAt: '2 min ago'),
                      //   ),
                      // ][i];
                    }),
                app.me),
          ),
        ],
      ),
    );
  }
}
