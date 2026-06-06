class NotificationModel {
  final int notificationId;
  final String title;
  final String message;
  final String type;
  final String? referenceId;
  final DateTime createdAt;
  final bool isRead;
  final String? senderName;
  final String? senderProfilePicture;

  const NotificationModel({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.type,
    this.referenceId,
    required this.createdAt,
    required this.isRead,
    this.senderName,
    this.senderProfilePicture,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] ?? json['NotificationId'] ?? json['id'] ?? json['Id'] ?? 0,
      title:         json['title']         ?? json['Title']         ?? '',
      message:       json['message']       ?? json['Message']       ?? json['body'] ?? json['Body'] ?? '',
      type:          json['type']          ?? json['Type']          ?? '',
      referenceId:   (json['referenceId']  ?? json['ReferenceId']  ?? json['tripId'] ?? json['TripId'])?.toString(),
      createdAt:     (DateTime.tryParse((json['createdAt'] ?? json['CreatedAt'] ?? json['created_at'] ?? '').toString())?.toLocal()) ?? DateTime.now(),
      isRead:        json['isRead']        ?? json['IsRead']        ?? json['is_read'] ?? false,
      senderName:          (json['senderName']         ?? json['SenderName'])?.toString(),
      senderProfilePicture:(json['senderProfilePicture']?? json['SenderProfilePicture'] ?? json['profilePicture'])?.toString(),
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      notificationId: notificationId,
      title: title,
      message: message,
      type: type,
      referenceId: referenceId,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      senderName: senderName,
      senderProfilePicture: senderProfilePicture,
    );
  }
}
