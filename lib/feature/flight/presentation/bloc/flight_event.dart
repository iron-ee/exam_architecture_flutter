import 'package:equatable/equatable.dart';

abstract class FlightEvent extends Equatable {
  const FlightEvent();
}

// 항공편 리스트를 가져오는 이벤트
class GetFlightDeparturesEvent extends FlightEvent {
  final String? fromTime;
  final String? toTime;
  final String? airport;
  final String? flightId;
  final String? airline;
  final String? lang;

  const GetFlightDeparturesEvent({
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
