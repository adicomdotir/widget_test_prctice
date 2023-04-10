import 'package:widget_test_practice/clean_architecture/sample_04/features/report/domain/repositories/report_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

class GetReportUseCase {
  final ReportRepository reportRepository;

  GetReportUseCase({required this.reportRepository});

  Future<List<ReportEntity>> call() {
    return reportRepository.getReport();
  }
}
