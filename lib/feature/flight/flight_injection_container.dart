import 'package:exam_architecture_iron/feature/flight/data/api/flight_api_service.dart';
import 'package:exam_architecture_iron/feature/flight/data/repository/flight_repository.dart';
import 'package:exam_architecture_iron/feature/flight/data/repository/flight_repository_impl.dart';
import 'package:exam_architecture_iron/feature/flight/domain/usecase/get_flight_departures_usecase.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_bloc.dart';
import 'package:exam_architecture_iron/injection_container.dart';

void initFlight() {
  // Presentation - BLoC
  sl.registerFactory(() => FlightBloc(getFlightDeparturesUseCase: sl()));

  // Domain - UseCase
  sl.registerLazySingleton(() => GetFlightDeparturesUseCase(sl()));

  // Data - Repository
  sl.registerLazySingleton<FlightRepository>(() => FlightRepositoryImpl(sl()));

  // Data - API Service
  sl.registerLazySingleton(() => FlightApiService(sl()));
}
