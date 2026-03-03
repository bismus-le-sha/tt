import 'package:flutter/widgets.dart';
import 'package:tt/presentation/controller/order_controller.dart';

class OrderScope extends InheritedNotifier<OrderController> {
  const OrderScope({
    super.key,
    required OrderController controller,
    required super.child,
  }) : super(notifier: controller);

  static OrderController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<OrderScope>();
    assert(scope != null, 'No OrderScope found in context');
    return scope!.notifier!;
  }
}
