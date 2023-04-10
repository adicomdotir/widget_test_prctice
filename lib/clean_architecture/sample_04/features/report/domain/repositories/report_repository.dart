import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

abstract class ReportRepository {
  Future<List<ReportModel>> getReport();
}
