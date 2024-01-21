import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';

@freezed
class Result with _$Result {
  const Result._();
  const factory Result.loading() = _Loading;
  const factory Result.success(int value) = _Success;
  const factory Result.failure(String errorMsg) = _Failure;
}

void main(List<String> args) {
  const rc = Result.success(10);
  print(
    rc.when(
      success: (value) {
        return '$value';
      },
      failure: (errorMsg) {
        return errorMsg;
      },
      loading: () {
        return 'Loading';
      },
    ),
  );
  rc.maybeWhen(
    orElse: () {},
    failure: (errorMsg) {},
  );
}
