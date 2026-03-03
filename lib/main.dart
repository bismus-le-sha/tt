import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tt/data/api/order_api.dart';
import 'package:tt/data/repository/order_repository_impl.dart';
import 'package:tt/presentation/controller/order_controller.dart';
import 'package:tt/presentation/di/order_scope.dart';
import 'package:tt/presentation/widget/create_order_screen.dart';

void main() {
  final client = http.Client();
  final api = OrderApi(client: client);
  final repository = OrderRepositoryImpl(api: api);
  final controller = OrderController(repository: repository);

  runApp(MainApp(controller: controller));
}

class MainApp extends StatelessWidget {
  final OrderController controller;

  const MainApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderScope(
        controller: controller,
        child: const CreateOrderScreen(),
      ),
    );
  }
}
