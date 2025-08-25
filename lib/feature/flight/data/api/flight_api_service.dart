import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exam_architecture_iron/core/constants/api_constants.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';
import 'package:exam_architecture_iron/core/interceptor/api_interceptor.dart';
import 'package:exam_architecture_iron/feature/flight/data/model/flight_response_model.dart';

class FlightApiService {
  final Dio _dio;

  FlightApiService(this._dio) {
    _dio.options.baseUrl = kBaseUrl;
    _dio.options.queryParameters = {'serviceKey': kServiceKey1, 'type': 'json'};

    _dio.interceptors.addAll([
      // 로그
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (l) => log(l.toString()),
      ),
      // API 응답 처리 인터셉터
      FlightApiInterceptor(),
      ApiKeyRetryInterceptor(dio: _dio),
    ]);
  }

  // 여객편 운항 현황 - 출발 API
  Future<FlightResponseModel> getPassengerDeparturesOdp({
    String? fromTime,
    String? toTime,
    String? airport,
    String? flightId,
    String? airline,
    String? lang,
  }) async {
    try {
      final response = await _dio.get(
        '/getPassengerDeparturesOdp',
        queryParameters: {
          if (fromTime != null) 'from_time': fromTime,
          if (toTime != null) 'to_time': toTime,
          if (airport != null) 'airport': airport,
          if (flightId != null) 'flight_id': flightId,
          if (airline != null) 'airline': airline,
          if (lang != null) 'lang': lang,
        },
      );

      return FlightResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error is Failure) {
        log('error catch: ${e.error}');
        throw e.error as Failure;
      }

      switch (e.type) {
        case DioException.connectionTimeout:
        case DioException.sendTimeout:
        case DioException.receiveTimeout:
          throw NetworkFailure(message: 'Connection timeout');
        case DioException.connectionError:
          throw NetworkFailure(message: 'No internet connection');
        default:
          throw UnknownFailure(message: e.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }
}
