class NotificationModel {
  String? title;
  String? message;
  String? date;
  bool? isChecked;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    this.isChecked
  });

  static List<NotificationModel> myNotifications = [
    NotificationModel(title: 'Bulk Goods Recieved', message: 'We have successfully delivered your good to your premisess', date: '3rd-May 2022'),
    NotificationModel(title: 'Order Successfully Received', message: 'Your Order #1327EG78 is being transacted', date: '25th-August 2021'),
    NotificationModel(title: 'Account Verification', message: 'Your Wena account has been verified successfully', date: '1st-December 2019'),

  ];


}