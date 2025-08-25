import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exam_architecture_iron/core/constants/api_constants.dart';
import 'package:exam_architecture_iron/core/error/api_error_handler.dart';
import 'package:exam_architecture_iron/core/error/api_error_response_model.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';
import 'package:exam_architecture_iron/feature/flight/data/model/flight_response_model.dart';
import 'package:xml2json/xml2json.dart';

class FlightApiInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final contentType = response.headers.value('Content-Type');
    final data = response.data.toString();

    // XML 타입 에러 처리
    if (contentType != null && contentType.contains('text/xml')) {
      final myTransformer = Xml2Json();
      myTransformer.parse(data);
      final jsonString = myTransformer.toBadgerfish();
      final errorModel = ApiErrorResponseModel.fromJson(
        json.decode(jsonString),
      );

      final resultCode =
          errorModel.openApiServiceResponse?.cmmMsgHeader?.returnReasonCode;
      final resultMsg =
          errorModel.openApiServiceResponse?.cmmMsgHeader?.returnAuthMsg;

      log('XML ERROR -> code: $resultCode, msg: $resultMsg');

      final failure = ApiErrorHandler.getFailureFromCode(resultCode, resultMsg);

      throw DioException(
        requestOptions: response.requestOptions,
        error: failure,
        response: response,
      );
    }

    // JSON 응답 처리
    final responseModel = FlightResponseModel.fromJson(response.data);
    final resultCode = responseModel.response?.header?.resultCode;
    final resultMsg = responseModel.response?.header?.resultMsg;

    if (resultCode != '00') {
      log('error resultCode: $resultCode');
      final failure = ApiErrorHandler.getFailureFromCode(resultCode, resultMsg);

      throw DioException(
        requestOptions: response.requestOptions,
        error: failure,
        response: response,
      );
    }

    return handler.next(response);
  }
}

// onError에서 API 키 재시도 로직 추가
class ApiKeyRetryInterceptor extends Interceptor {
  final Dio dio;
  bool isRetryAttempted = false;

  ApiKeyRetryInterceptor({required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 에러가 ServiceKeyNotRegisteredFailure이고, 아직 재시도하지 않았을 경우
    if (err.error is ServiceKeyNotRegisteredFailure && !isRetryAttempted) {
      log('Primary API key failed. Retrying with secondary key...');

      // 재시도 플래그를 true로 변경
      isRetryAttempted = true;

      try {
        final newOptions = err.requestOptions;

        // 두 번째 API 키로 변경
        newOptions.queryParameters['serviceKey'] = kServiceKey2;

        final response = await dio.request(
          newOptions.path,
          options: Options(
            method: newOptions.method,
            headers: newOptions.headers,
            responseType: newOptions.responseType,
          ),
          queryParameters: newOptions.queryParameters,
          data: newOptions.data,
        );

        // 재시도 성공 시, 원래의 흐름으로 복귀
        return handler.resolve(response);
      } on DioException catch (retryError) {
        // 재시도 실패 시, 최종 에러를 전달
        log('Secondary API key also failed.');
        return handler.next(retryError);
      }
    }
    // 재시도하지 않는 다른 에러는 그대로 다음 단계로 진행
    log(
      'HTTP ERROR[${err.response?.statusCode}] => ERROR: ${err.error}, MESSAGE: ${err.message}',
    );
    return handler.next(err);
  }
}
