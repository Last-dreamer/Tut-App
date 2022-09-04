// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/functions.dart';
import 'package:tut_app/data/network/failure.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000;
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        sendTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: headers);

    if (!kReleaseMode) {
      dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) {
        // log("testing ${e.response!.data['message']}");
        log("testing dio factory ${e.response?.data['message'] ?? "error"}");
        setFailure(e.response?.data['message'] ?? "Error");
        return handler.next(e);
      }));
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}
