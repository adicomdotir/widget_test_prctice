import 'package:widget_test_practice/clean_architecture/sample_04/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

abstract class ReportDataSource {
  Future<List<ReportModel>> getReport();
}

class ReportDataSourceImpl extends ReportDataSource {
  final DatabaseHelper databaseHelper;

  ReportDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<ReportModel>> getReport() {
    return databaseHelper.getReport();
  }
}
