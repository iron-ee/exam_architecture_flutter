import 'package:exam_architecture_iron/core/error/failure_to_message_mapper.dart';
import 'package:exam_architecture_iron/feature/flight/domain/usecase/get_flight_departures_usecase.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_event.dart';
import 'package:exam_architecture_iron/feature/flight/presentation/bloc/flight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final GetFlightDeparturesUseCase getFlightDeparturesUseCase;

  FlightBloc({required this.getFlightDeparturesUseCase})
    : super(FlightInitial()) {
    on<GetFlightDeparturesEvent>(_onGetFlightDepartures);
  }

  Future<void> _onGetFlightDepartures(
    GetFlightDeparturesEvent event,
    Emitter<FlightState> emit,
  ) async {
    emit(FlightLoading());

    final result = await getFlightDeparturesUseCase(
      FlightParams(
        fromTime: event.fromTime,
        toTime: event.toTime,
        airport: event.airport,
        flightId: event.flightId,
        airline: event.airline,
        lang: event.lang,
      ),
    );

    // Either의 fold 메소드를 사용해 성공/실패 로직을 분기
    result.fold(
      (failure) {
        // 실패 시 Error 상태를 발행
        emit(
          FlightError(
            message: FailureToMessageMapper.mapFailureToMessage(failure),
          ),
        );
      },
      (flights) {
        // 성공 시 Loaded 상태를 발행
        emit(FlightLoaded(flights: flights));
      },
    );
  }
}
