import 'package:exam_architecture_iron/injection_container.dart' as di;
import 'package:exam_architecture_iron/router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // 의존성 주입 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Exam Architecture Irone',
      routerConfig: router,
    );
  }
}
