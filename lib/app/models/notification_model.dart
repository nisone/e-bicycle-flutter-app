class NotificationModel {
  final int notificationId;
  final String notificationTitle;
  final String notificationBody;
  final String notificationType;
  bool notificationIsOpened;
  final String notificationCreatedAt;
  final String notificationUpdatedAt;
  NotificationModel({
    required this.notificationId,
    required this.notificationTitle,
    required this.notificationBody,
    required this.notificationType,
    required this.notificationIsOpened,
    required this.notificationCreatedAt,
    required this.notificationUpdatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      notificationId: data['notification_id'],
      notificationTitle: data['notification_title'],
      notificationBody: data['notification_body'],
      notificationType: data['notification_type'],
      notificationIsOpened: data['notification_is_opened'],
      notificationCreatedAt: data['notification_created_at'],
      notificationUpdatedAt: data['notification_updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "notification_id": 4,
      "notification_title": "Roger Rue",
      "notification_body": "Id nihil rerum atque.",
      "notification_type": "ride",
      "notification_is_opened": false,
      "notification_created_at": "15 seconds ago",
      "notification_updated_at": "15 seconds ago"
    };
  }
}
