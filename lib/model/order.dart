import 'package:radius_v3/model/resturant.dart';

class Order {
  final int orderID;
  final Resturant restuarante;
  final int status;

  Order({
    this.restuarante,
    this.orderID,
    this.status,
  });
}
