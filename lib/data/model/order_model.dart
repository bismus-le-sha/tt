import 'package:tt/domain/entity/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'].toString(),
      status: (json['status'] as String?) ?? 'created',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }

  OrderModel copyWith({
    String? id,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }
}
