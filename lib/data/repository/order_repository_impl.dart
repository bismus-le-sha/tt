import 'package:tt/data/api/order_api.dart';
import 'package:tt/domain/entity/order.dart';
import 'package:tt/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _api;

  OrderRepositoryImpl({required OrderApi api}) : _api = api;

  @override
  Future<Order> createOrder() => _api.createOrder();
}
