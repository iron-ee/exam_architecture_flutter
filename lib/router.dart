// GoRouter 인스턴스 생성 및 라우터 설정
import 'package:exam_architecture_iron/feature/flight/flight_router.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [...flightRoutes],
);
