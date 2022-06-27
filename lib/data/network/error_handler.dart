// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_ERROR,
  DEFAULT
}

class ResponseCode {
  // for api status code
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure api reject the request
  static const int FORBIDDEN = 403; //  failure //
  static const int UNAUTHORIZED = 401; // user is  not authorized
  static const int NOT_FOUND = 404; //  not found
  static const int INTERNAL_SERVER_ERROR = 500; // crash happend in server side

  // for local  status code
  static const int DEFAULT = -1; //
  static const int CONNECT_TIMEOUT = -2; //
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_ERROR = -7;
}

class ResponseMessage {
  // for api status code
  static const String SUCCESS = "Success"; //success with data
  static const String NO_CONTENT =
      "Success with no content"; // success with no content
  static const String BAD_REQUEST =
      "Bad request, try again later"; // failure api reject the request
  static const String FORBIDDEN =
      "Forbidden request, try again later"; //  failure //
  static const String UNAUTHORIZED =
      "User is unauthorized, try again later"; // user is  not authorized
  static const String NOT_FOUND =
      "Url not found, try again later"; //  not found
  static const String INTERNAL_SERVER_ERROR =
      "Something went wrong, try again later"; // crash happend in server side

  // for local  status code
  static const String DEFAULT = "Something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "Time out error, try again later";
  static const String CANCEL = "Request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "Time out error, try again later";
  static const String SEND_TIMEOUT = "Time out error, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_ERROR =
      "Please check your internet connection";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(
            code: ResponseCode.UNAUTHORIZED,
            message: ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            code: ResponseCode.RECEIVE_TIMEOUT,
            message: ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_ERROR:
        return Failure(
            code: ResponseCode.NO_INTERNET_ERROR,
            message: ResponseMessage.NO_INTERNET_ERROR);

      case DataSource.DEFAULT:
        return Failure(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);

      default:
        return Failure(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handler(dynamic error) {
    if (error is DioError) {
      failure = _handler(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handler(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        switch (error.response!.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 0;
}
