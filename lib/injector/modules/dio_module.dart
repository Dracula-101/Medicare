import 'package:medicare/injector/injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/util/medicine_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioModule {
  DioModule._();

  static const String medicineInstance = 'medicineInstance';
  static final GetIt _injector = Injector.instance;

  static void setup() {
    _setupDio();
  }

  static void _setupDio() {
    _injector.registerLazySingleton<Dio>(
      () {
        final Dio medicineApiClient = Dio(
          BaseOptions(
            baseUrl: MedicineApi.baseUrl,
            queryParameters: {
              'api_key': MedicineApi.API_KEY,
            },
          ),
        );
        if (!kReleaseMode) {
          medicineApiClient.interceptors.add(
            PrettyDioLogger(
              requestHeader: true,
              requestBody: false,
              responseHeader: false,
              request: false,
            ),
          );
        }
        return medicineApiClient;
      },
      instanceName: medicineInstance,
    );
  }
}
