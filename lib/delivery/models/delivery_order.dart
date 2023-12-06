class DeliveryOrder{
  final String name;
  final String orderId;
  final String date;
  final String time;
  final String phone;
  final String location;

  DeliveryOrder({required this.name, required this.orderId, required this.date, required this.time, required this.phone, required this.location});

  static final List<DeliveryOrder> orders = [
    DeliveryOrder(name: 'Aine Owomukama', orderId: 'DFD32432', date: '3 Jan 2022', time: '8:40am', phone: '0783256183', location: 'namugongo'),
    DeliveryOrder(name: 'Young Vangelist', orderId: 'CFG37295', date: '15 May 2022', time: '10:00pm', phone: '0705672351', location: ''),
    DeliveryOrder(name: 'Okot Lyeng', orderId: 'JKR99472', date: '26 June 2022', time: '7:30pm', phone: '0756782416', location: ''),
    DeliveryOrder(name: 'Bbosa Meddy', orderId: 'LLR67218', date: '1 Aug 2022', time: '2:40pm', phone: '0783997261', location: ''),
    DeliveryOrder(name: 'Joy Boy', orderId: 'YYE19005', date: '30 Dec 2022', time: '1:40am', phone: '0741783726', location: ''),
  ];

}