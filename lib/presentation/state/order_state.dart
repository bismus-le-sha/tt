import 'package:tt/domain/entity/order.dart';

sealed class OrderState {
  const OrderState();
}

final class OrderInitial extends OrderState {
  const OrderInitial();
}

final class OrderLoading extends OrderState {
  const OrderLoading();
}

final class OrderSuccess extends OrderState {
  final Order order;

  const OrderSuccess({required this.order});
}

final class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});
}
