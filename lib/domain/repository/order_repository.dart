import 'package:tt/domain/entity/order.dart';

abstract interface class OrderRepository {
  Future<Order> createOrder();
}
