import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';
import 'package:exam_architecture_iron/core/usecase/usecase.dart';
import 'package:exam_architecture_iron/feature/flight/data/repository/flight_repository.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';

class GetFlightDeparturesUseCase
    implements UseCase<List<FlightEntity>, FlightParams> {
  final FlightRepository repository;

  GetFlightDeparturesUseCase(this.repository);

  @override
  Future<Either<Failure, List<FlightEntity>>> call(FlightParams params) async {
    return await repository.getFlightDepartures(
      fromTime: params.fromTime,
      toTime: params.toTime,
      airport: params.airport,
      flightId: params.flightId,
      airline: params.airline,
      lang: params.lang,
    );
  }
}

// usecase에 전달할 파라미터
class FlightParams extends Equatable {
  final String? fromTime;
  final String? toTime;
  final String? airport;
  final String? flightId;
  final String? airline;
  final String? lang;

  const FlightParams({
    this.fromTime,
    this.toTime,
    this.airport,
    this.flightId,
    this.airline,
    this.lang,
  });

  @override
  List<Object?> get props => [
    fromTime,
    toTime,
    airport,
    flightId,
    airline,
    lang,
  ];
}
