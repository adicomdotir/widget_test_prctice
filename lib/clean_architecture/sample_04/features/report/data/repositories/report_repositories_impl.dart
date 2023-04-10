import 'package:widget_test_practice/clean_architecture/sample_04/features/report/data/data_soruces/report_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/domain/repositories/report_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/data/models/report_model.dart';

class ReportRepositoryImpl extends ReportRepository {
  final ReportDataSource reportDataSource;

  ReportRepositoryImpl({required this.reportDataSource});

  @override
  Future<List<ReportModel>> getReport() {
    return reportDataSource.getReport();
  }
}
