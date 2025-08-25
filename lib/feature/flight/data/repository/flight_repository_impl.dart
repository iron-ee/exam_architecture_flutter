import 'package:dartz/dartz.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';
import 'package:exam_architecture_iron/feature/flight/data/api/flight_api_service.dart';
import 'package:exam_architecture_iron/feature/flight/data/mapper/flight_mapper.dart';
import 'package:exam_architecture_iron/feature/flight/data/repository/flight_repository.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightApiService flightApiService;

  FlightRepositoryImpl(this.flightApiService);

  @override
  Future<Either<Failure, List<FlightEntity>>> getFlightDepartures({
    String? fromTime,
    String? toTime,
    String? airport,
    String? flightId,
    String? airline,
    String? lang,
  }) async {
    try {
      final response = await flightApiService.getPassengerDeparturesOdp(
        fromTime: fromTime,
        toTime: toTime,
        airport: airport,
        flightId: flightId,
        airline: airline,
        lang: lang,
      );

      final flights = response.response?.body?.flights;
      if (flights != null) {
        final entities = FlightMapper.toEntityList(flights);
        return Right(entities);
      } else {
        // flights가 null일 때 UnknownFailure로 처리
        return const Left(UnknownFailure(message: 'No flights found.'));
      }
    } on Failure catch (e) {
      // API 서비스에서 던진 Failure를 그대로 반환
      return Left(e);
    } catch (e) {
      // 예상치 못한 오류 발생 시 UnknownFailure로 처리
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
