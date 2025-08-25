import 'package:exam_architecture_iron/feature/flight/data/model/flight_response_model.dart';
import 'package:exam_architecture_iron/feature/flight/domain/entity/flight_entity.dart';
import 'package:exam_architecture_iron/feature/flight/domain/enum/flight_enums.dart';

class FlightMapper {
  // FlightItemModel 리스트를 FlightEntity 리스트로 변환
  static List<FlightEntity> toEntityList(List<FlightItemModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  // FlightItemModel을 FlightEntity로 변환
  static FlightEntity toEntity(FlightItemModel model) {
    return FlightEntity(
      typeOfFlight: TypeOfFlight.fromString(model.typeOfFlight),
      airline: model.airline,
      flightId: model.flightId,
      scheduleDateTime: model.scheduleDateTime,
      estimatedDateTime: model.estimatedDateTime,
      airport: model.airport,
      chkinrange: model.chkinrange,
      gatenumber: model.gatenumber,
      remark: model.remark,
      codeshare: model.codeshare,
      masterflightid: model.masterflightid,
      airportCode: model.airportCode,
      cityCode: model.cityCode,
      terminalId: TerminalId.fromString(model.terminalId),
      elapsetime: model.elapsetime,
      firstopover: model.firstopover,
      firstopovername: model.firstopovername,
      secstopover: model.secstopover,
      secstopovername: model.secstopovername,
      thistopover: model.thistopover,
      thistopovername: model.thistopovername,
      foustopover: model.foustopover,
      foustopovername: model.foustopovername,
      fifstopover: model.fifstopover,
      fifstopovername: model.fifstopovername,
      sixstopover: model.sixstopover,
      sixstopovername: model.sixstopovername,
      sevstopover: model.sevstopover,
      sevstopovername: model.sevstopovername,
      eigstopover: model.eigstopover,
      eigstopovername: model.eigstopovername,
      ninstopover: model.ninstopover,
      ninstopovername: model.ninstopovername,
      tenstopover: model.tenstopover,
      tenstopovername: model.tenstopovername,
    );
  }
}
