import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

class ReportEntity {
  final String category;
  final double amount;

  ReportEntity({
    required this.category,
    required this.amount,
  });

  ReportModel toModel() {
    return ReportModel(
      category: category,
      amount: amount,
    );
  }
}
