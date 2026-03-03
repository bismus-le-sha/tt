import 'package:flutter/material.dart';
import 'package:tt/presentation/di/order_scope.dart';
import 'package:tt/presentation/state/order_state.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderScope.of(context);
    final state = controller.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Order')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: switch (state) {
            OrderInitial() => _buildInitial(controller),
            OrderLoading() => _buildLoading(),
            OrderSuccess(:final order) => _buildSuccess(order.id),
            OrderError(:final message) => _buildError(message, controller),
          },
        ),
      ),
    );
  }

  Widget _buildInitial(controller) {
    return ElevatedButton(
      onPressed: () => controller.createOrder(),
      child: const Text('Create Order'),
    );
  }

  Widget _buildLoading() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Creating order...'),
      ],
    );
  }

  Widget _buildSuccess(String orderId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        Text(
          'Order created successfully',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text('Order ID: $orderId'),
      ],
    );
  }

  Widget _buildError(String message, controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 64),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => controller.createOrder(),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
