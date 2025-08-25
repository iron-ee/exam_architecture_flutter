import 'package:exam_architecture_iron/core/error/failures.dart';

class FailureToMessageMapper {
  static String mapFailureToMessage(Failure failure) {
    if (failure is ServiceKeyNotRegisteredFailure) {
      return '등록되지 않은 서비스키입니다.';
    } else if (failure is ServiceAccessDeniedFailure) {
      return '서비스 접근이 거부되었습니다.';
    } else if (failure is ApplicationFailure) {
      return '어플리케이션 에러가 발생했습니다.';
    } else if (failure is HttpFailure) {
      return 'HTTP 에러가 발생했습니다.';
    } else if (failure is UnknownFailure) {
      return failure.message ?? '알 수 없는 에러가 발생했습니다.';
    }
    return '알 수 없는 에러가 발생했습니다.';
  }
}
