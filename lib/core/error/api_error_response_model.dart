import 'package:equatable/equatable.dart';

// 공통 에러 모델 (xml)
class ApiErrorResponseModel extends Equatable {
  final OpenApiServiceResponse? openApiServiceResponse;

  const ApiErrorResponseModel({this.openApiServiceResponse});

  factory ApiErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponseModel(
      openApiServiceResponse:
          json['OpenAPI_ServiceResponse'] != null
              ? OpenApiServiceResponse.fromJson(json['OpenAPI_ServiceResponse'])
              : null,
    );
  }

  @override
  List<Object?> get props => [openApiServiceResponse];
}

class OpenApiServiceResponse extends Equatable {
  final CmmMsgHeader? cmmMsgHeader;

  const OpenApiServiceResponse({this.cmmMsgHeader});

  factory OpenApiServiceResponse.fromJson(Map<String, dynamic> json) {
    return OpenApiServiceResponse(
      cmmMsgHeader:
          json['cmmMsgHeader'] != null
              ? CmmMsgHeader.fromJson(json['cmmMsgHeader'])
              : null,
    );
  }

  @override
  List<Object?> get props => [cmmMsgHeader];
}

class CmmMsgHeader extends Equatable {
  final String? errMsg;
  final String? returnAuthMsg;
  final String? returnReasonCode;

  const CmmMsgHeader({this.errMsg, this.returnAuthMsg, this.returnReasonCode});

  factory CmmMsgHeader.fromJson(Map<String, dynamic> json) {
    return CmmMsgHeader(
      errMsg:
          json['errMsg'] != null
              ? (json['errMsg'] as Map<String, dynamic>)['\$']
              : null,
      returnAuthMsg:
          json['returnAuthMsg'] != null
              ? (json['returnAuthMsg'] as Map<String, dynamic>)['\$']
              : null,
      returnReasonCode:
          json['returnReasonCode'] != null
              ? (json['returnReasonCode'] as Map<String, dynamic>)['\$']
              : null,
    );
  }

  @override
  List<Object?> get props => [errMsg, returnAuthMsg, returnReasonCode];
}
