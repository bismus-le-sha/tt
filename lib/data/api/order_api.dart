import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tt/config/exception/api_exception.dart';
import 'package:tt/data/model/order_model.dart';
import 'package:tt/domain/entity/order.dart';

class OrderApi {
  static const _baseUrl = 'https://fakestoreapi.com';
  static const _timeout = Duration(seconds: 10);

  final http.Client _client;

  OrderApi({required http.Client client}) : _client = client;

  Future<Order> createOrder() async {
    final uri = Uri.parse('$_baseUrl/carts');

    try {
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'userId': 1,
              'date': DateTime.now().toIso8601String(),
              'products': [
                {'productId': 1, 'quantity': 1},
              ],
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return OrderModel.fromJson(json);
      }

      throw ApiException.server(
        statusCode: response.statusCode,
        body: response.body,
      );
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException.timeout();
    } on SocketException catch (e) {
      throw ApiException.network(message: e.message);
    }
  }
}
