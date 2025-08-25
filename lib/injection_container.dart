import 'package:dio/dio.dart';
import 'package:exam_architecture_iron/feature/flight/flight_injection_container.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());

  // Feature 별 의존성 등록
  // 새로운 기능이 추가될 때마다 여기에 새로운 init 함수를 추가합니다.
  initFlight();
}
