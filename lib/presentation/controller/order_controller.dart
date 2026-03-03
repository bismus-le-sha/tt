import 'package:flutter/foundation.dart';
import 'package:tt/data/exception/api_exception.dart';
import 'package:tt/domain/repository/order_repository.dart';
import 'package:tt/presentation/state/order_state.dart';

class OrderController extends ValueNotifier<OrderState> {
  final OrderRepository _repository;

  OrderController({required OrderRepository repository})
      : _repository = repository,
        super(const OrderInitial());

  Future<void> createOrder() async {
    if (value is OrderLoading) return;

    value = const OrderLoading();

    try {
      final order = await _repository.createOrder();
      value = OrderSuccess(order: order);
    } on ApiException catch (e) {
      value = OrderError(message: _mapExceptionMessage(e));
    }
  }

  String _mapExceptionMessage(ApiException exception) {
    return switch (exception) {
      ServerApiException(:final statusCode) =>
        'Server error (code $statusCode). Please try again later.',
      NetworkApiException() =>
        'No internet connection. Check your network and retry.',
      TimeoutApiException() =>
        'Request timed out. Please try again.',
    };
  }
}
