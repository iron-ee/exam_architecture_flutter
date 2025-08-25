import 'package:exam_architecture_iron/core/error/failures.dart';

// 에러 코드를 Failure 클래스로 매핑
class ApiErrorHandler {
  static Failure getFailureFromCode(String? resultCode, String? resultMsg) {
    switch (resultCode) {
      case '1':
        return ApplicationFailure(message: resultMsg);
      case '4':
        return HttpFailure(message: resultMsg);
      case '20':
        return ServiceAccessDeniedFailure(message: resultMsg);
      case '30':
        return ServiceKeyNotRegisteredFailure(message: resultMsg);
      default:
        return UnknownFailure(message: resultMsg);
    }
  }
}
