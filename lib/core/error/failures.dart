import 'package:equatable/equatable.dart';

// 공통 에러 관리 추상 클래스
abstract class Failure extends Equatable {
  final String? message;
  const Failure([this.message]);

  @override
  List<Object?> get props => [message];
}

// 어플리케이션 에러
class ApplicationFailure extends Failure {
  const ApplicationFailure({String? message}) : super(message);
}

// http 에러
class HttpFailure extends Failure {
  const HttpFailure({String? message}) : super(message);
}

// 서비스 접근 거부
class ServiceAccessDeniedFailure extends Failure {
  const ServiceAccessDeniedFailure({String? message}) : super(message);
}

// 등록되지 않은 서비스 키
class ServiceKeyNotRegisteredFailure extends Failure {
  const ServiceKeyNotRegisteredFailure({String? message}) : super(message);
}

// 기타에러 혹은 알 수 없는 에러
class UnknownFailure extends Failure {
  const UnknownFailure({String? message}) : super(message);
}

// 네트워크 에러
class NetworkFailure extends Failure {
  const NetworkFailure({String? message}) : super(message);
}
