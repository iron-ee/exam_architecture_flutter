import 'package:equatable/equatable.dart';

class FlightResponseModel extends Equatable {
  final ResponseModel? response;

  const FlightResponseModel({this.response});

  factory FlightResponseModel.fromJson(Map<String, dynamic> json) {
    return FlightResponseModel(
      response:
          json['response'] != null
              ? ResponseModel.fromJson(json['response'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'response': response?.toJson()};
  }

  @override
  List<Object?> get props => [response];
}

class ResponseModel extends Equatable {
  final FlightHeaderModel? header;
  final FlightBodyModel? body;

  const ResponseModel({this.header, this.body});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      header:
          json['header'] != null
              ? FlightHeaderModel.fromJson(json['header'])
              : null,
      body:
          json['body'] != null ? FlightBodyModel.fromJson(json['body']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'header': header?.toJson(), 'body': body?.toJson()};
  }

  @override
  List<Object?> get props => [header, body];
}

class FlightHeaderModel extends Equatable {
  final String? resultCode;
  final String? resultMsg;

  const FlightHeaderModel({this.resultCode, this.resultMsg});

  factory FlightHeaderModel.fromJson(Map<String, dynamic> json) {
    return FlightHeaderModel(
      resultCode: json['resultCode'] as String?,
      resultMsg: json['resultMsg'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'resultCode': resultCode, 'resultMsg': resultMsg};
  }

  @override
  List<Object?> get props => [resultCode, resultMsg];
}

class FlightBodyModel extends Equatable {
  final List<FlightItemModel>? flights;

  const FlightBodyModel({this.flights});

  factory FlightBodyModel.fromJson(Map<String, dynamic> json) {
    final dynamic itemsJson = json['items'];
    if (itemsJson is Map<String, dynamic> && itemsJson.containsKey('item')) {
      final item = itemsJson['item'];
      if (item is List) {
        return FlightBodyModel(
          flights: item.map((e) => FlightItemModel.fromJson(e)).toList(),
        );
      } else {
        return FlightBodyModel(flights: [FlightItemModel.fromJson(item)]);
      }
    }
    final List<dynamic>? itemsList = json['items'];
    return FlightBodyModel(
      flights: itemsList?.map((e) => FlightItemModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': flights?.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [flights];
}

class FlightItemModel extends Equatable {
  final String? typeOfFlight;
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
  final String? terminalId;
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

  const FlightItemModel({
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

  factory FlightItemModel.fromJson(Map<String, dynamic> json) {
    return FlightItemModel(
      typeOfFlight: json['typeOfFlight'] as String?,
      airline: json['airline'] as String?,
      flightId: json['flightId'] as String?,
      scheduleDateTime: json['scheduleDateTime'] as String?,
      estimatedDateTime: json['estimatedDateTime'] as String?,
      airport: json['airport'] as String?,
      chkinrange: json['chkinrange'] as String?,
      gatenumber: json['gatenumber'] as String?,
      remark: json['remark'] as String?,
      codeshare: json['codeshare'] as String?,
      masterflightid: json['masterflightid'] as String?,
      airportCode: json['airportCode'] as String?,
      cityCode: json['cityCode'] as String?,
      terminalId: json['terminalId'] as String?,
      elapsetime: json['elapsetime'] as String?,
      firstopover: json['firstopover'] as String?,
      firstopovername: json['firstopovername'] as String?,
      secstopover: json['secstopover'] as String?,
      secstopovername: json['secstopovername'] as String?,
      thistopover: json['thistopover'] as String?,
      thistopovername: json['thistopovername'] as String?,
      foustopover: json['foustopover'] as String?,
      foustopovername: json['foustopovername'] as String?,
      fifstopover: json['fifstopover'] as String?,
      fifstopovername: json['fifstopovername'] as String?,
      sixstopover: json['sixstopover'] as String?,
      sixstopovername: json['sixstopovername'] as String?,
      sevstopover: json['sevstopover'] as String?,
      sevstopovername: json['sevstopovername'] as String?,
      eigstopover: json['eigstopover'] as String?,
      eigstopovername: json['eigstopovername'] as String?,
      ninstopover: json['ninstopover'] as String?,
      ninstopovername: json['ninstopovername'] as String?,
      tenstopover: json['tenstopover'] as String?,
      tenstopovername: json['tenstopovername'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeOfFlight': typeOfFlight,
      'airline': airline,
      'flightId': flightId,
      'scheduleDateTime': scheduleDateTime,
      'estimatedDateTime': estimatedDateTime,
      'airport': airport,
      'chkinrange': chkinrange,
      'gatenumber': gatenumber,
      'remark': remark,
      'codeshare': codeshare,
      'masterflightid': masterflightid,
      'airportCode': airportCode,
      'cityCode': cityCode,
      'terminalId': terminalId,
      'elapsetime': elapsetime,
      'firstopover': firstopover,
      'firstopovername': firstopovername,
      'secstopover': secstopover,
      'secstopovername': secstopovername,
      'thistopover': thistopover,
      'thistopovername': thistopovername,
      'foustopover': foustopover,
      'foustopovername': foustopovername,
      'fifstopover': fifstopover,
      'fifstopovername': fifstopovername,
      'sixstopover': sixstopover,
      'sixstopovername': sixstopovername,
      'sevstopover': sevstopover,
      'sevstopovername': sevstopovername,
      'eigstopover': eigstopover,
      'eigstopovername': eigstopovername,
      'ninstopover': ninstopover,
      'ninstopovername': ninstopovername,
      'tenstopover': tenstopover,
      'tenstopovername': tenstopovername,
    };
  }

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
