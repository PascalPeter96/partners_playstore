

class Product {
  int id;
  String? productName;
  int? productPrice;
  int? quantity;


  Product( {
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,

  });



  static  List<Product> products = [
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
  ];

}