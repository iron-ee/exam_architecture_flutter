import 'package:dartz/dartz.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';

abstract class FlightRepository {
  Future<Either<Failure, List<FlightEntity>>> getFlightDepartures({
    String? fromTime,
    String? toTime,
    String? airport,
    String? flightId,
    String? airline,
    String? lang,
  });
}
