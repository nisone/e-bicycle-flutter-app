import 'package:bike_rental/app/models/notification_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum NotificaionType { ride, wallet, security }

class NotificationListItemView extends GetView {
  const NotificationListItemView({required this.notification, super.key});
  final NotificationModel notification;

  final Map<String, Map<String, dynamic>> iconData = const {
    'ride': {'bgColor': Colors.red, 'icon': Icons.directions_bike_rounded},
    'wallet': {'bgColor': Colors.green, 'icon': Icons.account_balance_wallet},
    'security': {'bgColor': Colors.blue, 'icon': Icons.lock_outline_rounded},
  };
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: iconData[notification.notificationType]?['bgColor'],
        child: Icon(
          iconData[notification.notificationType]?['icon'],
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(notification.notificationTitle),
      subtitle: Text(
          '${notification.notificationBody}\n${notification.notificationCreatedAt}'),
      // trailing: Text('500.00',
      //     style: Get.theme.primaryTextTheme.labelLarge!.copyWith(
      //       color: Get.theme.colorScheme.scrim,
      //     )),
    );
  }
}
