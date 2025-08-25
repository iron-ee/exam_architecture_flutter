import 'package:equatable/equatable.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';

abstract class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object?> get props => [];
}

class FlightInitial extends FlightState {}

class FlightLoading extends FlightState {}

class FlightLoaded extends FlightState {
  final List<FlightEntity> flights;

  const FlightLoaded({required this.flights});

  @override
  List<Object?> get props => [flights];
}

class FlightError extends FlightState {
  final String message;

  const FlightError({required this.message});

  @override
  List<Object?> get props => [message];
}
