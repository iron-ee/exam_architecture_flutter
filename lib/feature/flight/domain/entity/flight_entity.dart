import 'package:equatable/equatable.dart';
import 'package:exam_architecture_iron/feature/flight/domain/enum/flight_enums.dart';

class FlightEntity extends Equatable {
  final TypeOfFlight? typeOfFlight;
  final String? airline;
  final String? flightId;
  final String? scheduleDateTime;
  final String? estimatedDateTime;
  final String? airport;
  final String? chkinrange;
  final String? gatenumber;
  final String? remark;
  final String? codeshare;
  final String? masterflightid;
  final String? airportCode;
  final String? cityCode;
  final TerminalId? terminalId;
  final String? elapsetime;
  final String? firstopover;
  final String? firstopovername;
  final String? secstopover;
  final String? secstopovername;
  final String? thistopover;
  final String? thistopovername;
  final String? foustopover;
  final String? foustopovername;
  final String? fifstopover;
  final String? fifstopovername;
  final String? sixstopover;
  final String? sixstopovername;
  final String? sevstopover;
  final String? sevstopovername;
  final String? eigstopover;
  final String? eigstopovername;
  final String? ninstopover;
  final String? ninstopovername;
  final String? tenstopover;
  final String? tenstopovername;

  const FlightEntity({
    this.typeOfFlight,
    this.airline,
    this.flightId,
    this.scheduleDateTime,
    this.estimatedDateTime,
    this.airport,
    this.chkinrange,
    this.gatenumber,
    this.remark,
    this.codeshare,
    this.masterflightid,
    this.airportCode,
    this.cityCode,
    this.terminalId,
    this.elapsetime,
    this.firstopover,
    this.firstopovername,
    this.secstopover,
    this.secstopovername,
    this.thistopover,
    this.thistopovername,
    this.foustopover,
    this.foustopovername,
    this.fifstopover,
    this.fifstopovername,
    this.sixstopover,
    this.sixstopovername,
    this.sevstopover,
    this.sevstopovername,
    this.eigstopover,
    this.eigstopovername,
    this.ninstopover,
    this.ninstopovername,
    this.tenstopover,
    this.tenstopovername,
  });

  @override
  List<Object?> get props => [
    typeOfFlight,
    airline,
    flightId,
    scheduleDateTime,
    estimatedDateTime,
    airport,
    chkinrange,
    gatenumber,
    remark,
    codeshare,
    masterflightid,
    airportCode,
    cityCode,
    terminalId,
    elapsetime,
    firstopover,
    firstopovername,
    secstopover,
    secstopovername,
    thistopover,
    thistopovername,
    foustopover,
    foustopovername,
    fifstopover,
    fifstopovername,
    sixstopover,
    sixstopovername,
    sevstopover,
    sevstopovername,
    eigstopover,
    eigstopovername,
    ninstopover,
    ninstopovername,
    tenstopover,
    tenstopovername,
  ];
}
