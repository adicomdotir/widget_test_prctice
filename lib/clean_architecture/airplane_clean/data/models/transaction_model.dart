import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/destination_model.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/data/models/user_model.dart';
import 'package:widget_test_practice/clean_architecture/airplane_clean/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  final String id;
  final UserModel user;
  final DestinationModel destination;
  final int amountOfTravelers;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vit;
  final int price;
  final int grandTotal;
  final int createdAt;

  const TransactionModel({
    required this.id,
    required this.user,
    required this.destination,
    required this.amountOfTravelers,
    required this.selectedSeats,
    required this.insurance,
    required this.refundable,
    required this.vit,
    required this.price,
    required this.grandTotal,
    required this.createdAt,
  }) : super();

  factory TransactionModel.fromJson(String id, Map<String, dynamic> jsonMap) {
    return TransactionModel(
      id: id,
      user: UserModel.fromJson(jsonMap['user']['id'], jsonMap['user']),
      destination: DestinationModel.fromJson(
        jsonMap['destination']['id'],
        jsonMap['destination'],
      ),
      amountOfTravelers: jsonMap['amountOfTravelers'] ?? '',
      selectedSeats: jsonMap['selectedSeats'] ?? '',
      insurance: jsonMap['insurance'] ?? '',
      refundable: jsonMap['refundable'] ?? '',
      vit: jsonMap['vit'] ?? '',
      price: jsonMap['price'] ?? '',
      grandTotal: jsonMap['grandTotal'] ?? '',
      createdAt: jsonMap['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'destination': destination.toJson(),
      'amountOfTravelers': amountOfTravelers,
      'selectedSeats': selectedSeats,
      'insurance': insurance,
      'refundable': refundable,
      'vit': vit,
      'price': price,
      'grandTotal': grandTotal,
      'createdAt': createdAt,
    };
  }
}
