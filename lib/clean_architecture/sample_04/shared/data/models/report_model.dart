import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  ReportModel({
    required String category,
    required double amount,
  }) : super(category: category, amount: amount);

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        category: json['category'],
        amount: json['amount'],
      );
}
