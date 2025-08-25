import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_bloc.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/screen/flight_detail_screen.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/screen/flight_list_screen.dart';
import 'package:exam_architecture_iron/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final flightRoutes = [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        // 의존성 주입된 BLoC을 제공
        create: (_) => sl<FlightBloc>(),
        child: const FlightListScreen(),
      );
    },
    routes: [
      GoRoute(
        path: 'detail',
        name: 'flight_detail',
        builder: (BuildContext context, GoRouterState state) {
          final flight = state.extra as FlightEntity;
          return FlightDetailScreen(flight: flight);
        },
      ),
    ],
  ),
];
