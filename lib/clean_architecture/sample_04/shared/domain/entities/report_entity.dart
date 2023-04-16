import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

class ReportEntity {
  final String category;
  final double amount;
  final int count;

  ReportEntity({
    required this.category,
    required this.amount,
    required this.count,
  });

  ReportModel toModel() {
    return ReportModel(
      category: category,
      amount: amount,
      count: count,
    );
  }
}
