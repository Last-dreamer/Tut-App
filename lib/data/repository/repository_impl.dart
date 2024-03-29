import 'dart:developer';

import 'package:tut_app/app/di.dart';
import 'package:tut_app/app/functions.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/data/mapper/mapper.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final res = await _remoteDataSource.login(loginRequest);

        if (res.status != ApiInternalStatus.FAILURE) {
          return Right(res.toDomain());
        } else {
          return Left(Failure(
              code: res.status ?? ApiInternalStatus.FAILURE,
              message: res.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        // return Left(ErrorHandler.handler(e).failure);
        // return Left(Failure(code: 400, message: "testing"));
        return Left(getFailure());
      }
    } else {

      return Left(DataSource.NO_INTERNET_ERROR.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      RegisterRequest registerRequest) async {
    log("testing result api }");
    if (await _networkInfo.isConnected) {
      try {
        final res = await _remoteDataSource.register(registerRequest);
        log("testing result api ${res.status}");
        if (res.status != ApiInternalStatus.FAILURE) {
          return Right(res.toDomain());
        } else {
          return Left(Failure(
              code: res.status ?? ApiInternalStatus.FAILURE,
              message: res.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        // log("testing result api left ${e}");
        // return Left(ErrorHandler.handler(e).failure);
        return  Left(getFailure());
      }
    } else {

      return Left(DataSource.NO_INTERNET_ERROR.getFailure());
    }
  }
}
