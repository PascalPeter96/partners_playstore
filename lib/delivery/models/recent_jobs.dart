import 'package:wena_partners/delivery/models/product.dart';

class RecentJobs{
  final String name;
  final String orderId;
  final DateTime date;
  final String time;
  final String phone;
  final String location;
  final String status;
  final String deliveryStatus;
  List<Product> product;
  double latitude;
  double longitude;

  RecentJobs({required this.name, required this.orderId, required this.date, required this.time, required this.phone, required this.location, required this.status, required this.deliveryStatus, required this.product,
    required this.latitude,
    required this.longitude,
  });

  static final List<RecentJobs> recentJobs = [
    RecentJobs(name: 'Aine Owomukama', orderId: 'DFD32432', date: DateTime(2022,2,13), time: '8:40am', phone: '0783256183', location: 'Namugongo', status: 'paid', deliveryStatus: 'COMPLETED',
      product: [
        Product(
          id: 1,
          productName: 'Hima Cement',
          productPrice: 15000,
          quantity: 1,
        ),
        Product(
          id: 2,
          productName: 'Electric Drill' ,
          productPrice: 3000,
          quantity: 1,

        ),
      ],
        latitude: 0.06629887652563086,
        longitude: 32.47620022592871
    ),
    RecentJobs(name: 'Young Vangelist', orderId: 'CFG37295', date: DateTime(2022,2,26), time: '10:00pm', phone: '0705672351', location: 'Kampala', status: 'unpaid', deliveryStatus: 'PENDING',
      product: [
        Product(
          id: 3,
          productName: 'Magic Spin Mop',
          productPrice: 1000,
          quantity: 1,

        ),
        Product(
          id: 4,
          productName: 'Tree Art Home Decor' ,
          productPrice: 20000,
          quantity: 1,

        ),
      ],
      latitude: 0.3583981297740143,
      longitude: 32.75091297112896,
    ),
    RecentJobs(name: 'Okot Lyeng', orderId: 'JKR99472', date: DateTime(2022,3,18), time: '7:30pm', phone: '0756782416', location: 'Entebbe', status: 'paid', deliveryStatus: 'CANCELED',
      product: [
        Product(
          id: 5,
          productName: 'Stock Lock Miter',
          productPrice: 3900,
          quantity: 1,

        ),
        Product(
          id: 6,
          productName: 'Double Pavers',
          productPrice: 20000,
          quantity: 1,

        ),
      ],
        latitude: 0.31730390186900465,
        longitude: 32.59269966825703
    ),
    RecentJobs(name: 'Bbosa Meddy', orderId: 'LLR67218', date: DateTime(2022,5,1), time: '2:40pm', phone: '0783997261', location: 'Lira', status: 'paid', deliveryStatus: 'COMPLETED',
      product: [
        Product(
          id: 7,
          productName: 'HD Security Camera',
          productPrice: 10000,
          quantity: 1,

        ),
        Product(
          id: 8,
          productName: 'Seastar Pavers',
          productPrice: 16000,
          quantity: 1,

        )
      ],
      latitude: 0.36453950072969676,
      longitude: 32.66466958360069,
    ),
    RecentJobs(name: 'Joy Boy', orderId: 'YYE19005', date: DateTime(2022,6,30), time: '1:40am', phone: '0741783726', location: 'Masaka', status: 'unpaid', deliveryStatus: 'PENDING',
      product: [
        Product(
          id: 4,
          productName: 'Tree Art Home Decor' ,
          productPrice: 20000,
          quantity: 1,

        ),
        Product(
          id: 5,
          productName: 'Stock Lock Miter',
          productPrice: 3900,
          quantity: 1,

        ),
      ],
        latitude: 0.31421583061291686,
        longitude: 32.61351173942106
    ),
  ];

}