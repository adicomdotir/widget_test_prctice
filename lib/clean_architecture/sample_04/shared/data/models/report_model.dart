import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  ReportModel({
    required String category,
    required double amount,
    required int count,
  }) : super(category: category, amount: amount, count: count);

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'count': count,
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        category: json['category'],
        amount: json['amount'],
        count: json['count'],
      );
}
